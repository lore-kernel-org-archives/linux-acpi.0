From: Nikolaus Filus <nfilus-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: SMBus controller listed in DSDT, hidden with lspci
Date: Mon, 14 Feb 2005 17:18:25 +0100
Message-ID: <20050214161823.GA25606@wsc-gmbh.de>
References: <420D758E.8020604@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <420D758E.8020604-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 12, 2005 at 04:18:38AM +0100, Carl-Daniel Hailfinger wrote:
>Hi,
>
>my Samsung P35 notebook has a strange quirk: The SMBus
>controller doesn't show up in lspci, but the DSDT claims
>it is there. Are there any chances to unhide it with a
>special hack or something?
>
>Atached is my disassembled DSDT and the output of lspci.
>
>The device 0000:00:1f.3, which should be the SMBus
>controller, simply doesn't show up in lspci.
>I suspect it to be something like
>0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 03)

found a patch on www.p35-forum.de and applied it, now using lm90 driver
I can read temperature values for 2 thermal zones (different values from the ACPI ones)
in /sys/bus/i2c/... but writing to them shows still no result. I can't tune the fan
on/off values :(

Nikolaus


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="smbus-2.6.11rc3.patch"

--- linux/drivers/pci/quirks.c.org	2005-02-14 14:49:18.000000000 +0100
+++ linux/drivers/pci/quirks.c	2005-02-14 14:51:37.000000000 +0100
@@ -791,6 +791,12 @@
 			case 0x12bc: /* HP D330L */
 				asus_hides_smbus = 1;
 			}
+       } else if (unlikely(dev->subsystem_vendor == 0x144d)) {
+               if (dev->device ==  PCI_DEVICE_ID_INTEL_82855PM_HB)
+                       switch(dev->subsystem_device) {
+                       case 0xC00C: /* Samsung P35 */
+                               asus_hides_smbus = 1;
+                       }
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB,	asus_hides_smbus_hostbridge );

--2oS5YaxWCcQjTEyO--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
