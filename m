From: Matthew Keller <mgkeller-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Battery "design capacity" incorrect
Date: 01 Mar 2003 13:15:26 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1046542526.20921.22.camel@comp6161.potsdam.edu>
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

I've got a *very minor* problem. In fact, it's almost so trivial it's
cosmetic, but if there is an easy fix it would be one less nuisance!

ACPI is working SPLENDIDLY (2.4.21-pre<something> + acpi patches) and
I'm very happy with it. It does, however, think my battery has a "design
capacity" much higher than it actually is. This results in various
scripts I've written, as well as the Gnome battery applet thinking it's
always only 71% full even when it's fully charged and a-ok. It does the
same with my spares of the same make/model. Below is the output
(/proc/acpi/batter/BAT1/info) for the battery in my Gateway Solo 1450X.
The design capacity should be right around what the "last full capacity"
says. I've confirmed this on Sanyo's site. I would like to note that
everything is **perfect** with a different Sanyo model battery that is a
"extra capacity" battery. Is there any source I can diddle? Proc entries
I can echo some magic number into? etc? Thanks!

present:                 yes
design capacity:         5400 mWh
last full capacity:      3864 mWh
battery technology:      rechargeable
design voltage:          11100 mV
design capacity warning: 250 mWh
design capacity low:     100 mWh
capacity granularity 1:  10 mWh
capacity granularity 2:  25 mWh
model number:            UAL3$
serial number:
battery type:            LION
OEM info:                SANYO

-- 
Matthew Keller
Enterprise Systems Analyst
Computing & Technology Services
State University of New York @ Potsdam
Potsdam, NY USA
http://mattwork.potsdam.edu/



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
