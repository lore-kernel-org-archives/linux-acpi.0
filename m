From: Alex Chiang <achiang@canonical.com>
Subject: Re: [PATCH] ACPI: DMI init_set_sci_en_on_resume for multiple
 Lenovo ThinkPads
Date: Thu, 22 Apr 2010 14:41:16 -0600
Message-ID: <20100422204116.GB2621@canonical.com>
References: <20100420140314.GA5573@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:49850 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155Ab0DVUlY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Apr 2010 16:41:24 -0400
Content-Disposition: inline
In-Reply-To: <20100420140314.GA5573@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, colin.king@canonical.com, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org

* Alex Chiang <achiang@canonical.com>:
> +	.callback = init_set_sci_en_on_resume,
> +	.ident = "Lenovo ThinkPad X201",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201"),
> +		},
> +	},
> +	{
> +	.callback = init_set_sci_en_on_resume,
> +	.ident = "Lenovo ThinkPad X201",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201s"),
> +		},
> +	},
> +	{

Whoops, not only is the .ident line wrong for the second entry
above (should be X201s), it's also extraneous, as the first entry
will catch it.

I'll resubmit.

/ac

