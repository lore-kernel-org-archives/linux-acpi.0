From: Ian Soboroff <ian.soboroff-R3+/ord2DXQ@public.gmane.org>
Subject: Help configuring ACPI/acpid...
Date: Fri, 12 Mar 2004 09:17:50 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <9cf3c8eup2p.fsf@rogue.ncsl.nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I'm running Fedora Core 1 on a Fujitsu P-2110 laptop.  APM suspend
hasn't worked for me since 2.6.0-test7, so when I installed 2.6.4 this
week I decided to try ACPI instead.

Everything seems to be working as far as the info files in /sys and
/proc/acpi.  Now I'm trying to make suspending to RAM work.  This
always worked flawlessly using APM with no Linux-side configuration
whatsoever... close the lid, it went to sleep and would happily stay
that way for days.  Opening the lid always resumed.

So, I created the following file, /etc/acpi/events/suspend:

event=button/lid.*
action=echo -n mem > /sys/power/state

Closing the lid suspends to RAM, that's great.  Unfortunately, when I
open the lid, I have to press the power button to get it to resume.

Is there any way to get it to resume automatically when the lid is
opened again?

Thanks,
Ian



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
