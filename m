From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Resume from suspend-to-ram (radeon)
Date: Fri, 23 Apr 2004 12:08:36 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404231208.36032.stefandoesinger@gmx.at>
References: <c15rn0$5bu$2@sea.gmane.org> <200404021524.46611.stefandoesinger@gmx.at> <20040420101720.GA2314@elf.ucw.cz>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040420101720.GA2314-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Luca Capello <luca-wlebWZzHoyE@public.gmane.org>, Giridhar Pemmasani <giri-IxWJ8JVbGpr5NRxSJurNR4dd74u8MsAO@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

> > The radeonfb resume does not crash, but when fbcon is loaded something
> > fails. Compile radeonfb(original version, 2.6.4 kernel) and frame buffer
> > console as modules, disable video mode selection support and load only
> > radeonfb(NOT fbcon) and the system will resume with backlight on and a
> > black screen. At least my device does in single user mode.
> >
> > I use plain text console and X with int10 POST patch. This gives me the
> > console back when resuming(X has to soft-boot the V-Bios).
>
> Perhaps some hints how to do this should be added to
> Documentation/power/video.txt?
>
> 									Pavel
Patching X11 or that radeonfb crashes on resume?
I wrote a howto about S3 on the Acer TM 800 which covers the radeon problem:
http://www.doesi.gmxhome.de/linux/tm800s3/s3.html

/Stefan


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
