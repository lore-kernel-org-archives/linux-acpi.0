From: Linda Knippers <linda.knippers@hpe.com>
Subject: Re: [PATCH v2 7/7] tools/testing/nvdimm: fix nfit_test shutdown
 crashes
Date: Fri, 14 Apr 2017 19:26:10 -0400
Message-ID: <58F15A92.3000101@hpe.com>
References: <149220702552.36563.10552898152402020832.stgit@dwillia2-desk3.amr.corp.intel.com>
 <149220706287.36563.2986440928438769021.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:33807 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754969AbdDNX0U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Apr 2017 19:26:20 -0400
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 817BC392
        for <linux-acpi@vger.kernel.org>; Fri, 14 Apr 2017 23:26:19 +0000 (UTC)
In-Reply-To: <149220706287.36563.2986440928438769021.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org

On 04/14/2017 05:57 PM, Dan Williams wrote:
> Keep the nfit_test instances alive until after nfit_test_teardown(), as
> we may be doing resource lookups until the final un-registrations have
> completed. This fixes crashes of the form.

Sorry Dan, it didn't help in my case.

-- ljk
> 
>  BUG: unable to handle kernel NULL pointer dereference at 0000000000000038
>  IP: __release_resource+0x12/0x90
>  Call Trace:
>   remove_resource+0x23/0x40
>   __wrap_remove_resource+0x29/0x30 [nfit_test_iomap]
>   acpi_nfit_remove_resource+0xe/0x10 [nfit]
>   devm_action_release+0xf/0x20
>   release_nodes+0x16d/0x2b0
>   devres_release_all+0x3c/0x60
>   device_release+0x21/0x90
>   kobject_release+0x6a/0x170
>   kobject_put+0x2f/0x60
>   put_device+0x17/0x20
>   platform_device_unregister+0x20/0x30
>   nfit_test_exit+0x36/0x960 [nfit_test]
> 
> Reported-by: Linda Knippers <linda.knippers@hpe.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  tools/testing/nvdimm/test/nfit.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
> index bc02f28ed8b8..d7fb1b894128 100644
> --- a/tools/testing/nvdimm/test/nfit.c
> +++ b/tools/testing/nvdimm/test/nfit.c
> @@ -1958,6 +1958,7 @@ static __init int nfit_test_init(void)
>  			put_device(&pdev->dev);
>  			goto err_register;
>  		}
> +		get_device(&pdev->dev);
>  
>  		rc = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>  		if (rc)
> @@ -1976,6 +1977,10 @@ static __init int nfit_test_init(void)
>  		if (instances[i])
>  			platform_device_unregister(&instances[i]->pdev);
>  	nfit_test_teardown();
> +	for (i = 0; i < NUM_NFITS; i++)
> +		if (instances[i])
> +			put_device(&instances[i]->pdev.dev);
> +
>  	return rc;
>  }
>  
> @@ -1983,10 +1988,13 @@ static __exit void nfit_test_exit(void)
>  {
>  	int i;
>  
> -	platform_driver_unregister(&nfit_test_driver);
>  	for (i = 0; i < NUM_NFITS; i++)
>  		platform_device_unregister(&instances[i]->pdev);
> +	platform_driver_unregister(&nfit_test_driver);
>  	nfit_test_teardown();
> +
> +	for (i = 0; i < NUM_NFITS; i++)
> +		put_device(&instances[i]->pdev.dev);
>  	class_destroy(nfit_test_dimm);
>  }
>  
> 

