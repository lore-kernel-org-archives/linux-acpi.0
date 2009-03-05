From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/2] ACPI: fix broken usage of name.ascii
Date: Wed, 4 Mar 2009 22:38:26 -0300
Message-ID: <20090305013826.GB12234@khazad-dum.debian.net>
References: <1235486898-27756-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:56793 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751269AbZCEBib (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2009 20:38:31 -0500
Content-Disposition: inline
In-Reply-To: <1235486898-27756-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: stable@kernel.org, linux-acpi@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>

PING...

Len, can I get an ack for this, so that the stable crowd will pick it up?

Without this patch, we can have weird crap happening in EC GPE handling, all
it takes is for the pointer that follows name.ascii to have a first byte
that looks like a valid hex digit...

And it is just a trivial one-char fix...

On Tue, 24 Feb 2009, Henrique de Moraes Holschuh wrote:
> acpi_namespace_node's name.ascii field is four chars, and not NULL-
> terminated except by pure luck.  So, it cannot be used by sscanf() without
> a length restriction.
> 
> This issue was fixed indirectly in mainline by commit
> 0175d562a29ad052c510782c7e76bc63d5155b9b.
> 
> This is the minimal fix for both stable 2.6.27 and 2.6.28.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: stable@kernel.org
> Cc: Lin Ming <ming.m.lin@intel.com>
> ---
>  drivers/acpi/ec.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 30f3ef2..4aa9477 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -759,9 +759,10 @@ acpi_ec_register_query_methods(acpi_handle handle, u32 level,
>  	struct acpi_namespace_node *node = handle;
>  	struct acpi_ec *ec = context;
>  	int value = 0;
> -	if (sscanf(node->name.ascii, "_Q%x", &value) == 1) {
> +
> +	if (sscanf(node->name.ascii, "_Q%2x", &value) == 1)
>  		acpi_ec_add_query_handler(ec, value, handle, NULL, NULL);
> -	}
> +
>  	return AE_OK;
>  }
>  

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
