From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Resume from suspend-to-ram (radeon)
Date: Fri, 2 Apr 2004 15:24:46 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404021524.46611.stefandoesinger@gmx.at>
References: <c15rn0$5bu$2@sea.gmane.org> <20040223074227.80AE57831D@mail.lmc.cs.sunysb.edu> <406ABD4A.10408@pca.it>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <406ABD4A.10408-wlebWZzHoyE@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>, Giridhar Pemmasani <giri-IxWJ8JVbGpr5NRxSJurNR4dd74u8MsAO@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
I have slightly different experiances with suspend to ram and the radeon card 
on my Acer Travelmate 803 notebook:
> on 02/23/04 08:42, Giridhar Pemmasani wrote:
> > New radeonfb suspend/resume code turns the LCD on but the system hangs
> > during fb resume. With the changes I made, the LCD turns on but the
> > screen remains blank. X with int10 POST restores the screen properly.
The radeonfb resume does not crash, but when fbcon is loaded something fails. 
Compile radeonfb(original version, 2.6.4 kernel) and frame buffer console as 
modules, disable video mode selection support and load only radeonfb(NOT 
fbcon) and the system will resume with backlight on and a black screen. At 
least my device does in single user mode.

I use plain text console and X with int10 POST patch. This gives me the 
console back when resuming(X has to soft-boot the V-Bios).

> One possible solution for 'intel8x0' suspend/resume problem is here
>   
> http://sourceforge.net/mailarchive/forum.php?thread_id=4107033&forum_id=175
>2
i810_audio doesn't work for me too. Any call to pci_enable_device(), 
pci_write_config_byte/word/dword() and pci_restore_state() causes a 
system(bios?) lockup. This only concerns the audio card, and strangely I can 
change the pci settings with setpci and bring my card back, i810_audio unload 
of course.
I think oss has a better sound quality, especially with a high volume.

Cheers,
Stefan


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
