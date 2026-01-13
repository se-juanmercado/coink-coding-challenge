using System;

namespace UserRegistration.Api.Common.Exceptions
{
    public class BusinessException : Exception
    {
        public BusinessException(String message) : base(message){

        }
    }
}