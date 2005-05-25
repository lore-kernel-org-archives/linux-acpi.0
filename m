From: Sebastian Kaergel <mailing-HmhXUwHVxSOoYr4blSSd5g@public.gmane.org>
Subject: Error while reading /proc/acpi/battery/BAT1/state
Date: Wed, 25 May 2005 21:34:19 +0200
Message-ID: <20050525213419.1c5af770.mailing@wodkahexe.de>
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

Hi,

installed 2.6.12-rc5 and noticed some strange behavior..

# while [ 1 ]; do cat /proc/acpi/battery/BAT1/state; done
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            0 mA
remaining capacity:      1840 mAh
present voltage:         14743 mV
<and so on...>

After a few second i get the following:

dswload-0294: *** Error: Looking up [PBST] in namespace,
AE_ALREADY_EXISTS

psparse-0601 [1606] ps_parse_loop         : During name lookup/catalog,
AE_ALREADY_EXISTS

psparse-1138: *** Error: Method execution failed
[\_SB_.PCI0.LPC0.BAT1._BST] (Node defc21e8), AE_ALREADY_EXISTS

acpi_battery-0208 [1599] acpi_battery_get_statu: Error evaluating _BST

osl-0958 [2167] os_wait_semaphore     : Failed to acquire semaphore
[de261d80|1|0], AE_TIME

osl-0958 [2203] os_wait_semaphore     : Failed to acquire semaphore
[de261d80|1|0], AE_TIME

and so on...

Machine is an Acer Travelmate 291lci laptop.
If you need other details, please let me know.

Thanks!


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
