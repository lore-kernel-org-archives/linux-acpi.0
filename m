From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Bad battery regression on Dell D600 from 2.6.10-rc2-bk9 to 2.6.10-rc2-bk10
Date: Fri, 4 Feb 2005 17:00:20 +0100
Message-ID: <20050204160020.GB10316@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi.

I know the dell d600 is a pretty big pile of junk when it comes to the
ACPI battery code in its DSDT, because:

seife@strolchi:~> time cat /proc/acpi/battery/BAT0/info
present:                 yes
design capacity:         53000 mWh
last full capacity:      49250 mWh
battery technology:      rechargeable
design voltage:          11100 mV
design capacity warning: 3000 mWh
design capacity low:     1000 mWh
capacity granularity 1:  200 mWh
capacity granularity 2:  200 mWh
model number:            DELL Y13384
serial number:           2422
battery type:            LION
OEM info:                Sanyo

real    0m0.201s
user    0m0.001s
sys     0m0.185s

0.2 seconds where the system is basically dead (cpu at 600 mhz, with full
speed CPU it gets faster, but i don't want to burn my battery just to read
out the info) is a long time to read out the battery info.

Now since 2.6.10-rc2-bk10, it takes _1.2 seconds_, i repeat: 1200 miliseconds
to read out the battery info. I _think_ (not sure, i am on the road right now
and i have of course instantaneously removed that -bk10 again) this change
coincides with the new ACPI code, 20050125 or so, the kernel i am running now
(based on rc2-bk3) has 20041210.

Is anyone else seeing this?
And yes, i am all for putting in those patches that let us sleep during ec
controller access :-)
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
