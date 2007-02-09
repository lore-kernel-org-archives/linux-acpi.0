From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Bad libata resume behaviour due to ACPICA change (in acpi-test)
Date: Fri, 9 Feb 2007 16:58:01 -0200
Message-ID: <20070209185801.GA4536@khazad-dum.debian.net>
References: <20070203004140.GB619@khazad-dum.debian.net> <B41635854730A14CA71C92B36EC22AAC803F9D@mssmsx411> <20070208153025.GA466@khazad-dum.debian.net> <45CB62EE.8020300@linux.intel.com> <20070209025910.GA12298@khazad-dum.debian.net> <45CC8EE8.2080107@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:54825 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2992441AbXBIS6W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Feb 2007 13:58:22 -0500
Content-Disposition: inline
In-Reply-To: <45CC8EE8.2080107@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

> Disable wake GPEs only once.
> 
> From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
> 
> ---
> 
>  drivers/acpi/events/evgpe.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
> index dfac3ec..263a001 100644
> --- a/drivers/acpi/events/evgpe.c
> +++ b/drivers/acpi/events/evgpe.c
> @@ -644,6 +644,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
>  		 * 1) We must disable this particular wake GPE so it won't fire again
>  		 * 2) We want to disable all wake GPEs, since we are now awake
>  		 */
> +		acpi_gbl_system_awake_and_running = TRUE;
>  		(void)acpi_hw_disable_all_gpes();
>  	}

Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The above patch fixes the issue on the T43.  Tested with patch on top of
acpi-test a19357b3 in defconfig with SMP disabled.

Thanks, Alexey!

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
