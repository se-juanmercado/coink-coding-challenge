using Microsoft.AspNetCore.Http;
using Npgsql;
using System;
using System.Net;
using System.Text.Json;
using System.Threading.Tasks;

namespace UserRegistration.Api.Common.Exceptions
{
    public class ExceptionMiddleware
    {
        private readonly RequestDelegate _next;

        public ExceptionMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            try
            {
                await _next(context);
            }
            catch (PostgresException ex)
            {
                // Errores lanzados desde el SP
                context.Response.StatusCode = (int)HttpStatusCode.BadRequest;
                context.Response.ContentType = "application/json";

                var response = new
                {
                      error = ex.MessageText
                };

                await context.Response.WriteAsync(JsonSerializer.Serialize(response));
            }
            catch (BusinessException ex)
            {
                context.Response.StatusCode = (int)HttpStatusCode.BadRequest;
                context.Response.ContentType = "application/json";

                await context.Response.WriteAsync(
                    JsonSerializer.Serialize(new { error = ex.Message })
                );
            }
            catch (Exception)
            {
                context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
                context.Response.ContentType = "application/json";

                await context.Response.WriteAsync(
                    JsonSerializer.Serialize(new { error = "Error interno del servidor" })
                );
            }
        }
    }
}