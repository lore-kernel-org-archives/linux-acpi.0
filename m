From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: acpi, c# states and scaling processor: temp variation can damage my cpu or laptop?
Date: Sun, 2 Jan 2005 19:16:08 +0100
Message-ID: <20050102181608.GB15182@hell.org.pl>
References: <41D83070.1000606@yahoo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41D83070.1000606-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Francisco Figueiredo Jr." <fxjrlists-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Francisco Figueiredo Jr.:
> sorry if this is not the right place to ask, but from msgs I think you
> have a lot of background which could easily give me some light.
> 
> I'm having all this info about C# states, processor scaling and such.
> I have my pentium 4 m with cpu scaling, (althought I don't have C2 or C3

If that's really 2.8 GHz, then you're definitely talking about Mobile
Pentium 4, not a Pentium 4-M. Those are different beasts.

> support, only C1, is this ok?) and I easily can go from 44 C at 1.6G to

Well, not really perfect as C-states allow for substatntial power savings.
But then, I'm not sure whether Mobile P4 supports C2 or C3.

> 54C 55C at 2.8G if I start compiling something length. And this makes me
> wonder: Can this damage my cpu? I mean, could this temp variation cause
> some type of physical stress in cpu or even my notebook components? Or
> cpu engineers already do it specting this type of behavior?

It is unlikely to cause any harm, anyway, odds are your OEM has already
taken care of that and your machine will automatically shutdown if the
temperature gets too high. Check /proc/acpi/thermal_zone/*/* for citical
trip points.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
