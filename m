From: Hanno Böck <hanno-Mmb7MZpHnFY@public.gmane.org>
Subject: BATTSTAT-patch for two or more batteries
Date: Sun, 6 Oct 2002 18:51:42 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021006185142.0a422a2b.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: ACPI list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have updated my gnome-battstat-patch for two batteries now:
http://www.gentoo.org/~hanno/battstat_two_batteries_v2.diff
Patch is against gnome-applets-2.0.3.

Changes:
- Should also work with more than 2 batteries, now generic check for what's in /proc/acpi/battery. (can anyone with 3 batteries confirm this?)
- Should also fix the issue reported by Federico Di Gregorio with the non-usual ac/dc-proc-entry. Also generic check. (Frederico, can you confirm this?)

Any Feedback is welcome. I will also send this to the gnome-authors.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
