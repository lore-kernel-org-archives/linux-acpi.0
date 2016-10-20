From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v14 4/9] acpi/arm64: Add GTDT table parse driver
Date: Thu, 20 Oct 2016 17:37:49 +0100
Message-ID: <20161020163719.GC27598@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-5-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1475086637-1914-5-git-send-email-fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

As a heads-up, on v4.9-rc1 I see conflicts at least against
arch/arm64/Kconfig. Luckily git am -3 seems to be able to fix that up
automatically, but this will need to be rebased before the next posting
and/or merging.

On Thu, Sep 29, 2016 at 02:17:12AM +0800, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> +static int __init map_gt_gsi(u32 interrupt, u32 flags)
> +{
> +	int trigger, polarity;
> +
> +	if (!interrupt)
> +		return 0;

Urgh.

Only the secure interrupt (which we do not need) is optional in this
manner, and (hilariously), zero appears to also be a valid GSIV, per
figure 5-24 in the ACPI 6.1 spec.

So, I think that:

(a) we should not bother parsing the secure interrupt
(b) we should drop the check above
(c) we should report the spec issue to the ASWG

> +/*
> + * acpi_gtdt_c3stop - got c3stop info from GTDT
> + *
> + * Returns 1 if the timer is powered in deep idle state, 0 otherwise.
> + */
> +bool __init acpi_gtdt_c3stop(void)
> +{
> +	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
> +
> +	return !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
> +}

It looks like this can differ per interrupt. Shouldn't we check the
appropriate one?

> +int __init acpi_gtdt_init(struct acpi_table_header *table)
> +{
> +	void *start;
> +	struct acpi_table_gtdt *gtdt;
> +
> +	gtdt = container_of(table, struct acpi_table_gtdt, header);
> +
> +	acpi_gtdt_desc.gtdt = gtdt;
> +	acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
> +
> +	if (table->revision < 2) {
> +		pr_debug("Revision:%d doesn't support Platform Timers.\n",
> +			 table->revision);
> +		return 0;
> +	}
> +
> +	if (!gtdt->platform_timer_count) {
> +		pr_debug("No Platform Timer.\n");
> +		return 0;
> +	}
> +
> +	start = (void *)gtdt + gtdt->platform_timer_offset;
> +	if (start < (void *)table + sizeof(struct acpi_table_gtdt)) {
> +		pr_err(FW_BUG "Failed to retrieve timer info from firmware: invalid data.\n");
> +		return -EINVAL;
> +	}
> +	acpi_gtdt_desc.platform_timer_start = start;
> +
> +	return gtdt->platform_timer_count;
> +}

This is never used as anything other than a status code.

Just return zero; we haven't parsed the platform timers themselves at
this point anyway.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
