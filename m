From: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: Can't Play avi/mov files after S4 Resume
Date: Thu, 11 Mar 2004 12:08:29 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079003309.26171.234.camel@localhost>
References: <C386328088ED7F4E9F81AFBABDDF60DA04A92547@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C386328088ED7F4E9F81AFBABDDF60DA04A92547-Yw6hFe9C1vnHQcBQSaPqJq0fmWJ9l57d0E9HWUfgJXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Cc: "Acpi-List (E-mail)" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Am Do, den 11.03.2004 schrieb Ow Mun Heng um 06:19:
> > > -----Original Message-----
> > > From: Ow Mun Heng 
> > > Hi All,
> > > 
> > > RH9 + D600 + 2.6.3 kernel (acpi-20040211 patch + laptop mode)
> > > suspend is compiled into the kernel
> > > tg3/sound/usb as modules
> >   S4 Suspend and resume works Great
> >
> > > I've tried S1 and S3..no Dice. The suspend works ok.. but 
> > > on powering on.. hard disk spins up.. no Console/X11.
> > > (I guess this is a known issue)
> > > 
> However, I just found out that Video will not work(after
> resuming from S4 suspend). Eg: Playing any
> AVI/MOV etc files. Sound will be Ok but no picture. Xine/Mplayer is 
> the same. 
> It'll work fine once I perform proper reboot.
> Any Ideas?

Is this using X11/XFree86?
If yes then check (after resume) with xvinfo if your XVideo extensions
are still online, I suspect not. Another clue would be to try the x11
mplayer driver instead of the probable deafult xv driver.

If this helps then the video driver of your card is a little broken and
does not reinitialise the XV...

CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
