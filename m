From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [4/6] 2.6.21-rc2: known regressions
Date: Mon, 05 Mar 2007 12:21:14 +0000
Message-ID: <1173097274.5842.25.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org>
	 <20070305015039.GI3441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tim.rpsys.net ([194.106.48.114]:55471 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933386AbXCEMZY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Mar 2007 07:25:24 -0500
In-Reply-To: <20070305015039.GI3441@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Nelless <andrew@nelless.net>, Len Brown <len.brown@intel.com>, "Antonino A. Daplas" <adaplas@gmail.com>, linux-acpi@vger.kernel.org, Jiri Kosina <jikos@jikos.cz>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Yaroslav Halchenko <kernel@onerussian.com>, Alex Romosan <romosan@sycorax.lbl.gov>, David Miller <davem@davemloft.net>, James Simmons <jsimmons@infradead.org>, benh@kernel.crashing.org, Andreas Schwab <schwab@suse.de>

On Mon, 2007-03-05 at 02:50 +0100, Adrian Bunk wrote:
> Subject    : LCD is dimmed  (ibm-acpi related)
> References : http://lkml.org/lkml/2007/2/25/206
> Submitter  : Jiri Kosina <jikos@jikos.cz>
> Caused-By  : Richard Purdie <rpurdie@rpsys.net>
>              commit 994efacdf9a087b52f71e620b58dfa526b0cf928
> Handled-By : Jiri Kosina <jikos@jikos.cz>
>              Richard Purdie <rpurdie@rpsys.net>
>              Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Status     : patches are being discussed

The confirmed fix is in the ACPI test branch for this.

> Subject    : no backlight on radeon
> References : http://lkml.org/lkml/2007/2/19/1
> Submitter  : Yaroslav Halchenko <kernel@onerussian.com>
>              Alex Romosan <romosan@sycorax.lbl.gov>
>              David Miller <davem@davemloft.net>
> Caused-By  : James Simmons <jsimmons@infradead.org>
>              commit e0e34ef7f02915cfe50e501e9f32c24217177a96
> Handled-By : Richard Purdie <rpurdie@rpsys.net>
>              James Simmons <jsimmons@infradead.org>
>              Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Status     : problem is being discussed
> 
> 
> Subject    : nvidiafb broken
> References : http://lkml.org/lkml/2007/2/24/36
> Submitter  : Andreas Schwab <schwab@suse.de>
> Caused-By  : Richard Purdie <rpurdie@rpsys.net>
>              commit 599a52d12629394236d785615808845823875868
> Handled-By : Richard Purdie <rpurdie@rpsys.net>
> Patch      : http://lkml.org/lkml/2007/2/26/43
> Status     : patch available

The confirmed fixes for both of these are in the backlight tree. I was
waiting for any further feedback on the first issue above but will send
them to Linus now.

Cheers,

Richard

