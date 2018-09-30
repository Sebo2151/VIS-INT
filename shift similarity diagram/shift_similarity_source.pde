/*
  Processing.js code for "Shift similarity diagram" of primes mod n

  Written by Sebastian Bozlee on 9/28/2018
  Email: sebastian dot bozlee AT colorado dot edu 
*/

// Global variables
int size_o_screen = 1000;
int modulus = 3;
int[] primes;
PImage img;

void setupPrimes(int num_primes)
{
    primes = new int[num_primes];
    int insertion_point = 0;
    
    for (int n = 2; insertion_point < num_primes; n++)
    {
        bool n_looks_prime = true;
        for (int i = 0; i < insertion_point; i++)
        {
            if (n % primes[i] == 0)
            {
                // Failed the divisibility test. Try next n.
                n_looks_prime = false;
                continue;
            }
        }
        
        if (n_looks_prime)
        {
            // Passed the divisibility test. Record n.
            primes[insertion_point] = n;
            insertion_point++;
        }
    }
}

// Setup the Processing Canvas
void setup()
{
    size( size_o_screen, size_o_screen );
    frameRate( 15 );
  
    PFont fontA = loadFont("courier");
    textFont(fontA, 14);  
  
    setupPrimes(2*size_o_screen);
  
    // allocate image ahead of time - reduces lag
    img = createImage(size_o_screen, size_o_screen, RGB);
}

// Main draw loop
void draw()
{
    // Faster to draw to an image first than directly on the screen.
    for (int x = 0; x < size_o_screen; x++)
    {
        for (int y = 0; y < size_o_screen; y++)
        {
            if (x + y > 2*size_o_screen)
            {
                img.pixels[size_o_screen*y + x] = color(120);
            }
            else if ((primes[x + y] - primes[x]) % modulus == 0)
            {
                img.pixels[size_o_screen*y + x] = color(255);
            }
            else
            {
                img.pixels[size_o_screen*y + x] = color(0);
            }
        }
    }
  
    image(img, 0, 0);
  
    fill(0);
    rect(size_o_screen - 355, size_o_screen - 36, 330, 14);
    fill(255);
    text("shift similarity of primes mod m = " + modulus, size_o_screen - 350, size_o_screen - 25);
  
    if (mousePressed && (mouseButton == LEFT))
        modulus++;
    else if (mousePressed && (mouseButton == RIGHT))
    {
        if (modulus > 3)
            modulus--;
    }
}


