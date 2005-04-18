From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: _CST Patches
Date: Mon, 18 Apr 2005 16:26:19 +0200
Message-ID: <20050418142619.GJ2298@poupinou.org>
References: <1113665142.7964.13.camel@scotchmobil> <20050418114757.GF2298@poupinou.org> <1113826585.8500.12.camel@scotchmobil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1113826585.8500.12.camel@scotchmobil>
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

On Mon, Apr 18, 2005 at 02:16:25PM +0200, Janosch Machowinski wrote:
> 
> > > This patch fakes an C1 state if the given states by the _CST object
> > > start with anything else than C1 (like on my M6NE here it start's with
> > > C2)
> > 
> > It should not be needed.  I've taken care that it work by testing
> > in almost all cases by overriding the DSDT when I wrote this part to
> > handle properly almost all cases (I forgot the case when C1 and C3, but
> > no C2 though, that why I wrote 'almost').
> > 
> > Normally, we register a C1 state no matter what before we check
> > the content of _CST, then we just skip if a C1 type is found.
> > 
> > If your patch is needed, then the patch I send some times ago have not been
> > fully integrated in the original form, or maybe the wrong one was considered
> > (the first was buggy in that regard, but the second was OK).
> > 
> Your first patch has been modified, and now my patch is needed. 
> In your first implementation you did an (pr->power)++ before the loop
> that started the polling of the _CST object.

Since C1 is not handled by the loop itself, it is needed to count it
before the loop.

> At the moment all C-States
> are deleted (see the memset) and generated from scratch.

I see...  Sound like it has been modified.  I don't know why.

> Your idea
> sounds faster to me !
> 
> 
> > I would prefer
> > memset(pr->power.states, 0, ACPI_PROCESSOR_MAX_POWER * sizeof(struct acpi_processor_cx));
> > (without the loop)
> 
> I agree, looks faster to me. 
> 
> A new patch is attached
> 
>   Janosch

> --- processor_idle.original	2005-04-16 17:13:44.000000000 +0200
> +++ processor_idle.c	2005-04-18 14:13:52.000000000 +0200
> @@ -479,8 +479,6 @@
>  
>  static int acpi_processor_get_power_info_fadt (struct acpi_processor *pr)
>  {
> -	int i;
> -
>  	ACPI_FUNCTION_TRACE("acpi_processor_get_power_info_fadt");
>  
>  	if (!pr)
> @@ -489,8 +487,7 @@
>  	if (!pr->pblk)
>  		return_VALUE(-ENODEV);
>  
> -	for (i = 0; i < ACPI_PROCESSOR_MAX_POWER; i++)
> -		memset(pr->power.states, 0, sizeof(struct acpi_processor_cx));
> +	memset(pr->power.states, 0, ACPI_PROCESSOR_MAX_POWER * sizeof(struct acpi_processor_cx));
>  
>  	/* if info is obtained from pblk/fadt, type equals state */
>  	pr->power.states[ACPI_STATE_C1].type = ACPI_STATE_C1;
> @@ -536,8 +533,8 @@
>  		return_VALUE(-ENODEV);
>  
>  	pr->power.count = 0;
> -	for (i = 0; i < ACPI_PROCESSOR_MAX_POWER; i++)
> -		memset(pr->power.states, 0, sizeof(struct acpi_processor_cx));
> +
> +	memset(pr->power.states, 0, ACPI_PROCESSOR_MAX_POWER * sizeof(struct acpi_processor_cx));
>  
>  	status = acpi_evaluate_object(pr->handle, "_CST", NULL, &buffer);
>  	if (ACPI_FAILURE(status)) {
> @@ -609,6 +606,27 @@
>  
>  		cx.type = obj->integer.value;
>  
> +		//Test if the first entry is a C1 state, if not we fake one
> +		if ((cx.type != ACPI_STATE_C1) && i == 1) {
> +				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Faking C1 State"));
> +				struct acpi_processor_cx c1_fake;
> +				memset(&c1_fake, 0, sizeof(c1_fake));
> +
> +				c1_fake.address = 0;
> +				c1_fake.type = ACPI_STATE_C1;
> +				c1_fake.latency = 0; //How long needs a HLT instruction to execute ?
> +				c1_fake.power = 0; //We don't know anything about the power consumption so we set it to 0
> +				//We copy our fake C1 state over to the power states
> +				(pr->power.count)++;
> +				memcpy(&(pr->power.states[pr->power.count]), &c1_fake, sizeof(c1_fake));
> +				//Finally we avoid to have more power states than ACPI_PROCESSOR_MAX_POWER
> +				if(count == ACPI_PROCESSOR_MAX_POWER)
> +				  count--;
> +				
> +				//c1_fake should be freed automaticaly
> +		}
> +
> +
>  		if ((cx.type != ACPI_STATE_C1) &&
>  		    (reg->space_id != ACPI_ADR_SPACE_SYSTEM_IO))
>  			continue;


-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
