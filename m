From: Herman Sheremetyev <herman-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org>
Subject: Re: ACPI on HP ze4430us
Date: Wed, 29 Dec 2004 15:52:54 -0500
Message-ID: <41D31926.5070708@swebpage.com>
References: <00ad01c4ede0$23b57bd0$0200a8c0@Home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <00ad01c4ede0$23b57bd0$0200a8c0-+2hNPL9WhaWs1BDpvl8NfQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Konstantin Svist <konstantin-6crfdjOYMUleoWH0uzbU5w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Those kernel options aren't hacks as far as I know, they're perfectly 
legitimate.  You can recompile the kernel and remove APM support to 
avoid using them though.

-Herman

Konstantin Svist wrote:
> I see.
> So is there a more solution more permanent than the hack? Does that have to
> do with DSDT?
> 
> 
> Konstantin
> 
> 
> 
>>Sounds like that knoppix kernel has APM and ACPI support compiled in and
>>APM gets choses on your laptop even though it's not supported so you
>>have to tell the kernel to use ACPI explicitly.
>>
>>-Herman
>>
>>
>>>I just tried Knoppix 3.7 on my laptop - it doesn't boot. After some
>>>playing around, I figured out that the problem is ACPI - it only
>>>boots if I specify any of the three "hacks": "acpi=off",
>>>"acpi=ht", and "acpi=force". The last one even powers down my
>>>laptop on shutdown.
>>>What is going on here?
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now. 
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
