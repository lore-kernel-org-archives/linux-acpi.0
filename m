From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: Re: Re: _CST implementation
Date: Fri, 22 Apr 2005 19:13:44 +0200
Message-ID: <426930C8.6030101@tzi.de>
References: <1113598244.8367.30.camel@scotchmobil> <20050418120744.GG2298@poupinou.org> <4263EDA2.4030106@suse.de> <20050419092251.GK2298@poupinou.org> <4264F251.5030705@suse.de> <20050419134518.GL2298@poupinou.org> <20050419200505.GE19499@message-id.gmane0305.slipkontur.de> <42656601.3060304@bartol.udel.edu> <20050420094556.GN2298@poupinou.org> <4268F572.4090707@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4268F572.4090707-l3A5Bk7waGM@public.gmane.org>
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

Thomas Renninger schrieb:
> Bruno Ducrot wrote:
> 
>>On Tue, Apr 19, 2005 at 04:11:45PM -0400, Rich Townsend wrote:
>>
>>>Stefan Seyfried wrote:
>>>
>>>>On Tue, Apr 19, 2005 at 03:45:18PM +0200, Bruno Ducrot wrote:
>>>>
>>>>
>>>>
>>>>>IOW, from spec we should not invalidate, but from "common practice" by
>>>>>bios writters, we should invalidate.
>>>>
>>>>What about a "spec_compliant_but_beware_of_stupid_bios_writers" module
>>>>parameter? ;-)
>>>
>>>I fear that would be set to nonzero on every system...
>>>
>>
>>That's the case already.  This is the boot parameter
>>acpi=strict
> 
> 
> I do not think it is a good idea to make this depend on acpi=strict.
> 
> Normally !acpi_strict enables features for some broken BIOS.
> In this case !acpi_strict disables them.
> 
> There still is max_cstates if something goes terribly wrong.
> I never saw such a machine, are there many of them out there?
> 
> Janosch: Did you get the 1001 latency state to work?
> 
The 1001 latency C3 state was in my case from the P_BLK. My Notebook 
worked fine with it, but actually the power consumption was as high as 
in the C2 state.

I would suggest a parameter for disabling _CST, because it is new (and 
buggy) code.

   Janosch


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
