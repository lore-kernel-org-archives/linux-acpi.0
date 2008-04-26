From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 38/54] PNP: remove PNP_MAX_* uses
Date: Sun, 27 Apr 2008 00:10:20 +0200
Message-ID: <4813A84C.8070309@keyaccess.nl>
References: <20080425183807.366134771@ldl.fc.hp.com> <20080425183931.822443551@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:59437 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791AbYDZWKO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Apr 2008 18:10:14 -0400
In-Reply-To: <20080425183931.822443551@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

On 25-04-08 20:38, Bjorn Helgaas wrote:

> +#define set(flags)      ((flags & IORESOURCE_UNSET) == 0)
> +
>  static ssize_t pnp_show_current_resources(struct device *dmdev,
>  					  struct device_attribute *attr,
>  					  char *buf)
>  {
>  	struct pnp_dev *dev = to_pnp_dev(dmdev);
> +	struct resource *res;
>  	int i, ret;
>  	pnp_info_buffer_t *buffer;
>  
> @@ -267,50 +270,46 @@
>  	else
>  		pnp_printf(buffer, "disabled\n");
>  
> -	for (i = 0; i < PNP_MAX_PORT; i++) {
> -		if (pnp_port_valid(dev, i)) {
> +	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_IO, i)); i++) {
> +		if (set(res->flags)) {


You've at this point already introduced the pnp_resource_valid() inline. Use 
here maybe? (also other locations here)

Rene.
