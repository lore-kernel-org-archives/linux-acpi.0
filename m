From: Jonathan Brandmeyer <jbrandmeyer-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Subject: trackpoint dead after suspend-to-RAM
Date: Thu, 02 Dec 2004 15:09:41 -0500
Message-ID: <1102018182.9867.15.camel@illuvatar>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I have recently installed Debian Sid on a Fujitsu P-2040 laptop, but
I've been using Linux for a while on a desktop, but I've never done
anything apm/acpi related with it, other than automatic poweroff at
shutdown.  I'm using kernel 2.6.9, with Debian-specific patches (does
not include ACPI-related stuff, as far as I can tell).

I'm trying to get suspend-to-ram working on the machine, but when it
resumes, the trackpoint (a PS/2 device) doesn't work.  I have confirmed
that the issue is at the kernel level and not the X level by
cat-ing /dev/input/mice and observing that nothing comes out when
pushing on the stick.  Removing the psmouse module before shutdown, and
inserting it after restoration does not work around the problem.

The issue appears to be similar to what was discussed in the thread "Re:
trackpoint dead after S3 suspend" in late November, 2003 on this mailing
list [1].  The last post in that thread said (with regard to a patch
reported to at least partially fix the problem), "See l-k to find
similar code done less ugly way... (I did it yesterday)."  Does anyone
know which patch the poster was referencing?

Alternatively, what other techniques could work around the problem?

Thanks,
-Jonathan Brandmeyer

[1]
http://sourceforge.net/mailarchive/forum.php?forum_id=6102&style=flat&viewday=23&viewmonth=200311



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
