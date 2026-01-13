using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using UserRegistration.Api.Application.DTOs;
using UserRegistration.Api.Application.Interfaces;
using UserRegistration.Api.Common;

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
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ValidationProblemDetails))]
        [ProducesResponseType(StatusCodes.Status500InternalServerError, Type = typeof(ProblemDetails))]
        public async Task<IActionResult> Create([FromBody] CreateUserRequestDto request)
        {
            await _userService.CreateUserAsync(request);
            return Ok(new { message = UserMessages.UserCreated });
        }
    }
}