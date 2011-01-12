From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI, APEI, Generic Hardware Error Source POLL/IRQ/NMI
 notification type support
Date: Tue, 11 Jan 2011 23:55:24 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101112341350.11311@x980>
References: <1294362425.18956.7.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:50318 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077Ab1ALEzp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jan 2011 23:55:45 -0500
In-reply-to: <1294362425.18956.7.camel@yhuang-dev>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

>        if (error_block_length > GHES_ESTATUS_MAX_SIZE) {
>-               pr_warning(FW_WARN GHES_PFX
>-                          "Error status block length is too long: %u for "
>-                          "generic hardware error source: %d.\n",
>+               pr_warning(
>+FW_WARN GHES_PFX "Error status block length is too long: %u for \n"
>+"generic hardware error source: %d.\n",
>                           error_block_length, generic->header.source_id);
>                error_block_length = GHES_ESTATUS_MAX_SIZE;

Hi Ying,

I assume that you are tweaking these pr_warning() lines
to beautify the output, but as far as source
code readability, I liked the previous syntax better.

Although maintainer's opinions vary, I generally do not
strictly enforce the 80 column rule for printk strings.
Ie. I think that code readability with good whitespace
indentation plus printk string grep-ability are more
important than strictly fitting within 80-columns.

thanks,
Len Brown, Intel Open Source Technology Center
