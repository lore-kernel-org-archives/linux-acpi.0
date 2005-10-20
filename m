From: marek czardybon <max-MEOeS5c08o1g9hUCZPvPmw@public.gmane.org>
Subject: acer travelmate 2313 battery problem.
Date: Thu, 20 Oct 2005 11:35:09 +0200
Message-ID: <435764CD.1090700@inbox.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
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

Hello.

I'm using acer travlemate 2313. I've installed Debian 3.1 on it.
I've kernel 2.6.13 with acpi-20050902-2.6.13 patch.
All works fine but without battery.

When I load module "battery" battery is detected

form dmesg:
"ACPI: Battery Slot [BAT1] (battery present)"

under /proc/acpi I can see battery directory and BAT1 in it.

list from it:

maxik:/proc/acpi/battery/BAT1# cat state
present:                 yes
ERROR: Unable to read battery status
maxik:/proc/acpi/battery/BAT1# cat alarm
alarm:                   unsupported
maxik:/proc/acpi/battery/BAT1# cat info
present:                 yes
design capacity:         2000 mAh
last full capacity:      1873 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 300 mAh
design capacity low:     74 mAh
capacity granularity 1:  32 mAh
capacity granularity 2:  32 mAh
model number:            11ZL
serial number:           3149
battery type:            LION
OEM info:                SIMPLO

but in dmesg i've:

"ACPI: Battery Slot [BAT1] (battery present)
   psargs-0339: *** Error: Looking up [Z004] in namespace, AE_NOT_FOUND
search_node cddc5628 start_node cddc5628 return_node 00000000
  dswexec-0460 [2350] ds_exec_end_op        : [Index]: Could not resolve 
operands, AE_NOT_FOUND
  psparse-0508: *** Error: Method execution failed [\_SB_.BAT1._BST] (Node 
cddc5428), AE_NOT_FOUND
acpi_battery-0205 [2341] battery_get_status    : Error evaluating _BST
   psargs-0339: *** Error: Looking up [Z004] in namespace, AE_NOT_FOUND
search_node cddc5628 start_node cddc5628 return_node 00000000
  dswexec-0460 [2364] ds_exec_end_op        : [Index]: Could not resolve 
operands, AE_NOT_FOUND
  psparse-0508: *** Error: Method execution failed [\_SB_.BAT1._BST] (Node 
cddc5428), AE_NOT_FOUND
acpi_battery-0205 [2355] battery_get_status    : Error evaluating _BST"

And any application can't read status of battery...

Any sugestion with this ?
I've searched google with this problem but I can't find nothing ?


-- 
marek czardybon / maxilee   +48 0697 724 404       http://inbox.eu.org
GG:3299479 JAB:maxilee-veJsmC5npURmR6Xm/wNWPw@public.gmane.org                  http://outbox.eu.org
ARP: 00:90:CC:43:D8:0D         GCC d? s:- a- C+++ UL++ P++ L++ E--- W+
N+ o K w--- O M- V- PS+ PE+ Y PGP t 5 X+R+ !tv b+ DI- D++ G e h r++ y?


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
