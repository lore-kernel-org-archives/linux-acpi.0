From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] gpio / ACPI: Allow shared GPIO event to be read via operation region
Date: Fri, 30 Oct 2015 12:02:05 +0200
Message-ID: <1446199325-48095-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

In Microsoft Surface3 the GPIO detecting lid state is shared between GPIO
event and operation region. Below is simplied version of the DSDT from
Surface3 including relevant parts:

    Scope (GPO0)
    {
        Name (_AEI, ResourceTemplate ()
        {
            GpioInt (Edge, ActiveBoth, Shared, PullNone, 0x0000,
                "\\_SB.GPO0", 0x00, ResourceConsumer, ,
                )
                {   // Pin list
                    0x004C
                }
        })

        OperationRegion (GPOR, GeneralPurposeIo, Zero, One)
        Field (GPOR, ByteAcc, NoLock, Preserve)
        {
            Connection (
                GpioIo (Shared, PullNone, 0x0000, 0x0000,
                    IoRestrictionNone, "\\_SB.GPO0", 0x00,
                    ResourceConsumer,,)
                    {   // Pin list
                        0x004C
                    }
            ),
            HELD,   1
        }

        Method (_E4C, 0, Serialized)  // _Exx: Edge-Triggered GPE
        {
            If ((HELD == One))
            {
                ^^LID.LIDB = One
            }
            Else
            {
                ^^LID.LIDB = Zero
                Notify (LID, 0x80) // Status Change
            }

            Notify (^^PCI0.SPI1.NTRG, One) // Device Check
        }
    }

When GPIO 0x4c changes we call ASL method _E4C which tries to read HELD
field (the same GPIO). This triggers following error on the console:

    ACPI Error: Method parse/execution failed [\_SB.GPO0._E4C]
        (Node ffff88013f4b4438), AE_ERROR (20150930/psparse-542)

The error happens because ACPI GPIO operation region handler
(acpi_gpio_adr_space_handler()) tries to acquire the very same GPIO which
returns an error (-EBUSY) because the GPIO is already reserved for the GPIO
event.

Fix this so that we "borrow" the event GPIO if we find the GPIO belongs to
an event. Allow this only for GPIOs that are read.

To be able to go through acpi_gpio->events list for operation region access
we need to make sure the list is properly initialized whenever GPIO chip is
registered.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=106571
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 143a9bdbaa53..bbcac3af2a7a 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -304,7 +304,6 @@ void acpi_gpiochip_request_interrupts(struct gpio_chip *chip)
 	if (ACPI_FAILURE(status))
 		return;
 
-	INIT_LIST_HEAD(&acpi_gpio->events);
 	acpi_walk_resources(handle, "_AEI",
 			    acpi_gpiochip_request_interrupt, acpi_gpio);
 }
@@ -603,6 +602,25 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 				break;
 			}
 		}
+
+		/*
+		 * The same GPIO can be shared between operation region and
+		 * event but only if the access here is ACPI_READ. In that
+		 * case we "borrow" the event GPIO instead.
+		 */
+		if (!found && agpio->sharable == ACPI_SHARED &&
+		     function == ACPI_READ) {
+			struct acpi_gpio_event *event;
+
+			list_for_each_entry(event, &achip->events, node) {
+				if (event->pin == pin) {
+					desc = event->desc;
+					found = true;
+					break;
+				}
+			}
+		}
+
 		if (!found) {
 			desc = gpiochip_request_own_desc(chip, pin,
 							 "ACPI:OpRegion");
@@ -719,6 +737,7 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
 	}
 
 	acpi_gpio->chip = chip;
+	INIT_LIST_HEAD(&acpi_gpio->events);
 
 	status = acpi_attach_data(handle, acpi_gpio_chip_dh, acpi_gpio);
 	if (ACPI_FAILURE(status)) {
-- 
2.6.1

