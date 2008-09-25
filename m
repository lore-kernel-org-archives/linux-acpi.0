From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 4/7] mm: print out meminit for memmap
Date: Thu, 25 Sep 2008 10:35:33 +0200
Message-ID: <20080925083533.GB4519@elte.hu>
References: <1222308277-10984-1-git-send-email-yhlu.kernel@gmail.com> <1222308277-10984-4-git-send-email-yhlu.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:60947 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105AbYIYIgE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Sep 2008 04:36:04 -0400
Content-Disposition: inline
In-Reply-To: <1222308277-10984-4-git-send-email-yhlu.kernel@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org


* Yinghai Lu <yhlu.kernel@gmail.com> wrote:

> Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
> ---
>  mm/page_alloc.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)

rationale: improve debuggability of memory setup problems.

	Ingo
