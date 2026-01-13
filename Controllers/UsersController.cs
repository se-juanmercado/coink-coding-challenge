using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using UserRegistration.Api.Application.DTOs;
using UserRegistration.Api.Application.Interfaces;

namespace UserRegistration.Api.Controllers
{
    [ApiController]
    [Route("api/users")]
    public class UsersController : ControllerBase
    {
        private readonly IUserService _userService;

        public UsersController(IUserService userService)
        {
            _userService = userService;
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateUserRequestDto request)
        {
            await _userService.CreateUserAsync(request);
            return Ok(new { message = UserMessages.UserCreated });
        }
    }
}