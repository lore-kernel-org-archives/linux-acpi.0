From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: System indicators APM/ACPI
Date: Tue, 30 Sep 2003 10:38:25 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030930103258.V81128@root.org>
References: <20030929125921.A78167@root.org> <20030930170308.GD11391@poupinou.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030930170308.GD11391-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 30 Sep 2003, Ducrot Bruno wrote:
> On Mon, Sep 29, 2003 at 01:00:40PM -0700, Nate Lawson wrote:
> > In suspending my T23, I found an interesting issue.  When suspending with
> > APM on FreeBSD, the "suspended" light comes on.  When suspending on
> > Windows 2k, it also comes on.  When suspending with ACPI on FreeBSD, it
> > does not come on even though it suspends/resumes fine.  Is Win2k
> > suspending via APM even though it is using ACPI for other features?  I am
> > certain it is using ACPI by checking in the driver info window.
> >
> > I figured this might have something to do with \_SI\_SST since my laptop
> > has that.  But running \_SI\_SST with various args never changes any
> > lights.  ASL:  http://root.org/~nate/acpi/ibm-acpidump.asl.gz
> >
> > Ideas?
> >
> > BTW, would it be a good idea to add code to call \_SI\_SST to the ACPICA
> > AcpiSetSleepState() function?
>
> Current spec (2.0c) state that arguments for _SST are (10.1.1, page 254):
>
> 0- no system state.  Indicator off.
> 1- Working.
> 2- Waking.
> 3- Sleeping, Used to indicate system state S1, S2 or S3.
> 4- Sleeping with context saved to non-volatile storage.
>
> So, for system state 4, you should pass argument 4 (but just
> before calling AcpiSetSleepState() imo), then when waking, call
> _SST with argument 2 in wakeup path, and asap, then pass at the
> end of the wakeup path argument 1.

Yep.  What I did was write a loop that called \_SI\_SST with an arg of 0,
1, ... 4 and wait one second between each call so I could see any LED
changes.  No effect.  I noticed that it's important to call
Acpi*SleepStatePrep() before calling _SST since it checks the SPS_
variable to determine the sleep state which is set in _PTS.  This may be
the issue.

> Your ASL seems also to contains some stuff related to LED, or BEEP,
> via the embedded controller.  Have you tryed to write some codes to control
> directly them (so that you know it really work)?
> At least, the LED stuff seems to be easy to look, debug, etc.
> Just write bytes to EC space addr 0x0C, and see what happens.

I'll try that.  I haven't written stuff directly to the EC LED control
register.

Thanks,
Nate


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
