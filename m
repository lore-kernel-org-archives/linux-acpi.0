From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] treewide: Convert clockevents_notify to use int cpu
Date: Thu, 22 Jan 2015 11:23:58 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1501221121570.5526@nanos>
References: <1418254133.18092.22.camel@perches.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58935 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbbAVKYV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jan 2015 05:24:21 -0500
In-Reply-To: <1418254133.18092.22.camel@perches.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-pm <linux-pm@vger.kernel.org>

On Wed, 10 Dec 2014, Joe Perches wrote:
> As far as I can tell, there's no value indirecting
> the cpu passed to this function via a void *.
> 
> Update all the callers and called functions from within
> clockevents_notify.

Aside of that there is no value for this 'notification' function at
all. This should be seperate explicit calls. The notify function is a
leftover from the original implementation which used actual notifier
chains. I'll send out a cleanup series later today.

Thanks,

	tglx


