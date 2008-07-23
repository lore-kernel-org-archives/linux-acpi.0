From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add Panasonic Laptop ACPI extras driver
Date: Wed, 23 Jul 2008 08:46:26 -0400
Message-ID: <20080723083830.ZZRA012@mailhub.coreip.homeip.net>
References: <20080722005301.GF8744@prithivi.gnumonks.org> <20080722144348.ZZRA012@mailhub.coreip.homeip.net> <20080723115307.GF8464@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:12079 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbYGWMqa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jul 2008 08:46:30 -0400
Received: by py-out-1112.google.com with SMTP id p76so1720964pyb.10
        for <linux-acpi@vger.kernel.org>; Wed, 23 Jul 2008 05:46:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080723115307.GF8464@prithivi.gnumonks.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-acpi@vger.kernel.org

Hi Harald,

On Wed, Jul 23, 2008 at 07:53:07AM -0400, Harald Welte wrote:
> Hi Dmitry, 
> 
> thanks for your valuable feedback and sorry for not including
> you into the loop earlier.
> 
> This is a new version of the patch including all your feedback.
> 
> Andi, I hope we're clear to merge it now.
>

Just couple more things after your last round of fixes. If these are
corrected you may add:

Acked-by: Dmitry Torokhov <dtro@mail.ru>

 
> +
> +static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
[..skip..]
> +
> +	key_code = pcc->keymap[hkey_num];
> +
> +	if (key_code != -1) {

This should be either KEY_RESERVED now or just remove the check
completely - since you reset the bit for KEY_RESERVED in the keybit
the input core will not propagate this event even if reported.

> +		int pushed = (result & 0x80) ? TRUE : FALSE;
> +
> +		input_report_key(hotk_input_dev, key_code, pushed);
> +		input_sync(hotk_input_dev);
> +	}
> +
> +}
[..skip..]
> +static int acpi_pcc_init_input(struct pcc_acpi *pcc)
> +{
> +	int i, rc;
> +
> +	ACPI_FUNCTION_TRACE("acpi_pcc_init_input");
> +
> +	pcc->input_dev = input_allocate_device();
> +	if (!pcc->input_dev) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> +				  "Couldn't allocate input device for hotkey"));
> +		return -ENOMEM;
> +	}
> +
> +	pcc->input_dev->evbit[0] = BIT(EV_KEY);
> +
> +	for (i = 0; i < sizeof(pcc->keymap); i++)
> +		__set_bit(pcc->keymap[i], pcc->input_dev->keybit);
> +	__clear_bit(KEY_RESERVED, pcc->input_dev->keybit);
> +

This should be done after copying the initial keymap, otherwise you
won't really set any bits because pcc is zeroed upon allocation.

> +	pcc->input_dev->name = ACPI_PCC_DRIVER_NAME;
> +	pcc->input_dev->phys = ACPI_PCC_INPUT_PHYS;
> +	pcc->input_dev->id.bustype = BUS_HOST;
> +	pcc->input_dev->id.vendor = 0x0001;
> +	pcc->input_dev->id.product = 0x0001;
> +	pcc->input_dev->id.version = 0x0100;
> +	pcc->input_dev->getkeycode = pcc_getkeycode;
> +	pcc->input_dev->setkeycode = pcc_setkeycode;
> +
> +	/* load initial keymap */
> +	memcpy(pcc->keymap, initial_keymap, sizeof(pcc->keymap));
> +

Thanks!

-- 
Dmitry
