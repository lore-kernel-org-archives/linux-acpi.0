From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Applications & ACPI events
Date: Mon, 13 Oct 2003 19:01:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031013170119.GB18363@hell.org.pl>
References: <20031008191610.GB1035@elf.ucw.cz> <20031008215342.GE1920@fairlite.demon.co.uk> <20031008215850.GF1238@elf.ucw.cz> <20031009140648.GH1922@fairlite.demon.co.uk> <20031009213504.GC365@elf.ucw.cz> <20031013131022.GN11391@poupinou.org> <20031013133837.GA9178@hell.org.pl> <20031013152807.GD15441@elf.ucw.cz> <20031013161445.GA32511@hell.org.pl> <20031013161937.GF15441@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031013161937.GF15441-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Alan Hourihane <alanh-ASBjxr/nLg+TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Pavel Machek:
> > You mean switching between a text console and another, or between a text
> > console and X? If it's the first case, than it doesn't. If th second, than
> > yes, it takes some 3-4 seconds to switch. Part of that I attribute to the
> > driver reinitializing the DRI engine.
> Are you should it is not monitor playing catch up? When you change
> resolution/dot clock, monitors take a while to synchronize... DRI
> engine should not take seconds to initialize...

It's an LCD, and the modes are roughly the same (I'm using radeonfb with
the display's native resolution).

> > > b) should not be needed for S1. It is hw bug if it is.
> > Well, entering S1 while X is running with DRI and no console switch is done
> > causes similar symptoms to S4 resume in the same situation. I'm not sure
> > that's the same thing. but it looks so.
> IIRC, S1 should be transparent to software.

Well, than how is uhci.o locking the system dead if it's loaded on resume
(under 2.4, that is, 2.6 is OK)?
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
