From: Warren Togami <warren-ZewH/WUwPCfQT0dZR+AlfA@public.gmane.org>
Subject: Athlon processor throttling
Date: Sat, 14 Dec 2002 22:25:14 -1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DFC3C6A.1070405@togami.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

http://www-users.rwth-aachen.de/hendryk.pfeiffer/laptop.html

I have the same laptop described on this page.  I installed kernel 
2.5.51 + the latest ACPI patch.  This guy describes setting throttling 
with echo n >/proc/acpi/processor/CPU0/throttling.  Below is my attempt 
of changing the active state, but it doesn't appear to do anything.

[root@laptop CPU0]# pwd
/proc/acpi/processor/CPU0
[root@laptop CPU0]# cat throttling
state count:             16
active state:            T0
states:
    *T0:                  00%
     T1:                  06%
     T2:                  12%
     T3:                  18%
     T4:                  24%
     T5:                  31%
     T6:                  37%
     T7:                  43%
     T8:                  49%
     T9:                  55%
     T10:                  62%
     T11:                  68%
     T12:                  74%
     T13:                  80%
     T14:                  86%
     T15:                  93%
[root@laptop CPU0]# echo -n 9 > throttling
[root@laptop CPU0]# cat throttling
state count:             16
active state:            T0
states:
    *T0:                  00%
     T1:                  06%
     T2:                  12%
     T3:                  18%
     T4:                  24%
     T5:                  31%
     T6:                  37%
     T7:                  43%
     T8:                  49%
     T9:                  55%
     T10:                  62%
     T11:                  68%
     T12:                  74%
     T13:                  80%
     T14:                  86%
     T15:                  93%



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
