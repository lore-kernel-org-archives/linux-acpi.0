From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2/2] ACPI: fix broken usage of acpi_ut_get_node_name()
Date: Wed, 4 Mar 2009 22:40:58 -0300
Message-ID: <20090305014058.GC12234@khazad-dum.debian.net>
References: <1235486898-27756-1-git-send-email-hmh@hmh.eng.br> <1235486898-27756-2-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:59358 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754477AbZCEBlD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2009 20:41:03 -0500
Content-Disposition: inline
In-Reply-To: <1235486898-27756-2-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: stable@kernel.org, linux-acpi@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>

PING...

This is a cosmetic fix, but it still avoids random binary crap leaking
into debug messages, for the price of an obvious 3-char change.

Can I get an ACK for it, please?  I'd like to see this go into
2.6.28.y...

On Tue, 24 Feb 2009, Henrique de Moraes Holschuh wrote:
> acpi_ut_get_node_name() returns a four char fixed-size array, not
> NULL-terminated.
> 
> This issue was fixed indirectly in mainline by commit
> 60a4ce7f4148155d3f28eea4a213f7ee47cd57b7.
> 
> This is the minimal fix for stable 2.6.28.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: stable@kernel.org
> Cc: Lin Ming <ming.m.lin@intel.com>
> ---
>  drivers/acpi/power.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index bb7d50d..ad55db1 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -151,7 +151,7 @@ static int acpi_power_get_state(acpi_handle handle, int *state)
>  	*state = (sta & 0x01)?ACPI_POWER_RESOURCE_STATE_ON:
>  			      ACPI_POWER_RESOURCE_STATE_OFF;
>  
> -	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] is %s\n",
> +	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%4.4s] is %s\n",
>  			  acpi_ut_get_node_name(handle),
>  				*state ? "on" : "off"));
>  

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
