From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Problems installing ACPI
Date: Tue, 21 Jan 2003 14:29:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030121132926.GB15023@poup.poupinou.org>
References: <1043083690.1702.15.camel@localhost.localdomain> <3E2C43D3.3020307@gmx.net> <3E2C70FB.1090905@gmx.net> <1043147191.1205.8.camel@gregers.imsb.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1043147191.1205.8.camel-bkBLLvNVh9RMk0OslVgrwH9LOBIZ5rWg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Christian Brix Folsted Andersen <folsted-TJNDrJVYK8B/SzgSGea1oA@public.gmane.org>
Cc: Heiko Ettelbrueck <hbruckynews-hi6Y0CQ0nG0@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 21, 2003 at 12:06:30PM +0100, Christian Brix Folsted Andersen wrote:
> Hi Heiko
> 
> Thank you so much for your help.
> 
> However i am having a bit of a problem applying your patch. The file
> drivers/acpi/osl.c does not exist instead there is a file called os.c.
> I looked at the file and tried to patch it manualy, but can not find the
> position of the last part of the patch.
> 
> The first part was added at line 85 of os.c
> 
> static int acpi_irq_irq = 0;
> static OSD_HANDLER acpi_irq_handler = NULL;
> static void *acpi_irq_context = NULL;
> 
> extern unsigned char AmlCode[];
> 
> In which function is the last part supposed to go?
> Which kernel did you use?
> 

You use the vanilla kernel.  Not a kernel with the latest
ACPI patch.  For the vanilla one, you have to use the
workaround found at 
http://developer.intel.com/technology/iapc/acpi/bios_override.htm

but you actually should first consider to patch your
kernel found at http://www.sf.net/projects/acpi/

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
