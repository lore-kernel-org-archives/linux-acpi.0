From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: CONFIG_PM, CONFIG_ACPI, CONFIG_ACPI_SLEEP
Date: Thu, 10 Mar 2005 09:15:03 +1100
Message-ID: <1110406503.8870.36.camel@desktop.cunningham.myip.net.au>
References: <1110394955.9337.48.camel@d845pe>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110394955.9337.48.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Thu, 2005-03-10 at 06:02, Len Brown wrote:
> Today it is possible to build with
> CONFIG_PM=n
> CONFIG_ACPI=y
> (however, CONFIG_ACPI_SLEEP does depend on CONFIG_PM)
> 
> Seems that the solution to the kexec poweroff issue
> is simpler if ACPI can depend on CONFIG_PM being present:
> http://bugzilla.kernel.org/show_bug.cgi?id=4041
> 
> Why shouldn't CONFIG_ACPI depend on CONFIG_PM
> Why shouldn't CONFIG_ACPI_SLEEP simply be CONFIG_ACPI
> 
> I can't think of any good reasons not to simplify here, can you?

That sounds confusing to me. I thought that ACPI was much more than just
power management. Doesn't it include IRQ routing, device enumeration and
so on too?

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
