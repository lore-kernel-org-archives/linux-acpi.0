From: Gregory Gulik <greg-eIr5aKVv5JjYtjvyW6yDsg@public.gmane.org>
Subject: Finally some success with Toshiba 1115-S103
Date: Tue, 10 Dec 2002 10:44:39 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DF60BE7.7070400@gulik.org>
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
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I finally got the latest ACPI patches applies to 2.4.20 to work but ONLY 
when everything was compiled into the kernel.  I couldn't for the life 
of me get ACPI to work as loadable modules.  I would always get 
unresolved symbols upon trying to load them.

I must have rebuilt the kernel from scratch about 10 times, with three 
different .config files, including one from another list member, but 
nothing would result in modules that would load!

Now to the good news.  I now have a full complement of files in 
/proc/acpi including good battery status information

[root@toshiba1115 BAT1]# cat state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mA
remaining capacity:      4000 mAh
present voltage:         14800 mV
[root@toshiba1115 BAT1]# cat info
present:                 yes
design capacity:         4000 mAh
last full capacity:      4000 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 420 mAh
design capacity low:     156 mAh
capacity granularity 1:  264 mAh
capacity granularity 2:  3780 mAh
model number:            PA3209U
serial number:           3658Q
battery type:            Li-Ion
OEM info:                TOSHIBA

Even the Gnome/RH8 battery indicator shows the battery charge level just 
fine but it can't seem to tell if the AC power cord is plugged in.  It 
always shows it's on battery.

I guess that's probably because /proc/acpi/ac_adapter is empty:
[root@toshiba1115 acpi]# ls /proc/acpi/ac_adapter/
[root@toshiba1115 acpi]#

This is definitely an improvement but I'm still wondering why ACPI 
wouldn't work as a module...

-- 
Greg Gulik                                 http://www.gulik.org/greg/
greg @ gulik.org                           http://www.drivingevents.com/




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
