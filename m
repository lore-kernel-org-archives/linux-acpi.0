From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Compaq Evo800c: s4bios, s3, s4 anybody got this running?
Date: Wed, 12 Mar 2003 14:34:13 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030312133413.GM28131@poup.poupinou.org>
References: <3E6ECB8E.4090706@iis.fhg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E6ECB8E.4090706-XoJDOot2J3yELgA04lAiVw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Christian Neubauer <neu-XoJDOot2J3yELgA04lAiVw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 12, 2003 at 06:54:22AM +0100, Christian Neubauer wrote:
> Hi,
> 
> I use a Compaq Evo800c with 2.4.21-pre5-acpi280303 with patch DSDT 
> tables. Battery, AC, etc. are showing up in /proc/acpi. The system 
> claims to support S3, S4 and S4BIOS. So far so good.
> 
> I tried S4BIOS with the kernel-option acpi_sleep=s4bios as well as the 
> os_name kernel switches (dont remember the excat names of these options ;-)
> 
> As soon I do echo 4 >/proc/acpi/sleep the system clears the console, 
> backlight stays on and the machine hangs.
> 
> Any ideas how to trace this down, or is the behavior known ?
> 
> Is anybody out there who got suspend or standby running on this machine 
> or an presario laptop which is hardware compatibe ?

I highly recommand to test first with minimal drivers (especially
no agp, no dri, no usb, no pcmcia, no fb), and also to test with dma
disabled for ide disks.

something like
hdparm -d0 /dev/hda; hdparm -d0 /dev/hdc (if cdrom)
, before suspending and NOT hdparm -d1 /dev/hda
after resuming.

Then after that, modularize.

The lost of DMA for ide disks for suspending/resuming
purpose is also probably an issue for apm as well
(to be confirmed by Alan Cox, thought).


Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
