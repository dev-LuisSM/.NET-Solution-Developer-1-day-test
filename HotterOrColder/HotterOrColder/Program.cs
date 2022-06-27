using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotterOrColder
{
    internal class Program
    {
        static void Main(string[] args)
        {
			Random rdm = new Random();
			int randomNumber = rdm.Next(1, 100);

			Console.WriteLine("I'm thinking of a random number between 1 and 100, can you guess what it is?");
			int guessNumber = 0;
			int tries = 0;

			while (guessNumber != randomNumber)
			{

				Console.Write("Write here your number: ");
				string getNumber = Console.ReadLine();

				if (!int.TryParse(getNumber, out guessNumber))
				{
					Console.WriteLine("That's not a number \n");
					continue;
				}

				if (guessNumber > randomNumber)
					Console.WriteLine("Hotter \n");

				else if (guessNumber < randomNumber)
					Console.WriteLine("Colder \n");

				else if (guessNumber == randomNumber)
					Console.WriteLine("That's the number, it tooked you " + tries + " tries!");

				tries++;
			};
			Console.ReadLine();
		}
    }
}
