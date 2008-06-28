From: Joe Perches <joe@perches.com>
Subject: Re: [patch 11/28] PNP: whitespace/coding style fixes
Date: Sat, 28 Jun 2008 12:56:23 -0700
Message-ID: <1214682983.8758.66.camel@localhost>
References: <20080627225651.663174474@ldl.fc.hp.com>
	 <20080627225800.517972351@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 136-022.dsl.labridge.com ([206.117.136.22]:1524 "EHLO
	mail.perches.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbYF1T5K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 15:57:10 -0400
In-Reply-To: <20080627225800.517972351@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Jiri Slaby <jirislaby@gmail.com>, David Howells <dhowells@redhat.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Fri, 2008-06-27 at 16:57 -0600, Bjorn Helgaas wrote:
> Index: work10/drivers/pnp/interface.c
> ===================================================================
> --- work10.orig/drivers/pnp/interface.c	2008-05-09 14:42:25.000000000 -0600
> +++ work10/drivers/pnp/interface.c	2008-05-09 14:45:57.000000000 -0600
> @@ -216,12 +216,12 @@ static ssize_t pnp_show_options(struct d
>  				struct device_attribute *attr, char *buf)
>  {
>  	struct pnp_dev *dev = to_pnp_dev(dmdev);
> +	pnp_info_buffer_t *buffer;
>  	struct pnp_option *independent = dev->independent;
>  	struct pnp_option *dependent = dev->dependent;
>  	int ret, dep = 1;
>  
> -	pnp_info_buffer_t *buffer = (pnp_info_buffer_t *)
> -	    pnp_alloc(sizeof(pnp_info_buffer_t));
> +	buffer = pnp_alloc(sizeof(pnp_info_buffer_t));
>  	if (!buffer)
>  		return -ENOMEM;

Wouldn't it be nicer without the unnecessary cast?

	pnp_info_buffer_t *buffer = pnp_alloc(sizeof(*buffer));

