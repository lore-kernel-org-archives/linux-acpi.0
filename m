Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A34C433EF
	for <linux-acpi@archiver.kernel.org>; Fri, 25 Feb 2022 15:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiBYPB5 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 25 Feb 2022 10:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiBYPB4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Feb 2022 10:01:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACD841E4816
        for <linux-acpi@vger.kernel.org>; Fri, 25 Feb 2022 07:01:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7979E106F;
        Fri, 25 Feb 2022 07:01:15 -0800 (PST)
Received: from bogus (unknown [10.57.3.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FE773F5A1;
        Fri, 25 Feb 2022 07:01:14 -0800 (PST)
Date:   Fri, 25 Feb 2022 15:00:25 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Ray.Huang@amd.com
Subject: Re: [PATCH 2/2] ACPI: processor idle: Check for architectural
 support for LPI
Message-ID: <20220225150025.dkoiszsqne4mkeiq@bogus>
References: <20220225031255.3647599-1-mario.limonciello@amd.com>
 <20220225031255.3647599-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225031255.3647599-3-mario.limonciello@amd.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 24, 2022 at 09:12:55PM -0600, Mario Limonciello wrote:
> When `osc_pc_lpi_support_confirmed` is set through `_OSC` and `_LPI` is
> populated then the cpuidle driver assumes that LPI is fully functional.
> 
> However currently the kernel only provides architectural support for LPI
> on ARM.  This leads to high power consumption on X86 platforms that
> otherwise try to enable LPI.
> 
> So probe whether or not LPI support is implemented before enabling LPI in
> the kernel.  This is done by overloading `acpi_processor_ffh_lpi_probe` to
> check whether it returns `-EOPNOTSUPP`. It also means that all future
> implementations of `acpi_processor_ffh_lpi_probe` will need to follow
> these semantics as well.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/processor_idle.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index f8e9fa82cb9b..0092fd479527 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1080,6 +1080,11 @@ static int flatten_lpi_states(struct acpi_processor *pr,
>  	return 0;
>  }
>  
> +int __weak acpi_processor_ffh_lpi_probe(unsigned int cpu)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
>  {
>  	int ret, i;
> @@ -1094,6 +1099,11 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
>  	if (!acpi_has_method(handle, "_LPI"))
>  		return -EINVAL;
>  
> +	/* make sure our architecture has support */
> +	ret = acpi_processor_ffh_lpi_probe(pr->id);
> +	if (ret == -EOPNOTSUPP)
> +		return ret;
> +

You can do this check first, before even checking osc_pc_lpi_support_confirmed
and looking for _LPI method IMO as they are not useful if arch doesn't support
handling LPIs.

Either way,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
