From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: swsusp not working (was Re: [] Stop Snoring Today!)
Date: Wed, 29 Jan 2003 21:04:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030129200416.GA1242@elf.ucw.cz>
References: <20030120180730.GA530@zaurus> <Pine.SOL.4.21.0301281102520.22616-100000@neptun>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.21.0301281102520.22616-100000-gIrQFgUln/g@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: kneumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Actually, deep sleep S4 should work these days (and
> > without snooring :-)... If you diisable scsi (ide-scsi too)
> > and use 2.5.59...
> 
> Actually there seems to be an issue: On my Vaio Z600TEK (PIIBX-IDE
> Chipset) with 2.5.59 it BUGS on ide-disk.c:1557 when trying to suspend :(
> 
> I did not yet have a deeper look at it...only thing is that scsi is
> compiled as a module - that should not be it, should it?

SCSI compiled-in is known to block suspend, but not BUG().
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
