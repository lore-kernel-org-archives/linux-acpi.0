From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: Re: Linux ACPI processor driver patch: user-definable power state limit
Date: Fri, 5 Nov 2004 23:54:38 +0100
Message-ID: <20041105225438.GA8262@dominikbrodowski.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3001A193B6@hdsmsx401.amr.corp.intel.com> <200410112335.19159.jos.delbar@ugent.be> <1099683907.13837.1353.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1099683907.13837.1353.camel@d845pe>
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
Cc: Jos Delbar <jos.delbar-Cru1EgDzd7c@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, James P Ketrenos <james.p.ketrenos-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 05, 2004 at 02:45:07PM -0500, Len Brown wrote:
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

That sounds to be quite racy. Multiple callers will get confused.
You probably need a 

struct acpi_cstate_limit {
	list_head	next;
	unsigned int	limit;
}

and you export

struct *acpi_cstate_limimt acpi_set_cstate_limit(unsigned int limit);

int acpi_modify_cstate_limit(struct acpi_cstate_limit * cstate_limit);

void acpi_remove_cstate_limit(struct acpi_cstate_limit * cstate_limit);

Whenever such an operation occurs, you need to walk all these limit structs
for the highest "limit", and use that.

Other than that, the current "limit" interface to processor.c seems to be
pretty much useless as P-States aren't really handled.

I'll cook up a patch for the thing above in a few minutes... stay tuned.

Thanks,
	Dominik


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
