From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: S1 Suspend almost working with 2.4.19 and 2.5.44 on Travelmate 360
Date: Thu, 31 Oct 2002 12:03:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021031110318.GA27413@poup.poupinou.org>
References: <3DC0837E.4050305@virgin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3DC0837E.4050305-J1btbF6uMEmsTnJN9+BGXg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Phil Messenger <phil.mes-J1btbF6uMEmsTnJN9+BGXg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Oct 31, 2002 at 01:12:30AM +0000, Phil Messenger wrote:
> After much fiddling, I've almost got S1 suspend working on the above 
> system, with one caveat:
> 
> 2.4.19 and 2.4.20-(pre11 | rc1):
> 
> System suspends, backlight isn't turned off. System resumes and is 
> active on the network, so I can SSH into it, but the keyboard and 
> touchpad apparently aren't reinitialised properly and won't respond. 
> Note that the system hasn't hung, but the keyboard and mouse are "frozen".
> 
> 2.5.44:
> 
> System suspends, backlight isn't turned off, system resumes and is 
> active on the network. The keyboard is again hung, but if I cycle the 
> input drivers (rmmod then modprobe i8042, atkbd) it responds again. I've 
> actually written a small script which turns the backlight off using 
> DPMS, suspends the system, then cycles the input drivers on resume. I'd 
> much rather use 2.4 though - PCMCIA is utterly broken on this machine in 
> 2.5, wheras it's only a bit broken in 2.4.
> 
> Is this a known problem? If so, are there any work-arounds? Or if it 
> isn't, is there anything I can do to help debug it? I don't know much 
> about ACPI and the Linux implemntation and I don't have enough time to 
> sit down and understand it so I'm not sure where to start...
> Cheers,

There is two way that you can try:
1- if you use gpm, try to see if disabling it can help (there
is also a little workaround, but I do not remember which)
2- try to do as if you were under Windows NT, by changing
\_OS.  You can do that in the ASL, or in the source in

linux/drivers/acpi/include/platform/aclinux
change the line:

#define ACPI_OS_NAME		"Linux"
by:

#define ACPI_OS_NAME		 "Microsoft Windows NT"

The '2-' alone helped me in order to have a proper S1 support,
and is now in my ASL so that I do not have to redo this change. 

A better workaround should be to reinitialize the AUX driver.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
