From: Christian Brix Folsted Andersen <folsted-TJNDrJVYK8B/SzgSGea1oA@public.gmane.org>
Subject: Re: Problems installing ACPI
Date: 21 Jan 2003 12:06:30 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1043147191.1205.8.camel@gregers.imsb.au.dk>
References: <1043083690.1702.15.camel@localhost.localdomain>
	<3E2C43D3.3020307@gmx.net>  <3E2C70FB.1090905@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E2C70FB.1090905-hi6Y0CQ0nG0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Heiko Ettelbrueck <hbruckynews-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Heiko

Thank you so much for your help.

However i am having a bit of a problem applying your patch. The file
drivers/acpi/osl.c does not exist instead there is a file called os.c.
I looked at the file and tried to patch it manualy, but can not find the
position of the last part of the patch.

The first part was added at line 85 of os.c

static int acpi_irq_irq = 0;
static OSD_HANDLER acpi_irq_handler = NULL;
static void *acpi_irq_context = NULL;

extern unsigned char AmlCode[];

In which function is the last part supposed to go?
Which kernel did you use?

regards Christian



On Mon, 2003-01-20 at 22:58, Heiko Ettelbrueck wrote:
> Hi Christian,
> 
> > Steps:
> > - Get a fixed DSDT. You could try mine from 
> > http://www.ettelbrueck.de/linux-acpi/compaq-evo-n160/acpi_dsdt.asl , but 
> > you should alter it to fit to your battery. I've coded the current 
> > maximum capacity of my battery (3357 mAh instead of 4000 mAh for a new 
> > battery) into it - see my posting of 14 december 2002 for details about 
> > the battery part.
> 
> I've updated the DSDT files on my web server concerning the maximum and 
> last known capacity of the battery: Both are now set to the default 
> value of 4000 mAh, so there's no longer a need for you to change anything.
> 
> > - Compile your DSDT with Intel's ASL compiler into a c source code file 
> > and copy it to kernel-src-dir/drivers/acpi/tables/acpi_dsdt.c.
> 
> You can now skip this part and directly use
> http://www.ettelbrueck.de/linux-acpi/compaq-evo-n160/acpi_dsdt.c
> 
> > - [Don't know by heart if this is needed with current acpi patches] 
> > Apply a patch to your kernel that makes it use your DSDT.
> 
> I found the patch I used to make my kernel use my fixed DSDT. You can 
> download it from
> http://www.ettelbrueck.de/linux-acpi/compaq-evo-n160/acpi_use_own_dsdt-2.4.20.diff
> 
> > - Compile your kernel once again.
> > - Boot it...
> 
> These two steps are obviously still needed ;-)
> 
> Kind regards
> Heiko




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
