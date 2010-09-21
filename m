From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 4/5] ACPI, APEI, Fix error path for memory allocation
Date: Tue, 21 Sep 2010 14:45:52 +0200
Message-ID: <20100921124552.GD18991@one.firstfloor.org>
References: <1284865235-29920-1-git-send-email-ying.huang@intel.com> <1284865235-29920-5-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:56884 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab0IUMpx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Sep 2010 08:45:53 -0400
Content-Disposition: inline
In-Reply-To: <1284865235-29920-5-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org

On Sun, Sep 19, 2010 at 11:00:34AM +0800, Huang Ying wrote:
> @@ -475,7 +479,13 @@ int apei_resources_request(struct apei_resources *resources,
>  		}
>  	}
>  
> -	apei_resources_merge(&apei_resources_all, resources);
> +	rc = apei_resources_merge(&apei_resources_all, resources);
> +	if (rc) {
> +		pr_err(APEI_PFX
> +"Error in APEI internal resource management, there may be inconsistent "
> +"between APEI internal and system resource management.");

Please fix the English. This will wrap in the syslog without \ns no?
Kernel messges should be not wider than 80 characters.

> +	rc = apei_resources_sub(&apei_resources_all, resources);
> +	if (rc)
> +		pr_err(APEI_PFX
> +"Error in APEI internal resource management, there may be inconsistent "
> +"between APEI internal and system resource management.");

Same.

Also instead of Error it would be better just say what is wrong and don't
try to analyze the problem.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
