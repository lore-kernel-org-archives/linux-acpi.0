From: Tim Dijkstra <newsuser-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org>
Subject: Should battery generate events?
Date: Mon, 4 Oct 2004 23:25:57 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041004232557.6c342288@commensaal.drs.p>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

Last week my laptop (Acer Travelmate 636Lci) run out of power resulting
in a unclean shutdown, disk corruption and me spending a few evenings to
get it to sanely work again.

I would want to avoid this happening again. Ideally I would want my
laptop to "shutdown -h now" if battery power is to low (well rather have
it go to S3 or softwaresuspend, but it seems hopeless to get that to
work :(  

>From some googl'ing I get the impression that ACPI should generate
battery events on a change of capacity or at least when it's low. My
idea was to have acpid call some script on battery events. 
The problem is that there doesn't seem to be such events on my machine. 

Should every bios generate these events?
Could it be a bug in my DSDT?
Does it have anything to do with
tdykstra@bonenpikster:/$ cat /proc/acpi/battery/BAT0/alarm
alarm:                   unsupported
?

FYI from my /proc/acpi:

tdykstra@bonenpikster:/$ cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          charging
present rate:            unknown
remaining capacity:      3840 mAh
present voltage:         14800 mV
tdykstra@bonenpikster:/$ cat /proc/acpi/battery/BAT0/info
present:                 yes
design capacity:         3920 mAh
last full capacity:      3920 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 30 mAh
design capacity low:     20 mAh
capacity granularity 1:  10 mAh
capacity granularity 2:  3470 mAh
model number:            Bat0
serial number:
battery type:            Lion
OEM info:                Acer


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
