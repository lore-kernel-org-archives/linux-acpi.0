From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: Centrino speedstep
Date: Wed, 29 Dec 2004 21:05:16 +0100
Message-ID: <m21xd83m6b.fsf@phoenix.squirrel.nl>
References: <m2zmzyw4e7.fsf@phoenix.squirrel.nl>
	<20041228212653.GA8436@dominikbrodowski.de>
	<20041229181834.GA19199@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041229181834.GA19199-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> (Bruno Ducrot's message
 of "Wed, 29 Dec 2004 19:18:34 +0100")
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

Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> writes:

> After looking the DSDT, this laptop do not support the _PDC switch, so
> the cpufreq-centrino driver will not work.  But it should work with the
> acpi io driver though.

This seems to be the case.

> Interresting portion:
> [...]
>
> This also mean there is no way to get the ondemand governor (or any
> DVS requiring low latency driver) to work with this one

What exactly does that mean?

> (unless hardcoding a table in the cpufreq-centrino).

Would that be difficult to accomplish?

> There is no _CST also, this means there is no C4 support :(

Nope. I'll have to do with C3...

BTW: To be able to compile my DSDT I needed some fixes, mostly
trivial, except one: the final return value of Method(_STA) from
Device(BAY1), around line 3222. Do you have any idea?

Thanks for helping,

       Johan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
