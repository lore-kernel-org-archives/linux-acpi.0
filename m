From: Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH v11 1/5] nfit, libnvdimm: clarify "commands" vs "_DSMs"
Date: Thu, 5 May 2016 10:24:51 -0600
Message-ID: <20160505162451.GB6808@tevye.fc.hp.com>
References: <146189774241.29835.12947278159500915461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <146189774794.29835.11997438198616276280.stgit@dwillia2-desk3.amr.corp.intel.com>
Reply-To: Jerry.Hoemann@hpe.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:39191 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757692AbcEEQYz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2016 12:24:55 -0400
Content-Disposition: inline
In-Reply-To: <146189774794.29835.11997438198616276280.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, Christoph Hellwig <hch@infradead.org>, linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com

On Thu, Apr 28, 2016 at 07:42:28PM -0700, Dan Williams wrote:
> Clarify the distinction between "commands", the ioctls userspace calls
> to request the kernel take some action on a given dimm device, and
> "_DSMs", the actual function numbers used in the firmware interface to
> the DIMM.  _DSMs are ACPI specific whereas commands are Linux kernel
> generic.
> 
> This is in preparation for breaking the 1:1 implicit relationship
> between the kernel ioctl number space and the firmware specific function
> numbers.
> 
> Cc: Jerry Hoemann <jerry.hoemann@hpe.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/acpi/nfit.c              |   21 +++++++++++++--------
>  drivers/acpi/nfit.h              |    4 ++--
>  drivers/nvdimm/bus.c             |    8 ++++----
>  drivers/nvdimm/core.c            |    2 +-
>  drivers/nvdimm/dimm_devs.c       |   18 ++++++++++++------
>  drivers/nvdimm/nd-core.h         |    2 +-
>  include/linux/libnvdimm.h        |    5 +++--
>  tools/testing/nvdimm/test/nfit.c |   27 ++++++++++++++-------------
>  8 files changed, 50 insertions(+), 37 deletions(-)
> 

....


> diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
> index 3187322eeed7..ed899a411c22 100644
> --- a/tools/testing/nvdimm/test/nfit.c
> +++ b/tools/testing/nvdimm/test/nfit.c
> @@ -344,8 +344,9 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
>  
>  	if (nvdimm) {
>  		struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +		unsigned long cmd_mask = nvdimm_cmd_mask(nvdimm);
>  
> -		if (!nfit_mem || !test_bit(cmd, &nfit_mem->dsm_mask))
> +		if (!nfit_mem || !test_bit(cmd, &cmd_mask))
>  			return -ENOTTY;
>  
>  		/* lookup label space for the given dimm */
> @@ -374,7 +375,7 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
>  	} else {
>  		struct ars_state *ars_state = &t->ars_state;
>  
> -		if (!nd_desc || !test_bit(cmd, &nd_desc->dsm_mask))
> +		if (!nd_desc || !test_bit(cmd, &nd_desc->cmd_mask))
>  			return -ENOTTY;
>  
>  		switch (cmd) {
> @@ -1251,13 +1252,13 @@ static void nfit_test0_setup(struct nfit_test *t)
>  	post_ars_status(&t->ars_state, t->spa_set_dma[0], SPA0_SIZE);
>  
>  	acpi_desc = &t->acpi_desc;
> -	set_bit(ND_CMD_GET_CONFIG_SIZE, &acpi_desc->dimm_dsm_force_en);
> -	set_bit(ND_CMD_GET_CONFIG_DATA, &acpi_desc->dimm_dsm_force_en);
> -	set_bit(ND_CMD_SET_CONFIG_DATA, &acpi_desc->dimm_dsm_force_en);
> -	set_bit(ND_CMD_ARS_CAP, &acpi_desc->bus_dsm_force_en);
> -	set_bit(ND_CMD_ARS_START, &acpi_desc->bus_dsm_force_en);
> -	set_bit(ND_CMD_ARS_STATUS, &acpi_desc->bus_dsm_force_en);
> -	set_bit(ND_CMD_CLEAR_ERROR, &acpi_desc->bus_dsm_force_en);
> +	set_bit(ND_CMD_GET_CONFIG_SIZE, &acpi_desc->dimm_cmd_force_en);
> +	set_bit(ND_CMD_GET_CONFIG_DATA, &acpi_desc->dimm_cmd_force_en);
> +	set_bit(ND_CMD_SET_CONFIG_DATA, &acpi_desc->dimm_cmd_force_en);
> +	set_bit(ND_CMD_ARS_CAP, &acpi_desc->bus_cmd_force_en);
> +	set_bit(ND_CMD_ARS_START, &acpi_desc->bus_cmd_force_en);
> +	set_bit(ND_CMD_ARS_STATUS, &acpi_desc->bus_cmd_force_en);
> +	set_bit(ND_CMD_CLEAR_ERROR, &acpi_desc->bus_cmd_force_en);
>  }


Do you still want to have ND_CMD_CALL bit set?

ND_CMD_CALL is defined in your next patch, so you'll need
to re-order or put another patch to this function to set ND_CMD_CALL.

>  
>  static void nfit_test1_setup(struct nfit_test *t)
> @@ -1315,10 +1316,10 @@ static void nfit_test1_setup(struct nfit_test *t)
>  	post_ars_status(&t->ars_state, t->spa_set_dma[0], SPA2_SIZE);
>  
>  	acpi_desc = &t->acpi_desc;
> -	set_bit(ND_CMD_ARS_CAP, &acpi_desc->bus_dsm_force_en);
> -	set_bit(ND_CMD_ARS_START, &acpi_desc->bus_dsm_force_en);
> -	set_bit(ND_CMD_ARS_STATUS, &acpi_desc->bus_dsm_force_en);
> -	set_bit(ND_CMD_CLEAR_ERROR, &acpi_desc->bus_dsm_force_en);
> +	set_bit(ND_CMD_ARS_CAP, &acpi_desc->bus_cmd_force_en);
> +	set_bit(ND_CMD_ARS_START, &acpi_desc->bus_cmd_force_en);
> +	set_bit(ND_CMD_ARS_STATUS, &acpi_desc->bus_cmd_force_en);
> +	set_bit(ND_CMD_CLEAR_ERROR, &acpi_desc->bus_cmd_force_en);
>  }
>  
>  static int nfit_test_blk_do_io(struct nd_blk_region *ndbr, resource_size_t dpa,

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
