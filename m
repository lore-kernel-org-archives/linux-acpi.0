From: Ingo Molnar <mingo@elte.hu>
Subject: Re: x86: Change static allocation of trampoline area
Date: Mon, 8 Dec 2008 13:50:58 +0100
Message-ID: <20081208125057.GC16560@elte.hu>
References: <200812080050.23275.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:38326 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945AbYLHMvZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Dec 2008 07:51:25 -0500
Content-Disposition: inline
In-Reply-To: <200812080050.23275.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: x86: Change static allocation of trampoline area
> Impact: Improvement
> 
> While debugging a suspend-to-RAM related issue it occured to me that
> if the trampoline code had grown past 4 KB, we would have been
> allocating too little memory for it, since the 4 KB size of the
> trampoline is hardcoded into arch/x86/kernel/e820.c .  Change that
> by making the kernel compute the trampoline size and allocate as much
> memory as necessary.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  arch/x86/include/asm/trampoline.h |    7 +++++++
>  arch/x86/kernel/e820.c            |   16 ----------------
>  arch/x86/kernel/head32.c          |    3 +++
>  arch/x86/kernel/head64.c          |    3 +++
>  arch/x86/kernel/trampoline.c      |   19 +++++++++++++++++--
>  5 files changed, 30 insertions(+), 18 deletions(-)

applied to tip/x86/setup-memory, thanks Rafael!

	Ingo
