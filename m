From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 6/7] x86: irq no should not use hex in /proc/interrupts
Date: Thu, 25 Sep 2008 10:39:36 +0200
Message-ID: <20080925083936.GD4519@elte.hu>
References: <1222308277-10984-1-git-send-email-yhlu.kernel@gmail.com> <1222308277-10984-6-git-send-email-yhlu.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:34539 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754174AbYIYIj4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Sep 2008 04:39:56 -0400
Content-Disposition: inline
In-Reply-To: <1222308277-10984-6-git-send-email-yhlu.kernel@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>


* Yinghai Lu <yhlu.kernel@gmail.com> wrote:

> Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
> ---
>  arch/x86/kernel/irq_32.c |    2 +-
>  arch/x86/kernel/irq_64.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

applied to tip/irq/sparseirq, thanks Yinghai!

	Ingo
