From: Russell Neches <russell-1vnkWVZi4QaVc3sceRu5cw@public.gmane.org>
Subject: bug in acpid scripts
Date: Fri, 23 Jul 2004 15:36:58 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040723193658.GA3331@omocha.vort.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


I've assumed that the S3 sleep state was broken on my laptop for some
time now, but it turns out that the problem was cased by the behavior of
the distributed powerbtn.sh script. Or, at least, that's where the bug
manifests itself. 

My system always enters S3 without complaining, and resumes without
complaining. Then it immediately begins a clean shutdown. I had assumed
this was caused by general S3 breakage, but the problem is actually
caused by acpid catching the power button event that triggered the
system to resume. It then dutifully calls powerbtn.sh, and the system
shuts down. 

Tossing an "exit" at the beginning of powerbtn.sh fixes the problem
(with an obvious trade-ff), and my laptop suspends and resumes
perfectly. Well, almost perfectly -- I have to unload ohci_hcd before
shutting down, and I have to figure out how to get wireless working
after resume, but those are separate issues.

Is there a sensible way to tell if the system is coming off of S3? I
imagine I could do something like this to get into S3;

	#!/bin/sh
	touch /tmp/S3.ignore.powerbtn
	echo 3 > /proc/acpi/sleep
	sleep 10
	rm /tmp/S3.ignore.powerbtn

and then add this to the beginning of powerbtn.sh;

	if [ -e /tmp/S3.ignore.powerbtn ]; then
		exit
	fi

but that just seems dumb. Any better ideas?

Russell


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
