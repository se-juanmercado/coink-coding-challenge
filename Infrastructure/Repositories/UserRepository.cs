using Dapper;
using Npgsql;
using Microsoft.Extensions.Configuration;
using System.Data;
using System.Threading.Tasks;
using UserRegistration.Api.Application.DTOs;

namespace UserRegistration.Api.Infrastructure.Repositories {
  public class UserRepository: IUserRepository {
    private readonly IConfiguration _configuration;

    public UserRepository(IConfiguration configuration) {
      _configuration = configuration;
    }

    public async Task CreateUserAsync(CreateUserRequestDto request) {
      using
      var connection = new NpgsqlConnection(
        _configuration.GetConnectionString("DefaultConnection"));

      var parameters = new DynamicParameters();
      parameters.Add("p_name", request.Name);
      parameters.Add("p_phone", request.Phone);
      parameters.Add("p_address", request.Address);
      parameters.Add("p_country_name", request.Country);
      parameters.Add("p_department_name", request.Department);
      parameters.Add("p_municipality_name", request.Municipality);
      parameters.Add("p_created_by", request.CreatedBy, DbType.Guid);

      // Parámetro de salida para recibir el ID generado
      parameters.Add("p_user_id", dbType: DbType.Guid, direction: ParameterDirection.InputOutput);

      const string sql = "CALL public.sp_create_user(@p_name, @p_phone, @p_address, @p_country_name, @p_department_name, @p_municipality_name, @p_created_by, @p_user_id)";

      await connection.ExecuteAsync(sql, parameters);

      var newUserId = parameters.Get < Guid > ("p_user_id");
    }
  }
}
