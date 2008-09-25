From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 7/7] x86: print out irq nr for msi/ht -v2
Date: Thu, 25 Sep 2008 10:42:16 +0200
Message-ID: <20080925084212.GE4519@elte.hu>
References: <1222323223-23529-1-git-send-email-yhlu.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:35230 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbYIYImf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Sep 2008 04:42:35 -0400
Content-Disposition: inline
In-Reply-To: <1222323223-23529-1-git-send-email-yhlu.kernel@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org


* Yinghai Lu <yhlu.kernel@gmail.com> wrote:

> v2: fix hpet compiling
> 
> Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
> ---
>  arch/x86/kernel/hpet.c    |    3 +++
>  arch/x86/kernel/io_apic.c |    7 +++++++
>  2 files changed, 10 insertions(+), 0 deletions(-)

applied to tip/irq/sparseirq, thanks Yinghai.

	Ingo
