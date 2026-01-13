namespace UserRegistration.Api.Resources
{
    public class ValidationMessages
    {
        // Mensajes
        public const string OnlyLetters = "Solo se permiten letras";
        public const string OnlyNumbers = "Solo se permiten números";
        public const string RequiredField = "Este campo es obligatorio";
        public const string MaxLength20 = "El campo no puede superar los 20 caracteres";

        // Expresiones Regulares
        public const string RegexLetters = @"^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+$";
        public const string RegexNumbers = @"^\d+$";

        public const int PhoneMaxLength = 20;
    }
}