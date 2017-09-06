From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] gpio: acpi: work around false-positive
 -Wstring-overflow warning
Date: Wed, 06 Sep 2017 08:52:53 -0700
Message-ID: <1504713173.7546.3.camel@perches.com>
References: <20170906154756.2133726-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170906154756.2133726-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Wei Yongjun <weiyongjun1@huawei.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2017-09-06 at 17:47 +0200, Arnd Bergmann wrote:
> gcc-7 notices that the pin_table is an array of 16-bit numbers,
> but fails to take the following range check into account:
> 
> drivers/gpio/gpiolib-acpi.c: In function 'acpi_gpiochip_request_interrupt':
> drivers/gpio/gpiolib-acpi.c:206:24: warning: '%02X' directive writing between 2 and 4 bytes into a region of size 3 [-Wformat-overflow=]
>    sprintf(ev_name, "_%c%02X",
>                         ^~~~
> drivers/gpio/gpiolib-acpi.c:206:20: note: directive argument in the range [0, 65535]
>    sprintf(ev_name, "_%c%02X",
>                     ^~~~~~~~~
> drivers/gpio/gpiolib-acpi.c:206:3: note: 'sprintf' output between 5 and 7 bytes into a destination of size 5
>    sprintf(ev_name, "_%c%02X",
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>     agpio->triggering == ACPI_EDGE_SENSITIVE ? 'E' : 'L',
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     pin);
>     ~~~~
> 
> As suggested by Andy, this changes the format string to have a fixed length.
> Since modifying the range check did not help, I also opened a bug against
> gcc, see link below.

The code has

	int pin

does changing pin to unsigned int matter?

> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
[]
> @@ -203,7 +203,7 @@ static acpi_status acpi_gpiochip_request_interrupt(struct acpi_resource *ares,
>  
>  	if (pin <= 255) {
>  		char ev_name[5];
> -		sprintf(ev_name, "_%c%02X",
> +		sprintf(ev_name, "_%c%02hhX",
>  			agpio->triggering == ACPI_EDGE_SENSITIVE ? 'E' : 'L',
>  			pin);
>  		if (ACPI_SUCCESS(acpi_get_handle(handle, ev_name, &evt_handle)))
