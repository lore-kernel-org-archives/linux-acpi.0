From: kneumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org
Subject: swsusp not working (was Re: [] Stop Snoring Today!)
Date: Tue, 28 Jan 2003 11:06:21 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.SOL.4.21.0301281102520.22616-100000@neptun>
References: <20030120180730.GA530@zaurus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20030120180730.GA530-XqDnSF8rrUM@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 20 Jan 2003, Pavel Machek wrote:
> Actually, deep sleep S4 should work these days (and
> without snooring :-)... If you diisable scsi (ide-scsi too)
> and use 2.5.59...

Actually there seems to be an issue: On my Vaio Z600TEK (PIIBX-IDE
Chipset) with 2.5.59 it BUGS on ide-disk.c:1557 when trying to suspend :(

I did not yet have a deeper look at it...only thing is that scsi is
compiled as a module - that should not be it, should it?

-Knut





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
