From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Applications & ACPI eventse
Date: Fri, 10 Oct 2003 09:12:31 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031010071231.GA285@elf.ucw.cz>
References: <20031003193814.GE205@openzaurus.ucw.cz> <20031006124935.GQ11391@poupinou.org> <20031006130533.GA311@elf.ucw.cz> <20031008102745.GF11391@poupinou.org> <20031008191610.GB1035@elf.ucw.cz> <20031008215342.GE1920@fairlite.demon.co.uk> <20031008215850.GF1238@elf.ucw.cz> <20031009123620.GD13739@hell.org.pl> <20031009213245.GB365@elf.ucw.cz> <20031009235607.GA13514@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031009235607.GA13514-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alan Hourihane <alanh-ASBjxr/nLg+TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > That's how it's done with the Radeon driver, i.e. 1.9.0 DRM module and
> > > recent DRI snaphosts -- the engine is initialized / POSTed on VT switch.
> > Well, then radeon should "just work".
> 
> It actually does, at least for S4 in 2.4 (Nigel's swsusp).

S4 is very different case, since card is already initialized by
BIOS. Don't mix these!

> > Only remaining problem is when you attempt to s3-suspend from console
> > (not from X). But I do not see how thats solved.
> 
> That's not a problem for X, since it initializes the adapter on *every* VT 
> switch, and for the console, an appropriate driver (i.e. radeonfb or
> something different) should take care of that.

I'm told manufacturer documentation is usually not enough to
completely initialize card; and we do not want x86 emulator inside
kernel, right?
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
