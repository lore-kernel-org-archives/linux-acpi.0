From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Entering C3 Processor State without a Bus Arbiter
Date: Fri, 16 Jan 2004 09:33:05 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040116092917.W76365@root.org>
References: <Law11-OE36TK4GXSNMh0000bd93@hotmail.com> <20040115154555.V73140@root.org>
 <20040116093055.GE9814@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040116093055.GE9814-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: Dino Klein <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 16 Jan 2004, Dominik Brodowski wrote:
> On Thu, Jan 15, 2004 at 03:52:12PM -0800, Nate Lawson wrote:
> > > After removing the restrictions in the source files, and adding a WBINVD
> > > instruction right before the read from P_LVL3 - the processor was put in
> > > the C3 state. This is on my Via Apollo Pro133A based Abit VP6 board,
> > > which does not have a Bus Arbiter. Just for the record, I did pull out
> > > the second CPU, so I can do "safer" experimentation.
> >
> > WBINVD is too expensive when you're entering C3 hundreds of times per
> > second.  Try playing back an mp3 while dd'ing a CDROM in PIO mode to your
> > hard drive.  Goodbye data, hello backups!  The CPU can't snoop the bus in
> > C3.
>
> You shouldn't enter C3 at all when the CPU is woken up hundreds of times per
> second. Maximum allowed latency is 1ms, IIRC -- you really shouldn't get
> into this state while dd'ing a CDROM or something else...
>
> Problem is, WBINVD might take even longer than 1ms, even though the maximum
> I got on my PIII notebook was about 900us...

The processor code in Linux degrades to C2 when the last sleep was less
than its latency.  So if you have 900 us C3 latency, you can be woken up a
thousand times a second without degrading to C2.

The other, more important point I was trying to make is that without a BM
control, he won't get awoken for BM events and there will be DMA
underruns.  The issue with C3 is both latency and BM events.

-Nate


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
