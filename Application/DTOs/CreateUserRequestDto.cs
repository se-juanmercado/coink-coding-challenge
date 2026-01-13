using System.ComponentModel.DataAnnotations;
using UserRegistration.Api.Resources;

namespace UserRegistration.Api.Application.DTOs
{
    public class CreateUserRequestDto
    {
        [Required(ErrorMessage = ValidationMessages.RequiredField)]
        [RegularExpression(ValidationMessages.RegexLetters, ErrorMessage = ValidationMessages.OnlyLetters)]
        public string Name { get; set; } = null!;

        [Required(ErrorMessage = ValidationMessages.RequiredField)]
        [RegularExpression(ValidationMessages.RegexNumbers, ErrorMessage = ValidationMessages.OnlyNumbers)]
        [MaxLength(ValidationMessages.PhoneMaxLength, ErrorMessage = ValidationMessages.MaxLength20)]
        public string Phone { get; set; } = null!;

        [Required(ErrorMessage = ValidationMessages.RequiredField)]
        public string Address { get; set; } = null!;

        [Required(ErrorMessage = ValidationMessages.RequiredField)]
        [RegularExpression(ValidationMessages.RegexLetters, ErrorMessage = ValidationMessages.OnlyLetters)]
        public string Country { get; set; } = null!;

        [Required(ErrorMessage = ValidationMessages.RequiredField)]
        [RegularExpression(ValidationMessages.RegexLetters, ErrorMessage = ValidationMessages.OnlyLetters)]
        public string Department { get; set; } = null!;

        [Required(ErrorMessage = ValidationMessages.RequiredField)]
        [RegularExpression(ValidationMessages.RegexLetters, ErrorMessage = ValidationMessages.OnlyLetters)]
        public string Municipality { get; set; } = null!;

        [Required(ErrorMessage = ValidationMessages.RequiredField)]
        public Guid CreatedBy { get; set; }
    }
}