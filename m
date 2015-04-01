From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH] Documentation: gpio: Update ACPI part of the document to
 mention _DSD
Date: Tue, 31 Mar 2015 17:19:21 -0700
Message-ID: <D14086D9.C4A08%dvhart@linux.intel.com>
References: <1427802195-221906-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1427802195-221906-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 3/31/15, 4:43 AM, "Mika Westerberg" <mika.westerberg@linux.intel.com>
wrote:

>With ACPI 5.1 _DSD (Device Specific Data) it is now possible to name
>functions just like Device Tree is doing. Make sure that the documentation
>mentions _DSD as the recommended way to describe GPIOs in ACPI systems.
>
>Reported-by: Darren Hart <dvhart@linux.intel.com>
>Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks Mika! Couple of nits below to help it read a little better.

>---
> Documentation/gpio/board.txt | 41
>+++++++++++++++++++++++++++++++++++++----
> 1 file changed, 37 insertions(+), 4 deletions(-)
>
>diff --git a/Documentation/gpio/board.txt b/Documentation/gpio/board.txt
>index 8b35f51fe7b6..b68cfa8a6865 100644
>--- a/Documentation/gpio/board.txt
>+++ b/Documentation/gpio/board.txt
>@@ -50,10 +50,43 @@ gpiod_is_active_low(power) will be true).
> 
> ACPI
> ----
>-ACPI does not support function names for GPIOs. Therefore, only the "idx"
>-argument of gpiod_get_index() is useful to discriminate between GPIOs
>assigned
>-to a device. The "con_id" argument can still be set for debugging
>purposes (it
>-will appear under error messages as well as debug and sysfs nodes).
>+ACPI does also support function names for GPIOs in similar fashion than
>DT.

ACPI also supports function names for GPIOs in a similar fashion to DT.

>+The above DT example can be converted to corresponding ACPI version with

... to an equivalent ACPI description with

>+the help of _DSD (Device Specific Data) which was introduced in ACPI 5.1:


s/ which was/, /


--
Darren

>+
>+	Device (FOO) {
>+		Name (_CRS, ResourceTemplate () {
>+			GpioIo (Exclusive, ..., IoRestrictionOutputOnly,
>+				"\\_SB.GPI0") {15} // red
>+			GpioIo (Exclusive, ..., IoRestrictionOutputOnly,
>+				"\\_SB.GPI0") {16} // green
>+			GpioIo (Exclusive, ..., IoRestrictionOutputOnly,
>+				"\\_SB.GPI0") {17} // blue
>+			GpioIo (Exclusive, ..., IoRestrictionOutputOnly,
>+				"\\_SB.GPI0") {1} // power
>+		})
>+
>+		Name (_DSD, Package () {
>+			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>+			Package () {
>+				Package () {
>+					"led-gpios",
>+					Package () {
>+						^FOO, 0, 0, 1,
>+						^FOO, 1, 0, 1,
>+						^FOO, 2, 0, 1,
>+					}
>+				},
>+				Package () {
>+					"power-gpios",
>+					Package () {^FOO, 3, 0, 0},
>+				},
>+			}
>+		})
>+	}
>+
>+For more information about the ACPI GPIO bindings see
>+Documentation/acpi/gpio-properties.txt.
> 
> Platform Data
> -------------
>-- 
>2.1.4
>
>


-- 
Darren Hart
Intel Open Source Technology Center



