From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] Documentation: acpi: Add an example for PRP0001
Date: Mon, 25 Mar 2019 10:31:13 +0100
Message-ID: <CAJZ5v0isa7x+XPAregcKtMxtgsNw43JuBhGB_1x3eHkvaV8HRg@mail.gmail.com>
References: <20190322134705.27994-1-thomas.preston@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322134705.27994-1-thomas.preston@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Preston <thomas.preston@codethink.co.uk>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 22, 2019 at 2:47 PM Thomas Preston
<thomas.preston@codethink.co.uk> wrote:
>
> Add an example for the magic PRP0001 device ID which allows matching
> ACPI devices against drivers using OF Device Tree compatible property.
> It wasn't clear to me that PRP0001 could be used in _CID.

Mika, Andy, can you have a look at this, please?

> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
> ---
>  Documentation/acpi/enumeration.txt | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/enumeration.txt
> index 7bcf9c3d9fbe..391db643065a 100644
> --- a/Documentation/acpi/enumeration.txt
> +++ b/Documentation/acpi/enumeration.txt
> @@ -410,6 +410,33 @@ Specifically, the device IDs returned by _HID and preceding PRP0001 in the _CID
>  return package will be checked first.  Also in that case the bus type the device
>  will be enumerated to depends on the device ID returned by _HID.
>
> +For example, the following ACPI sample might be used to enumerate an lm75-type
> +I2C temperature sensor and match it to the driver using the Device Tree
> +namespace link:
> +
> +       Device (TMP0)
> +       {
> +               Name (_HID, "TITMP75") /* _HID will appear in sysfs */
> +               Name (_CID, "PRP0001")
> +               Name (_DSD, Package() {
> +                       ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +                       Package () {
> +                               Package (2) { "compatible", "ti,tmp75" },
> +                       }
> +               })
> +               Method (_CRS, 0, Serialized)
> +               {
> +                       Name (SBUF, ResourceTemplate ()
> +                       {
> +                               I2cSerialBusV2 (0x48, ControllerInitiated,
> +                                       400000, AddressingMode7Bit,
> +                                       "\\_SB.PCI0.I2C1", 0x00,
> +                                       ResourceConsumer, , Exclusive,)
> +                       })
> +                       Return (SBUF)
> +               }
> +       }
> +
>  It is valid to define device objects with a _HID returning PRP0001 and without
>  the "compatible" property in the _DSD or a _CID as long as one of their
>  ancestors provides a _DSD with a valid "compatible" property.  Such device
> --
> 2.11.0
>
