using System.Threading.Tasks;
using UserRegistration.Api.Application.DTOs;

namespace UserRegistration.Api.Infrastructure.Repositories
{
    public interface IUserRepository
    {
        Task CreateUserAsync(CreateUserRequestDto request);
    }
}
