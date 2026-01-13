using System.Threading.Tasks;
using UserRegistration.Api.Application.DTOs;

namespace UserRegistration.Api.Application.Interfaces
{
    public interface IUserService
    {
        Task CreateUserAsync(CreateUserRequestDto request);
    }
}