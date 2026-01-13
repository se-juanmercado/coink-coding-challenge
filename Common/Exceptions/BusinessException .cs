using System;

namespace UserRegistration.Api.Common.Exceptions
{
    public class BusinessException : Exception
    {
        public BusinessException(string message) : base(message)
        {
            // El mensaje se pasa a la clase base (Exception) 
            // para que luego el Middleware lo lea con .Message
        }
    }
}