From: Christian Zoz <zoz-l3A5Bk7waGM@public.gmane.org>
Subject: /proc/acpi/alarm
Date: Fri, 24 Jan 2003 15:31:03 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030124143103.GO24225@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


Hi all,

please, how do i set the alarm in /proc/acpi/alarm?

cotonou:~ # echo 15:22:47 > /proc/acpi/alarm
cotonou:~ # cat /proc/acpi/alarm 
2003-01-24 23:47:47
cotonou:~ # 

That seems to be wrong, or is it buggy?

What does this alarm affect?
I assume, it just generates an event in /proc/acpi/events, right?

-- 

ciao, christian

  --------------------------------------------------------------------
    Verglichen mit jedem x-beliebigen Redmonder Betriebssystem-Clone
    ist Linux geradezu eine leuchtende Perle der Datensicherheit.
  ------ Frank Rennemann (http://www.linux-knowledge-portal.org) -----


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
