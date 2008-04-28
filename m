From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 44/54] PNP: add pnp_new_resource() to find a new unset pnp_resource
Date: Mon, 28 Apr 2008 14:43:41 -0600
Message-ID: <200804281443.42075.bjorn.helgaas@hp.com>
References: <20080425183807.366134771@ldl.fc.hp.com> <20080425183933.066428168@ldl.fc.hp.com> <4813AEB6.9070901@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:20537 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933172AbYD1Unl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Apr 2008 16:43:41 -0400
In-Reply-To: <4813AEB6.9070901@keyaccess.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

On Saturday 26 April 2008 04:37:42 pm Rene Herman wrote:
> On 25-04-08 20:38, Bjorn Helgaas wrote:
> 
> > +	switch (type) {
> > +	case IORESOURCE_IO:
> > +		for (i = 0; i < PNP_MAX_PORT; i++) {
> > +			pnp_res = &dev->res->port[i];
> > +			res = &pnp_res->res;
> > +			if (res->flags & IORESOURCE_UNSET)
> > +				return pnp_res;
> 
> Again possible users of pnp_resource_valid().

Done; I also converted to use pnp_get_pnp_resource().
