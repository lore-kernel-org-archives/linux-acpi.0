From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Patch Part3 v4 37/38] x86, irq: Introduce mechanism to support
 different vector allocation policies
Date: Thu, 27 Nov 2014 11:44:50 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1411271142340.3961@nanos>
References: <1416901802-24211-1-git-send-email-jiang.liu@linux.intel.com> <1416901802-24211-38-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55603 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaK0Kp2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Nov 2014 05:45:28 -0500
In-Reply-To: <1416901802-24211-38-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Daniel J Blueman <daniel@numascale.com>

On Tue, 25 Nov 2014, Jiang Liu wrote:
> Introduce mechanism to support different vector allocation policies,
> so platform or user may choose the best suitable CPU vector allocation

I've postponed this and the next patch for 3.20.

> policy. Currently two policies are supported:
> 1) allocate CPU vector from cpumask_of_node(dev_to_node(dev))
> 2) allocate from apic->target_cpus(), this is the default policy
> 
> Platform driver may call set_vector_alloc_policy() to choose the
> preferred policies.
> 
> This mechanism may be used to support NumaConnect systems to allocate
> CPU vectors from device local node.

So these policies are system wide and need to be selected at boot time?

Thanks,

	tglx

