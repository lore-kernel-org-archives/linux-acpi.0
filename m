From: John Knottenbelt <jak97-CezfXpuMXD6Fxr2TtlUqVg@public.gmane.org>
Subject: Re: Kernel 2.6-test10 and /sys/power/state on Thinkpad R32
Date: Wed, 3 Dec 2003 17:46:34 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200312031746.34271.jak97@doc.ic.ac.uk>
References: <1069851924.3708.4.camel@hogfather.northernmaniacs.com> <20031201201329.GA206@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031201201329.GA206-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Stephan Herhut <sah-jNDFPZUTrfRKC+uPiMyuuyYxWCU7E+c1@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 01 December 2003 20:13, Pavel Machek wrote:
> Hi!
>
> > I gave kernel 2.6-test10 a try to test the long-awaited suspend to
> > ram/disk. I am using fedora core 1 on a ThinkPad R32 with the newest
> > BIOS available. Everythings works fine, except suspending my thinkpad.
> >
> > echo {ram|disk} > /sys/power/state
> >
> > just yields a Preparing for suspend kernel message and afterwards
> > nothing happens. I can even retry as often as I want to, always only
> > producing this message.
> >
> > I use the current kernel rpm from people.radhat.com/arjanv.
> >
> > Anyone something to try or is this already known?
>
> Try echo 4 > /proc/acpi/sleep on vanilla kernel.

Also try:

echo -n ram > /sys/power/state

I think the -n is important.

John



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
