From: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Subject: passive cooling policy
Date: Mon, 06 Sep 2004 19:39:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <413CA0D9.5030901@renninger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

I have some general issues about passive cooling in userspace.
Please correct me if I am wrong at some point:

1) Cooling policy (active, passive) should be adjusted through the 
cooling mode interface.
At most every tenth brand-new laptop supports cooling mode interface.

2) Cooling policy could be simulated by overriding active/passive trip 
points (fans shouldn't be touched but are controlled by kernel).
BIOS must export active/passive trip point values to effectively lower 
fan activity.

3) If passive limit is reached, kernel throttles cpu and tries to set 
cpufreq to lowest step. Only way to find out whether machine is 
passively cooled is in polling /proc/acpi/thermal_zone/*/state.
(Is it right that cpufreq daemons poll this file to be informed of 
kernel forced cpufreq slow downs?)

If above is right, I have some enhancement suggestions:

1) inform userspace that cpu speed is increased/decreased through a 
thermal event.
-> avoid userspace progs polling /proc/acpi/thermal_zone/*/state to be 
informed whether the system is slowed down.

2) Allow setting a passive trip point even BIOS does not export a 
passive trip point value and initialise tc1, tc2 and tsp with some 
sensible default values.
-> you could lower fan activity on every laptop/workstation that 
supports throttling/cpufreq regardless whether the BIOS exports any 
passive trip points/cooling mode (event most laptop vendors don't care 
about trip points).

If it is possible that this goes mainline, then I'll try to provide a 
patch (as this should be quite easy to implement, I think).

Thanks for response,

      Thomas


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
