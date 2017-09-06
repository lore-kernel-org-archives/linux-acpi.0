From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] gpio: acpi: work around false-positive -Wstring-overflow warning
Date: Wed,  6 Sep 2017 17:47:45 +0200
Message-ID: <20170906154756.2133726-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Wei Yongjun <weiyongjun1@huawei.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

gcc-7 notices that the pin_table is an array of 16-bit numbers,
but fails to take the following range check into account:

drivers/gpio/gpiolib-acpi.c: In function 'acpi_gpiochip_request_interrupt':
drivers/gpio/gpiolib-acpi.c:206:24: warning: '%02X' directive writing between 2 and 4 bytes into a region of size 3 [-Wformat-overflow=]
   sprintf(ev_name, "_%c%02X",
                        ^~~~
drivers/gpio/gpiolib-acpi.c:206:20: note: directive argument in the range [0, 65535]
   sprintf(ev_name, "_%c%02X",
                    ^~~~~~~~~
drivers/gpio/gpiolib-acpi.c:206:3: note: 'sprintf' output between 5 and 7 bytes into a destination of size 5
   sprintf(ev_name, "_%c%02X",
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    agpio->triggering == ACPI_EDGE_SENSITIVE ? 'E' : 'L',
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    pin);
    ~~~~

As suggested by Andy, this changes the format string to have a fixed length.
Since modifying the range check did not help, I also opened a bug against
gcc, see link below.

Fixes: 0d1c28a449c6 ("gpiolib-acpi: Add ACPI5 event model support to gpio.")
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patchwork.kernel.org/patch/9840801/
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82123
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpiolib-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 4d2113530735..eb4528c87c0b 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -203,7 +203,7 @@ static acpi_status acpi_gpiochip_request_interrupt(struct acpi_resource *ares,
 
 	if (pin <= 255) {
 		char ev_name[5];
-		sprintf(ev_name, "_%c%02X",
+		sprintf(ev_name, "_%c%02hhX",
 			agpio->triggering == ACPI_EDGE_SENSITIVE ? 'E' : 'L',
 			pin);
 		if (ACPI_SUCCESS(acpi_get_handle(handle, ev_name, &evt_handle)))
-- 
2.9.0
