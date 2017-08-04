From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Fri, 4 Aug 2017 06:05:25 +0200
Message-ID: <20170804040525.GE12082@nazgul.tnic>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
 <20170803215753.30553-5-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170803215753.30553-5-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: rjw@rjwysocki.net, mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 03, 2017 at 03:57:50PM -0600, Toshi Kani wrote:
> ghes_edac_register() is called for each GHES platform device
> instantiated per a GHES entry in ACPI HEST table.  dmi_walk()
> counts the number of DIMMs on the system, and there is no need
> to call it multiple times.
> 
> Change ghes_edac_register() to call dmi_walk() only when
> 'num_dimm' is uninitialized.
> 
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>  drivers/edac/ghes_edac.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 4e61a62..2e9ce9c 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -407,15 +407,18 @@ EXPORT_SYMBOL_GPL(ghes_edac_report_mem_error);
>  
>  int ghes_edac_register(struct ghes *ghes, struct device *dev)
>  {
> -	bool fake = false;
> -	int rc, num_dimm = 0;
>  	struct mem_ctl_info *mci;
>  	struct edac_mc_layer layers[1];
>  	struct ghes_edac_pvt *pvt;
>  	struct ghes_edac_dimm_fill dimm_fill;
> +	int rc;
> +
> +	static int num_dimm;
> +	static bool fake;
>  
>  	/* Get the number of DIMMs */
> -	dmi_walk(ghes_edac_count_dimms, &num_dimm);
> +	if (num_dimm == 0)
> +		dmi_walk(ghes_edac_count_dimms, &num_dimm);

So the problem is that ghes_edac_register() gets called multiple times
depending on how many GHES platform devices are on the system. But yet
they all scan *all* DIMMs. So instead you should return if the DIMMs
have been counted already and not register a second time.

Which makes that whole mc counting kinda useless. So you could rip that
out too.

Unless I'm missing something...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
