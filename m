From: James Ketrenos <jketreno-b5Z7lJ3WibVrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Subject: Re: [Ipw2100-devel] Re: ibm-acpi-0.3
Date: Wed, 18 Aug 2004 10:27:24 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4123755C.1010503@linux.jf.intel.com>
References: <20040810080826.GD28939@aero.ensim.com>	 <20040814211247.GS20883@aero.ensim.com>	 <20040817091921.GI20883@aero.ensim.com> <1092807746.25902.155.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1092807746.25902.155.camel@dhcppc4>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Borislav Deianov <borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-thinkpad-l7BEYHA5S10i5T99jlK1Sh2eb7JE58TQ@public.gmane.org, ipw2100-devel List <ipw2100-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Len Brown wrote:

>>http://bkernel.sf.net/tmp/ibm-acpi-0.3.tar.gz
>>    
>>
>
>The radio hot key sends an ACPI event,
>and the acpid example calls this radio.sh:
>
>#!/bin/bash
>
>if ! /sbin/rmmod ipw2100; then
>        /sbin/service network restart
>fi
>
>
>Does this means that the button press magically changed
>the state of the radio in hardware?  I didn't see any
>processing inside the driver to do that.
>  
>
The laptop might not actually have any RF switch circuitry to signal the 
GPIO pin -- so on detection of keypress, it fully removes and reloads 
the module (which will have the result of powering off/on the radio with 
the side effect of loading/unloading any modules  and services also 
listed in the network service)

As of 0.53 (since the proc entries are all broken in 0.52) the script 
could be changed to do something more along these lines (until we change 
from proc to sysfs and from strings to ints):

#!/bin/sh
if grep -q disabled /proc/net/ipw2100/eth1/state; then
    echo 0 > /proc/net/ipw2100/eth1/state
else
    echo 1 > /proc/net/ipw2100/eth1/state
fi

The above will check the state of the RF kill switch.  If the radio is 
disabled, it enables it (by turning off the kill state), etc.  The link 
state will toggle based on whether the device is associated -- and that 
is likely what the various service scripts should be tied to (vs. 
whether or not the module is loaded)

James



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
