From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Applications & ACPI eventse
Date: Thu, 9 Oct 2003 23:32:45 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031009213245.GB365@elf.ucw.cz>
References: <20030930165926.GH1921@fairlite.demon.co.uk> <20030930173646.GF11391@poupinou.org> <20031003193814.GE205@openzaurus.ucw.cz> <20031006124935.GQ11391@poupinou.org> <20031006130533.GA311@elf.ucw.cz> <20031008102745.GF11391@poupinou.org> <20031008191610.GB1035@elf.ucw.cz> <20031008215342.GE1920@fairlite.demon.co.uk> <20031008215850.GF1238@elf.ucw.cz> <20031009123620.GD13739@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031009123620.GD13739-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
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

> > Kernel is doing VT switch in -test6. But I do not really think X can
> > bring up the video chip... are you really able to program video card
> > memory timings and similar stuff? On what cards?
> 
> That's how it's done with the Radeon driver, i.e. 1.9.0 DRM module and
> recent DRI snaphosts -- the engine is initialized / POSTed on VT switch.

Well, then radeon should "just work".

Only remaining problem is when you attempt to s3-suspend from console
(not from X). But I do not see how thats solved.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
