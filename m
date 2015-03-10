From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] gpio / ACPI: Use local variable instead of ACPI_HANDLE()
Date: Tue, 10 Mar 2015 23:10:01 +0100
Message-ID: <15697166.UNaCUJRTg5@vostro.rjw.lan>
References: <4032246.STUT1iRmIk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4032246.STUT1iRmIk@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In acpi_gpiochip_request_interrupts() the handle local
variable already contains the value that we want to pass
to acpi_walk_resources(), so it is better to use that
variable instead of evaluating ACPI_HANDLE() once more
for the same device.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/gpio/gpiolib-acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/gpio/gpiolib-acpi.c
===================================================================
--- linux-pm.orig/drivers/gpio/gpiolib-acpi.c
+++ linux-pm/drivers/gpio/gpiolib-acpi.c
@@ -300,7 +300,7 @@ void acpi_gpiochip_request_interrupts(st
 		return;
 
 	INIT_LIST_HEAD(&acpi_gpio->events);
-	acpi_walk_resources(ACPI_HANDLE(chip->dev), "_AEI",
+	acpi_walk_resources(handle, "_AEI",
 			    acpi_gpiochip_request_interrupt, acpi_gpio);
 }
 
