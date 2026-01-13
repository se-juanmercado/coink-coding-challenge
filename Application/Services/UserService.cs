using System.Threading.Tasks;
using UserRegistration.Api.Application.DTOs;
using UserRegistration.Api.Application.Interfaces;
using UserRegistration.Api.Infrastructure.Repositories;

namespace UserRegistration.Api.Application.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _repository;

        public UserService(IUserRepository repository)
        {
            _repository = repository;
        }

        public async Task CreateUserAsync(CreateUserRequestDto request)
        {
            await _repository.CreateUserAsync(request);
        }
    }
}
