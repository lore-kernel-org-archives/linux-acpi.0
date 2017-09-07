From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] gpio: acpi: work around false-positive -Wstring-overflow
 warning
Date: Thu, 7 Sep 2017 09:50:59 +0300
Message-ID: <20170907065059.GD2477@lahna.fi.intel.com>
References: <20170906154756.2133726-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27253 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752021AbdIGG5f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Sep 2017 02:57:35 -0400
Content-Disposition: inline
In-Reply-To: <20170906154756.2133726-1-arnd@arndb.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Wei Yongjun <weiyongjun1@huawei.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 06, 2017 at 05:47:45PM +0200, Arnd Bergmann wrote:
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
> 
> Fixes: 0d1c28a449c6 ("gpiolib-acpi: Add ACPI5 event model support to gpio.")
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Link: https://patchwork.kernel.org/patch/9840801/
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82123
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
