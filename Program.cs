using Microsoft.AspNetCore.Mvc;
using UserRegistration.Api.Application.Interfaces;
using UserRegistration.Api.Application.Services;
using UserRegistration.Api.Infrastructure.Repositories;
using UserRegistration.Api.Common.Exceptions;



var builder = WebApplication.CreateBuilder(args);

// Agregar servicios al conteendor
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<IUserRepository, UserRepository>();

/* INICIO - Bloque para extraer mensaje que .NET detecta automaticamente para gestionarlos */
builder.Services.Configure<ApiBehaviorOptions>(options =>
{
    options.InvalidModelStateResponseFactory = context =>
    {
        // Extraemos y formateamos los errores del ModelState para que coincidan con la esturctura propuesta en ExceptionMiddleware
        var errors = context.ModelState
            .Where(e => e.Value?.Errors.Count > 0)
            .ToDictionary(
                // Limpiamos el nombre del campo quitando el prefijo "$." que a veces agrega el deserializador
                kvp => kvp.Key.Replace("$.", ""),
                kvp => kvp.Value?.Errors
                    .Select(g => 
                    {
                        var msg = g.ErrorMessage ?? "";
                        
                        // Si la excepción es de tipo JsonException, es porque el tipo de dato no coincide 
                        // (Ejemplo: Cualquier dato enviado en el uuid del request)
                        if (g.Exception is System.Text.Json.JsonException || msg.Contains("could not be converted"))
                            return "El formato del dato es incorrecto.";
                        
                        // Homologamos el mensaje de campos obligatorios a español
                        if (msg.Contains("is required")) 
                            return "El campo es obligatorio";
                        
                        return msg;
                    })
                    .Distinct() // Evitamos mensajes duplicados en el mismo campo
                    .ToArray() ?? Array.Empty<string>()
            );

        // Creamos la respuesta usando ValidationProblemDetails para seguir el estándar
        var problemDetails = new ValidationProblemDetails(errors)
        {
            Type = "https://tools.ietf.org/html/rfc9110#section-15.5.1",
            Title = "One or more validation errors occurred.",
            Status = StatusCodes.Status400BadRequest
        };

        // Mantenemos la consistencia del TraceId usando el formato de diagnóstico de .NET
        var traceId = System.Diagnostics.Activity.Current?.Id ?? context.HttpContext.TraceIdentifier;
        problemDetails.Extensions.Add("traceId", traceId);

        return new BadRequestObjectResult(problemDetails);
    };
});
/* FIN - Bloque para extraer mensaje que .NET detecta automaticamente para gestionarlos */


var app = builder.Build();

app.UseMiddleware<ExceptionMiddleware>();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.MapControllers();
app.Run();
