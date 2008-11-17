From: "Alan Jenkins" <alan-jenkins@tuffmail.co.uk>
Subject: Re: [Patch 2/3] eeepc-laptop: Check return values from rfkill_register
Date: Mon, 17 Nov 2008 15:09:21 +0000
Message-ID: <9b2b86520811170709o4581a064v957ae41403b6113@mail.gmail.com>
References: <20081117133325.GB12303@srcf.ucam.org>
	 <20081117133510.GC12303@srcf.ucam.org>
	 <20081117133804.GD12303@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:32772 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbYKQPJX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Nov 2008 10:09:23 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1022058yxm.1
        for <linux-acpi@vger.kernel.org>; Mon, 17 Nov 2008 07:09:22 -0800 (PST)
In-Reply-To: <20081117133804.GD12303@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, ecc@cmu.edu, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org

On 11/17/08, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> We should check that rfkill registration succeeds and error out if it
> doesn't. This patch also sets the default state to match the BIOS on
> load.
>
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
>
> diff --git a/drivers/misc/eeepc-laptop.c b/drivers/misc/eeepc-laptop.c

You change the usage of the "end" label so it's now only reached on
failure.  How about renaming it to "fail" or "ehotk_fail"?  Also, it
looks like "if (result)" is now redundant - result will always be
non-zero in the error path.

> +	return 0;
>
> + bluetooth_fail:
> +	if (ehotk->eeepc_bluetooth_rfkill)
> +		rfkill_free(ehotk->eeepc_bluetooth_rfkill);
> +	rfkill_unregister(ehotk->eeepc_wlan_rfkill);
> +	ehotk->eeepc_wlan_rfkill = NULL;
> + wlan_fail:
> +	if (ehotk->eeepc_wlan_rfkill)
> +		rfkill_free(ehotk->eeepc_wlan_rfkill);
>   end:
>  	if (result) {
>  		kfree(ehotk);
