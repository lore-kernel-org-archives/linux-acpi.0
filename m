From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: _CST Patches
Date: Mon, 18 Apr 2005 13:47:57 +0200
Message-ID: <20050418114757.GF2298@poupinou.org>
References: <1113665142.7964.13.camel@scotchmobil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1113665142.7964.13.camel@scotchmobil>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Apr 16, 2005 at 05:25:41PM +0200, Janosch Machowinski wrote:
> Hey
> it's the guy with the stupid questions again ;-) 
> And now I got a few answers I think... 
> ACPI specification says, that every processor has a C1
> state, and on page 262 is an example of an _CST package,
> where the first given C state is C2. So I would suggest following patch
> to the processor_idle.c Line: 611
> 
> cx.type = obj->integer.value;
> 
> +//Test if the first entry is a C1 state, if not we fake one
> +if ((cx.type != ACPI_STATE_C1) && i == 1) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Faking C1 State"));
> +		struct acpi_processor_cx c1_fake;
> +		memset(&c1_fake, 0, sizeof(c1_fake));
> +
> +		c1_fake.address = 0;
> +		c1_fake.type = ACPI_STATE_C1;
> +		c1_fake.latency = 1; //How long needs a HLT instruction to execute ?
> +		c1_fake.power = 0; //We don't know anything about the power
> consumption so we set it to 0
> +		//We copy our fake C1 state over to the power states
> +		(pr->power.count)++;
> +		memcpy(&(pr->power.states[pr->power.count]), &c1_fake,
> sizeof(c1_fake));
> +		//Finally we avoid to have morepower 				+		//states than
> ACPI_PROCESSOR_MAX_POWER
> +		if(count == ACPI_PROCESSOR_MAX_POWER)
> +		count--;
> +		
> +		//c1_fake should be freed automaticaly
> +
> +		}
> +
> 
> 		if ((cx.type != ACPI_STATE_C1) &&
> 
> This patch fakes an C1 state if the given states by the _CST object
> start with anything else than C1 (like on my M6NE here it start's with
> C2)

It should not be needed.  I've taken care that it work by testing
in almost all cases by overriding the DSDT when I wrote this part to
handle properly almost all cases (I forgot the case when C1 and C3, but
no C2 though, that why I wrote 'almost').

Normally, we register a C1 state no matter what before we check
the content of _CST, then we just skip if a C1 type is found.

If your patch is needed, then the patch I send some times ago have not been
fully integrated in the original form, or maybe the wrong one was considered
(the first was buggy in that regard, but the second was OK).

> By looking throug the code I also discovered some errors :
> on line 492 and 539 
> for (i = 0; i < ACPI_PROCESSOR_MAX_POWER; i++)
> memset(pr->power.states, 0, sizeof(struct acpi_processor_cx))
> 
> my patch also replaces these lines by 
> for (i = 0; i < ACPI_PROCESSOR_MAX_POWER; i++)
> memset(&(pr->power.states[i]), 0, sizeof(struct acpi_processor_cx))

I would prefer
memset(pr->power.states, 0, ACPI_PROCESSOR_MAX_POWER * sizeof(struct acpi_processor_cx));
(without the loop)

> 
> Greets
> 	Janosch Machowinski
> 
> P.S.: Note the attached file is only a diff to the original
> processor_idle.c

Please post unified patch (diff with option '-u').


-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
