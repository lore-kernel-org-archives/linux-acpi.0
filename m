From: David Sterratt <david.c.sterratt-5WhEfG1TI8k@public.gmane.org>
Subject: Temperature reported wrongly?
Date: 04 Feb 2005 15:46:34 +0000
Message-ID: <1107531994.23192.2056.camel@canonmills.inf.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

There appears to be a discrepancy between the temperature reported by
ACPI and the temperature reported by the "health check" in my BIOS, just
over a minute after rebooting. The value reported by
/proc/acpi/thermal_zone/THRM/temperature is 73 degC as opposed to 51
degC from the BIOS. I'm working on the assumption that the CPU core
can't cool down by 22 degC in under a minute.

Is that assumption likely to be correct?  If so, I suppose it implies a
bug in acpi, I've looked in the bugzilla and googled, but couldn't find
anything similar. 

I'm running a stock 2.6.8 kernel as supplied by Debian. My motherboard
is an MSI MS-6390 with an Athlon XP1800+ CPU and a winbond W83697HF
sensor chip. The temperature sensor is a diode. The BIOS is AWARD v
6.00PG (v1.2) and APIC is disabled in the BIOS (to solve some other
problems with 2.6.x kernels).  

I've considered upgrading the BIOS. There was a problem in earlier
versions of the BIOS about reporting incorrect temperature, but that
seems to have been fixed in my minor version (v1.2)
(http://members.driverguide.com/driver/detail.php?driverid=149547) There
are no changes after v1.2 that might correct the temperature reporting
(http://www.msicomputer.com/support/bios_result.asp; and then select AMD
platform and MSI-6390 -- MSI site won't give sane URL). I'm reluctant to
flash my BIOS, but if people think it might be worth a try I might take
the risk.

I've tried using lm_senosrs, but that gives me the same temperature
(unless I tweak it in sensors.conf).


All the best, and thanks for the ACPI work,

David.



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
