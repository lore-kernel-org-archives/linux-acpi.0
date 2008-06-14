From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 18/18] PNP: convert resource options to single linked
 list
Date: Sat, 14 Jun 2008 12:31:54 +0200
Message-ID: <48539E1A.90601@keyaccess.nl>
References: <20080604220933.168145536@ldl.fc.hp.com> <20080604221130.337606204@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:49988 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbYFNKkO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Jun 2008 06:40:14 -0400
In-Reply-To: <20080604221130.337606204@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

On 05-06-08 00:09, Bjorn Helgaas wrote:

> ISAPNP, PNPBIOS, and ACPI describe the "possible resource settings" of

[ ... ]

Acked-by: Rene Herman <rene.herman@gmail.com>

Only minor comment:

> +static inline unsigned int pnp_independent_option(void)
> +{
> +	return 0;
> +}

I think this is a somewhat unintuitive name (the function doesn't return 
an option) and now that the pnp_dependent_option() one has been renamed 
to pnp_new_dependent_set() even the symmetry doesn't survive.

pnp_independent_option_flags? pnp_independent_flags? Or better yet, just 
literal 0? That last one unless you have some as of yet unpublished plan 
for the abstraction ofcourse but this function seems to obscure more 
than it helps any at the moment.

Even if you agree, obviously also fine as follow-up patch.

Only trivial:

> +static int pnp_assign_resources(struct pnp_dev *dev, int set)
> {

[ ... ]

> -fail:
> -	pnp_clean_resource_table(dev);
>  	mutex_unlock(&pnp_res_mutex);
> -	dbg_pnp_show_resources(dev, "after pnp_assign_resources (failed)");
> -	return 0;
> +	if (ret) {
> +		dev_dbg(&dev->dev, "pnp_assign_resources failed (%d)\n", ret);
> +		pnp_clean_resource_table(dev);
> +	} else
> +		dbg_pnp_show_resources(dev, "pnp_assign_resources succeeded");
> +	return ret;
>  }

if (ret < 0) would agree with the rest.

>  int pnp_auto_config_dev(struct pnp_dev *dev)
>  {
> -	struct pnp_option *dep;
> -	int i = 1;
> +	int i, ret = 0;

int ret; will do;

Rene.

