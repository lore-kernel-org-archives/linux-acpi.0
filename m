From: "Dino Klein" <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Entering C3 Processor State without a Bus Arbiter
Date: Sat, 17 Jan 2004 13:11:18 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <LAW11-OE13mibfvTqPK00007a1a@hotmail.com>
References: <Law11-OE36TK4GXSNMh0000bd93@hotmail.com> <20040115154555.V73140@root.org> <20040116093055.GE9814@dominikbrodowski.de> <20040116092917.W76365@root.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> On Fri, 16 Jan 2004, Dominik Brodowski wrote:
> > On Thu, Jan 15, 2004 at 03:52:12PM -0800, Nate Lawson wrote:
> > > > After removing the restrictions in the source files, and adding a
WBINVD
> > > > instruction right before the read from P_LVL3 - the processor was
put in
> > > > the C3 state. This is on my Via Apollo Pro133A based Abit VP6 board,
> > > > which does not have a Bus Arbiter. Just for the record, I did pull
out
> > > > the second CPU, so I can do "safer" experimentation.
> > >
> > > WBINVD is too expensive when you're entering C3 hundreds of times per
> > > second.  Try playing back an mp3 while dd'ing a CDROM in PIO mode to
your
> > > hard drive.  Goodbye data, hello backups!  The CPU can't snoop the bus
in
> > > C3.
> >
> > You shouldn't enter C3 at all when the CPU is woken up hundreds of times
per
> > second. Maximum allowed latency is 1ms, IIRC -- you really shouldn't get
> > into this state while dd'ing a CDROM or something else...
> >
> > Problem is, WBINVD might take even longer than 1ms, even though the
maximum
> > I got on my PIII notebook was about 900us...
>
> The processor code in Linux degrades to C2 when the last sleep was less
> than its latency.  So if you have 900 us C3 latency, you can be woken up a
> thousand times a second without degrading to C2.
>
> The other, more important point I was trying to make is that without a BM
> control, he won't get awoken for BM events and there will be DMA
> underruns.  The issue with C3 is both latency and BM events.
>
> -Nate
>

I've tried - for the sake of experimenation - the following:
I've modified the code, so that before entering C3, it sets the
ACPI_BITREG_BUS_MASTER_RLD to Zero, instead of One. Then I did a "dd
if=/dev/hda of=somefile bs=32768 count=16384" to dump 512MB from /dev/hda to
somefile on /dev/hdb. The operation took 125 seconds. The drives are in a
master-slave relationship, and according to info in /proc/ide, hda is set to
UDMA100, and hdb to UDMA66.
All this on my board without the Bus Arbiter, and the addition of the WBINVD
call that I put in right before reading P_LVL3.
There was no indication in the logs as to DMA underruns, and the processors
was entering the C3 state while transferring.

Perhaps I don't totally understand this whole BM thing, so I hope I'm not
saying total nonsense here.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
