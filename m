From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: System indicators APM/ACPI
Date: Mon, 29 Sep 2003 13:00:40 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030929125921.A78167@root.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In suspending my T23, I found an interesting issue.  When suspending with
APM on FreeBSD, the "suspended" light comes on.  When suspending on
Windows 2k, it also comes on.  When suspending with ACPI on FreeBSD, it
does not come on even though it suspends/resumes fine.  Is Win2k
suspending via APM even though it is using ACPI for other features?  I am
certain it is using ACPI by checking in the driver info window.

I figured this might have something to do with \_SI\_SST since my laptop
has that.  But running \_SI\_SST with various args never changes any
lights.  ASL:  http://root.org/~nate/acpi/ibm-acpidump.asl.gz

Ideas?

BTW, would it be a good idea to add code to call \_SI\_SST to the ACPICA
AcpiSetSleepState() function?

-Nate


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
