From: Jos Delbar <jos.delbar-Cru1EgDzd7c@public.gmane.org>
Subject: Re: Linux ACPI processor driver patch: user-definable power state limit
Date: Sat, 6 Nov 2004 00:21:49 +0100
Message-ID: <200411060021.49794.jos.delbar@ugent.be>
References: <F7DC2337C7631D4386A2DF6E8FB22B3001A193B6@hdsmsx401.amr.corp.intel.com> <200410112335.19159.jos.delbar@ugent.be> <1099683907.13837.1353.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1099683907.13837.1353.camel@d845pe>
Content-Disposition: inline
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
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, James P Ketrenos <james.p.ketrenos-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hey,

To allow modifying the C state limit on the fly, I think we might need to use 
a combination of both schemes.

In Andi Kleen's patch the C state is "permanently" disabled in 
acpi_processor_get_power_info() and this is probably the best way to go for 
the blacklist. However, when another module needs to limit the processor to a 
certain C state, I think it would be best to handle this in 
acpi_processor_set_power_policy(). This seems to make the most sense 
semantically: you can change the power management policy at runtime, not the 
actual capabilities of the processor.

Also, if you have both a blacklist and an option to change the limit at 
runtime, there has to be some logic to prevent a module from lifting a limit 
imposed by the blacklist.

Your patch just came in while I was writing this, I'll be sure to try it later 
today. I'm not sure if the idle handler should be concerned with handling the 
limit though, but it does make the code simpler.

Regards,

- Jos

On Friday 05 November 2004 20:45, Len Brown wrote:
> Jos,
> I agree with you that a single parameter is simpler.
>
> Another thing we need to address -- with either scheme --
> is that the parameter must be set in the kernel, not
> in the processor modules.
>
> This is because it is necessary for modules, such as ipw2100
> to be able to disable c3 automatically when they detect
> that it is interfering with their operation.
>
> so we'd export a function from the base kernel for
> modules to set the limit, and we'd simply export
> the value of acpi_cstate_limit for processor.c
> to observe at run-time.
>
> int
> acpi_set_cstate_limit(int limit)
>
> int acpi_cstate_limit;
>
> I think it can return the old limit so that
> the caller can potentially un-do its call,
> or perhaps setting the limit to 0 should
> simply mean clear any limit.
>
> cheers,
> -Len

-- 

Jos Delbar
jos.delbar-Cru1EgDzd7c@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
