From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 5/7] x86: fix typo in irq_desc array
Date: Thu, 25 Sep 2008 10:36:45 +0200
Message-ID: <20080925083643.GC4519@elte.hu>
References: <1222308277-10984-1-git-send-email-yhlu.kernel@gmail.com> <1222308277-10984-5-git-send-email-yhlu.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1222308277-10984-5-git-send-email-yhlu.kernel@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


* Yinghai Lu <yhlu.kernel@gmail.com> wrote:

> when SPARSE_IRQ is not used, should still use irq_desc->lock
> 
> Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
> ---
>  kernel/irq/handle.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

applied to tip/irq/sparseirq, thanks Yinghai!

	Ingo
