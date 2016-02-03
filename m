From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RESEND] mailbox: pcc: fix channel calculation in get_pcc_channel()
Date: Wed, 03 Feb 2016 02:27:14 +0100
Message-ID: <1501192.nRtmsTZae5@vostro.rjw.lan>
References: <1454412562-28543-1-git-send-email-alexey.klimov@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50115 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752733AbcBCB0M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2016 20:26:12 -0500
In-Reply-To: <1454412562-28543-1-git-send-email-alexey.klimov@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Klimov <alexey.klimov@arm.com>
Cc: linux-acpi@vger.kernel.org, jassisinghbrar@gmail.com, sudeep.holla@arm.com, ashwin.chaugule@linaro.org, pprakash@codeaurora.org, linux-kernel@vger.kernel.org

On Tuesday, February 02, 2016 11:29:22 AM Alexey Klimov wrote:
> This patch fixes the calculation of pcc_chan for non-zero id.
> After the compiler ignores the (unsigned long) cast the
> pcc_mbox_channels pointer is type-cast and then the type-cast
> offset is added which results in address outside of the range
> leading to the kernel crashing.
> 
> We might add braces and make it:
> 
> pcc_chan = (struct mbox_chan *)
> 		((unsigned long) pcc_mbox_channels +
> 		(id * sizeof(*pcc_chan)));
> 
> but let's go with array approach here and use id as index.
> 
> Tested on Juno board.
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@arm.com>

Jassi said this was applied, so I'm not taking it.

Thanks,
Rafael

