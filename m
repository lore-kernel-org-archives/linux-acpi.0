From: "A.MAINS" <armains-ZO4F0KnmCDHk1uMJSBkQmQ@public.gmane.org>
Subject: RE: ACPI Compaq Presario
Date: Mon, 29 Jul 2002 17:51:27 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000301c2374a$19ce8e30$9865fea9@AMAINSLT>
References: <Pine.LNX.4.44.0207292308330.1067-100000@nagada.raceme.loc>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0207292308330.1067-100000-ebPZwV3Hi81W4s3OGYaEKcXXUOn6P5/W@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: 'Christophe Boyanique' <tof-I4ScXmxXXsAdnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thank You so much! I read intel's instructions on this and they made
minimal sense to me as I am not proficient in linux (yet not "newbie").
I will try your steps later and I thank you for taking the time to write
them out!

Andrew

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Christophe
Boyanique
Sent: Monday, July 29, 2002 5:36 PM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] ACPI Compaq Presario

On Mon, 29 Jul 2002, A.MAINS wrote:

> I am running linux on a Compaq Presario 2700US Laptop with Kernel
> 2.4.18 with ACPI Patch 20020726 along with kacpid.patch (which I am
> not sure does anything for my system). This machine in very similar to
> the newer Evo Laptops as well as the Presario 1700 and 700 Line of
> notebooks in terms of the BIOS and hardware configurations.

Try to follow this steps:

- Get Intel tools from
  http://www.intel.com/technology/iapc/acpi/downloads.htm

- Dump your dsdt table with the Intel ACPI tool
  acpidump /proc/acpi/dsdt > dsdt.asl

- You should have obtained a .asl (ACPI Source Language) file. This file
  is bugged and this is your problem. As first pass, check there are PnP
  and others entries like:
  Name(_HID, "*PNP0C0B") and suppress the *

- Get the Intel ACPI compiler and compile your table while ignoring
  errors:
  iasl -tc -i dsdt.asl
  You should get a dsdt.hex file.

- Get your kernel sources and copy this file into drivers/acpi
  drivers/acpi/osl.c and modify the file osl.c file with this patch:

diff -urP drivers/acpi/osl.c /usr/src/linux/drivers/acpi/osl.c
--- drivers/acpi/osl.c  Mon Jul 29 23:30:42 2002
+++ /usr/src/linux/drivers/acpi/osl.c   Sat Jul 27 18:32:34 2002
@@ -71,6 +71,9 @@
 static void *acpi_irq_context = NULL;


+#include "dsdt.hex"
+acpi_table_header *myDST = (acpi_table_header *) AmlCode;
+
 acpi_status
 acpi_os_initialize(void)
 {
@@ -221,7 +224,10 @@
        if (!existing_table || !new_table)
                return AE_BAD_PARAMETER;

-       *new_table = NULL;
+       if (!strncmp(existing_table->signature, DSDT_SIG, 4))
+               *new_table = myDST;
+       else
+               *new_table = NULL;
        return AE_OK;
 }


- Compile your kernel, install, reboot and cross your fingers.

I tested this on an Evo and I got battery status I haven't had before.
There is a lots of others errors in the dsdt table, this is only a
beginning thanks to David Douard.

Christophe.



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
