From: David Sterratt <david.c.sterratt-5WhEfG1TI8k@public.gmane.org>
Subject: Re: Temperature reported wrongly?
Date: Fri, 18 Feb 2005 22:00:18 +0000
Message-ID: <1108764018.7311.15.camel@chickenrun>
References: <1107531994.23192.2056.camel@canonmills.inf.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1107531994.23192.2056.camel-n5vp7pYcALv/CiYq7C4egV5eyrv7yTFU@public.gmane.org>
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

On Fri, 2005-02-04 at 15:46 +0000, David Sterratt wrote:
> There appears to be a discrepancy between the temperature reported by
> ACPI and the temperature reported by the "health check" in my BIOS, just
> over a minute after rebooting. The value reported by
> /proc/acpi/thermal_zone/THRM/temperature is 73 degC as opposed to 51
> degC from the BIOS. I'm working on the assumption that the CPU core
> can't cool down by 22 degC in under a minute.
> 
> Is that assumption likely to be correct?  If so, I suppose it implies a
> bug in acpi, I've looked in the bugzilla and googled, but couldn't find
> anything similar. 
> 
> I'm running a stock 2.6.8 kernel as supplied by Debian. My motherboard
> is an MSI MS-6390 with an Athlon XP1800+ CPU and a winbond W83697HF
> sensor chip. The temperature sensor is a diode. The BIOS is AWARD v
> 6.00PG (v1.2) and APIC is disabled in the BIOS (to solve some other
> problems with 2.6.x kernels).  
> 
> I've considered upgrading the BIOS. There was a problem in earlier
> versions of the BIOS about reporting incorrect temperature, but that
> seems to have been fixed in my minor version (v1.2)
> (http://members.driverguide.com/driver/detail.php?driverid=149547) There
> are no changes after v1.2 that might correct the temperature reporting
> (http://www.msicomputer.com/support/bios_result.asp; and then select AMD
> platform and MSI-6390 -- MSI site won't give sane URL). I'm reluctant to
> flash my BIOS, but if people think it might be worth a try I might take
> the risk.
> 
> I've tried using lm_senosrs, but that gives me the same temperature
> (unless I tweak it in sensors.conf).

I've just discovered (by accident) that this actually appears to be an
lm_sensors problem -- when I don't have the lm_sensors modules in the
kernel, ACPI seems to report the CPU temperature fine. I'll mail the
relevant lm_sensors list. Sorry for the noise.

David. 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
