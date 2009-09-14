From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2/3] thinkpad_acpi: fix rfkill memory leak on unload
Date: Mon, 14 Sep 2009 10:22:07 -0300
Message-ID: <20090914132207.GB32253@khazad-dum.debian.net>
References: <1252925033-29696-1-git-send-email-corentincj@iksaif.net>
 <1252925033-29696-2-git-send-email-corentincj@iksaif.net>
 <1252925033-29696-3-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59591 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755389AbZINNWH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Sep 2009 09:22:07 -0400
Content-Disposition: inline
In-Reply-To: <1252925033-29696-3-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Julia Lawall <julia@diku.dk>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Johannes Berg <johannes@sipsolutions.net>

On Mon, 14 Sep 2009, Corentin Chary wrote:
> rfkill_unregister() should always be followed by rfkill_destroy()
> 
> Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Signed-off-by: Corentin Chary <corentincj@iksaif.net>

Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: stable@kernel.org

> ---
>  drivers/platform/x86/thinkpad_acpi.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index e856008..21c9715 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -1278,6 +1278,7 @@ static void tpacpi_destroy_rfkill(const enum tpacpi_rfk_id id)
>  	tp_rfk = tpacpi_rfkill_switches[id];
>  	if (tp_rfk) {
>  		rfkill_unregister(tp_rfk->rfkill);
> +		rfkill_destroy(tp_rfk->rfkill);
>  		tpacpi_rfkill_switches[id] = NULL;
>  		kfree(tp_rfk);
>  	}

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
