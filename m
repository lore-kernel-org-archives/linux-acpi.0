From: Sebastian <Ostdeutschland-Mmb7MZpHnFY@public.gmane.org>
Subject: 2.6.11-rc1 problem with battery state (AE_ALREADY_EXISTS)
Date: Thu, 20 Jan 2005 22:57:48 +0100
Message-ID: <20050120225748.2d1a7cfc.Ostdeutschland@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

hi,

i reported this error some time ago, without any reply...
i'm running 2.6.11-rc1 now on an acer travelmate 291lci laptop.

[admin@laptop]$ while [ 1 ]; do cat /proc/acpi/battery/BAT1/state &&
sleep 1; done
present:                 yes     
capacity state:          ok      
charging state:          charged 
present rate:            0 mA    
remaining capacity:      4000 mAh
present voltage:         16647 mV
present:                 yes     
capacity state:          ok      
charging state:          charged 
present rate:            0 mA    
remaining capacity:      4000 mAh
present voltage:         16645 mV
present:                 yes     
capacity state:          ok      
charging state:          charged 
present rate:            0 mA    
remaining capacity:      4000 mAh
present voltage:         16645 mV
 dswload-0294: *** Error: Looking up [PBST] in namespace,
AE_ALREADY_EXISTS
 psparse-0601 [915] ps_parse_loop         : During name lookup/catalog,
AE_ALREADY_EXISTS
 psparse-1138: *** Error: Method execution failed
[\_SB_.PCI0.LPC0.BAT1._BST] (Node defc21e8), AE_ALREADY_EXISTS
acpi_battery-0208 [908] acpi_battery_get_statu: Error evaluating _BST
present:                 yes     
ERROR: Unable to read battery status
present:                 yes     
capacity state:          ok      
charging state:          charged 
present rate:            0 mA    
remaining capacity:      4000 mAh
present voltage:         16647 mV
     osl-0958 [992] os_wait_semaphore     : Failed to acquire
semaphore[c172c5a0|1|0], AE_TIME 
present:                 yes     
capacity state:          ok      
charging state:          charged 
present rate:            0 mA    
remaining capacity:      4000 mAh
present voltage:         16647 mV



thanks, sebastian


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
