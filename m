From: "Francisco Figueiredo Jr." <fxjrlists-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
Subject: Re: How to control Thermal zone
Date: Sat, 11 Dec 2004 21:47:06 -0200
Message-ID: <41BB86FA.7040802@yahoo.com.br>
References: <41B8FC12.5090602@yahoo.com.br> <20041210011029.GA28676@zhen-devel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041210011029.GA28676-/VnEId6AORcBH7GVJk7YB9h3ngVCH38I@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI devel list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Wang, Zhenyu" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Wang, Zhenyu wrote:
|>Hi guys,
|>
|>sorry if this has been already asked,
|>
|>but I'd like to know if is it possible to control thermal zone in order
|>to turn off my laptop fan when I get my login screen.
|>
|>I mean, The fan is being correctly turned on and off but only after
|>getting some threshold. When the laptop is turned on and my thermal zone
|>temp is 35C fan is kept on when it could be turned off.
|>
|>Any tips?
|>
|
|
| Have you loaded acpi fan module? Have you got any device under
/proc/acpi/fan?
| Try to trigger on/off to that device.
|

Hi Wang,

Yes, I get the following under /proc/acpi/fan:

FAN1, FAN2, FAN3.

I played triggering on off on fan.

In fact, I could turn them on! :) I even could check that FAN2 and 3 are
fan velocities as when I turned them on they did a much higher noise :)

But unfortunately I couldn't turn them off :(

I tried both echo off > /proc/acpi/fan/FAN1 and echo -n 0 >
/proc/acpi/fan/FAN1, but they only turned it on. I mean, when I do echo
off, it turns on. So I think that whatever I put is turning them on.

What should I echo to turn them off?


I think that if I learn how to turn it off by playing with acpi/fan it
would be very cool!!

Thanks in advance, Wang.


- --
Regards,

Francisco Figueiredo Jr.
Membro Fundador do Projeto MonoBrasil - MonoBrasil Project Founder Member
http://monobrasil.softwarelivre.org



- -------------
"Science without religion is lame;
religion without science is blind."

~                  ~ Albert Einstein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQbuG+v7iFmsNzeXfAQI1uQf/eGAvq9D0tahFcZYCnDVfMNXtygLZZMoQ
3Pj+Zok7awWscsxZf0q4+MSNTCNeuDVFqaFRtUJ/kLvHop7nZoyn31IJW0dGeP2p
8PDuxAxBnnByUu9Sbzm7kuzgSElmMMsRaTXqz4TC37YOFLGwz8SWX7qgSVAI0C/C
D8C5xQl0ohPwe6XN1ivJjcDgv9x+xocvHqbAqNL0q+Aa65eLSgTS/bzv6zABWN47
o62hViITqzQlGLaEYZHckM5WKNJfsziqgUMAsYeXxcIlBfDpTLIY1hoE3sZTiXhF
Z2/x+cpTzq0j8jctHmfavisattGJi4m9tvKiH7V6vwAa1weXSku4aA==
=VIIn
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
