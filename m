From: Francis Yom <fyom-NeBS1MF9zuBBDgjK7y7TUQ@public.gmane.org>
Subject: Problem with ACPI and vmware
Date: 20 Nov 2002 18:16:13 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1037834173.1868.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

Hey guys,

I'm having a problem with ACPI and VMWare.  I am using ACPI 20021101 and
VMWare 3.0 on kernel 2.4.19 with xfs and rmap14a.  My laptop is a Compaq
presario 2700T.

When I include processor and thermal support in the kernel, I can see my
battery and thermal zones just fine.  However, My Win2K and openbsd 3.2
VMWare sessions stutter and are slow.  YES!  I did install the Idle
patch.  In fact, with 20021101 ACPI it seems this patch is already in
place.

When I remove processor and thermal support, I cannot see my battery any
more, but VMWare sessions run fine without problems.

I am looking for a solution that will give me my battery support back
and let me run VMWare without sluggishness.

Can anyone suggest a solution?  Thanks!
Francis




-------------------------------------------------------
This sf.net email is sponsored by: 
Battle your brains against the best in the Thawte Crypto 
Challenge. Be the first to crack the code - register now: 
http://www.gothawte.com/rd521.html
