From: Frank Mehnert <fm3-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
Subject: Completely discharging LION batteries
Date: Tue, 10 Dec 2002 20:59:52 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E18LqXo-000B9o-00@os.inf.tu-dresden.de>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I'm using Linux 2.4.20 together with the acpi patches 20021205-2.4.20 on a
Thinkpad T20. If I use two batteries (the builtin and a second in the Ultra-
Bay), the second battery first gets discharged _completely_ and after that
the internal battery is used.

The bad thing about that is that if I allow the Laptop to fully discharge
the LION battery, the usable capacity gets reduced. I have looked at
/proc/acpi/battery/BAT1/{state,info}: Before completely discharging the
battery, the "last full capacity" entry was about 30500 mWh. The design
capacity is 34560 mWh. After completely discharging the battery, the
maximum capacity to which the battery can be charged is only 28120 mWh,
so I lost about 2000 mWh or about 8 percent of the battery capacity!!!

So since I found that out I don't allow the Laptop to fully discharge the
battery anymore. So may questions are: Can I set the capacity at which the
Laptop switches to the builtin battery? Can you acknowledge my experiences?

Frank


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
