From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: Bad battery regression on Dell D600 from 2.6.10-rc2-bk9
	to 2.6.10-rc2-bk10
Date: Sat, 12 Feb 2005 22:36:22 +0800
Message-ID: <1108214082.19498.53.camel@neuromancer.home.net>
References: <20050204160020.GB10316@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050204160020.GB10316-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 2005-02-05 at 00:00, Stefan Seyfried wrote:
> Hi.
> 
> I know the dell d600 is a pretty big pile of junk when it comes to the
> ACPI battery code in its DSDT, because:
> 
> seife@strolchi:~> time cat /proc/acpi/battery/BAT0/info

> real    0m0.201s
> user    0m0.001s
> sys     0m0.185s
> 

D600 Too..

design capacity:         53280 mWh
last full capacity:      50240 mWh
battery technology:      rechargeable
design voltage:          11100 mV
design capacity warning: 5328 mWh
design capacity low:     1614 mWh
capacity granularity 1:  532 mWh
capacity granularity 2:  532 mWh
model number:            DELL C26034
serial number:           38783
battery type:            LION
OEM info:                Sony

real    0m0.083s
user    0m0.002s
sys     0m0.068s


> 0.2 seconds where the system is basically dead (cpu at 600 mhz, with full
> speed CPU it gets faster, but i don't want to burn my battery just to read
> out the info) is a long time to read out the battery info.

This is on Gentoo 2.6.10-gentoo-r6

ACPI Code is 20041105

> Now since 2.6.10-rc2-bk10, it takes _1.2 seconds_, i repeat: 1200 miliseconds
> to read out the battery info. I _think_ (not sure, i am on the road right now
> and i have of course instantaneously removed that -bk10 again) this change
> coincides with the new ACPI code, 20050125 or so, the kernel i am running now
> (based on rc2-bk3) has 20041210.
> 
> Is anyone else seeing this?
> And yes, i am all for putting in those patches that let us sleep during ec
> controller access :-)

--
Ow Mun Heng
Gentoo/Linux on DELL D600 1.4Ghz 
98% Microsoft(tm) Free!! 
Neuromancer 21:13:37 up 2:52, 2 users, 
load average: 0.17, 0.35, 0.34 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
