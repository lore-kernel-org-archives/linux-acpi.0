From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver v0.93
Date: Thu, 3 Jul 2008 20:23:03 +0100
Message-ID: <20080703192303.GA32260@srcf.ucam.org>
References: <20080702090044.GB12272@prithivi.gnumonks.org> <20080703173542.GA5118@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54515 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbYGCTXH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jul 2008 15:23:07 -0400
Content-Disposition: inline
In-Reply-To: <20080703173542.GA5118@prithivi.gnumonks.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>

On Fri, Jul 04, 2008 at 01:35:42AM +0800, Harald Welte wrote:
> +
> +static int pcc_setkeycode(struct input_dev *dev, int scancode, int keycode)
> +{
> +	struct pcc_acpi *pcc = input_get_drvdata(dev);
> +
> +	if (scancode > ARRAY_SIZE(pcc->keymap))
> +		return -EINVAL;
> +
> +	if (keycode < 0 || keycode > KEY_MAX)
> +		return -EINVAL;
> +
> +	pcc->keymap[scancode] = keycode;

You probably want to set_bit the input device here, and also clean up 
any now-unused keycodes from there. I'd also suggest sending KEY_PROG1 
by default on the CPU throttle button - some users will find it easier 
if it already generates a keycode. Other than that, looks good.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
