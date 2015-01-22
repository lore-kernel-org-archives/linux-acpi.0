From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [PATCH v2 1/4] x86: pmc_atom: save struct device pointer in pmc
Date: Thu, 22 Jan 2015 11:42:08 +0800
Message-ID: <54C07190.3090403@linux.intel.com>
References: <1421790603-30097-1-git-send-email-andriy.shevchenko@linux.intel.com> <1421790603-30097-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51460 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbbAVDmL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Jan 2015 22:42:11 -0500
In-Reply-To: <1421790603-30097-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, x86@kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 2015/1/21 5:50, Andy Shevchenko wrote:
> The change allows to use dev_printk() type of macros in the module functions.

The patch itself looks good to me, but not sure why do we need this
change, will we use dev_prink in the subsequent patches?

Thanks,
-Aubrey
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/kernel/pmc_atom.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/pmc_atom.c b/arch/x86/kernel/pmc_atom.c
> index d66a4fe..d338222 100644
> --- a/arch/x86/kernel/pmc_atom.c
> +++ b/arch/x86/kernel/pmc_atom.c
> @@ -26,6 +26,7 @@
>  #include <asm/pmc_atom.h>
>  
>  struct pmc_dev {
> +	struct device *dev;
>  	u32 base_addr;
>  	void __iomem *regmap;
>  #ifdef CONFIG_DEBUG_FS
> @@ -250,7 +251,7 @@ static void pmc_dbgfs_unregister(struct pmc_dev *pmc)
>  	debugfs_remove_recursive(pmc->dbgfs_dir);
>  }
>  
> -static int pmc_dbgfs_register(struct pmc_dev *pmc, struct pci_dev *pdev)
> +static int pmc_dbgfs_register(struct pmc_dev *pmc)
>  {
>  	struct dentry *dir, *f;
>  
> @@ -263,21 +264,21 @@ static int pmc_dbgfs_register(struct pmc_dev *pmc, struct pci_dev *pdev)
>  	f = debugfs_create_file("dev_state", S_IFREG | S_IRUGO,
>  				dir, pmc, &pmc_dev_state_ops);
>  	if (!f) {
> -		dev_err(&pdev->dev, "dev_state register failed\n");
> +		dev_err(pmc->dev, "dev_state register failed\n");
>  		goto err;
>  	}
>  
>  	f = debugfs_create_file("pss_state", S_IFREG | S_IRUGO,
>  				dir, pmc, &pmc_pss_state_ops);
>  	if (!f) {
> -		dev_err(&pdev->dev, "pss_state register failed\n");
> +		dev_err(pmc->dev, "pss_state register failed\n");
>  		goto err;
>  	}
>  
>  	f = debugfs_create_file("sleep_state", S_IFREG | S_IRUGO,
>  				dir, pmc, &pmc_sleep_tmr_ops);
>  	if (!f) {
> -		dev_err(&pdev->dev, "sleep_state register failed\n");
> +		dev_err(pmc->dev, "sleep_state register failed\n");
>  		goto err;
>  	}
>  
> @@ -287,7 +288,7 @@ err:
>  	return -ENODEV;
>  }
>  #else
> -static int pmc_dbgfs_register(struct pmc_dev *pmc, struct pci_dev *pdev)
> +static int pmc_dbgfs_register(struct pmc_dev *pmc)
>  {
>  	return 0;
>  }
> @@ -315,10 +316,12 @@ static int pmc_setup_dev(struct pci_dev *pdev)
>  		return -ENOMEM;
>  	}
>  
> +	pmc->dev = &pdev->dev;
> +
>  	/* PMC hardware registers setup */
>  	pmc_hw_reg_setup(pmc);
>  
> -	ret = pmc_dbgfs_register(pmc, pdev);
> +	ret = pmc_dbgfs_register(pmc);
>  	if (ret) {
>  		iounmap(pmc->regmap);
>  	}
> 

