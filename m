From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: only a single core (out of 8) initialized
Date: Thu, 4 Jun 2009 20:29:33 -0700
Message-ID: <20090604202933.d7c24c3d.akpm@linux-foundation.org>
References: <alpine.DEB.1.10.0906041949030.7953@asgard>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50244 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752281AbZFEDbh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jun 2009 23:31:37 -0400
In-Reply-To: <alpine.DEB.1.10.0906041949030.7953@asgard>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: david@lang.hm
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>

On Thu, 4 Jun 2009 19:52:36 -0700 (PDT) david@lang.hm wrote:

> this is 2.6.30-rc7

Were any earlier kernels OK?

>  with a patch added to debug a nv sata driver 
> incompatibility with the Intel SSDs on a tyan motherboard
> 
> on one system it sees all 8 cores, on the other system it only initializes 
> one core.
> 
> can anyone help me spot what's going wrong in the one that's only seeing a 
> single core? If I'm reading things correctly it's seeing both sockets for 
> the NUMA setup, but then only initializing one core on the first socket.

good:
	SMP: Allowing 8 CPUs, 4 hotplug CPUs

bad:	
	SMP: Allowing 1 CPUs, 0 hotplug CPUs

perhaps due to
	ACPI: No APIC-table, disabling MPS

You could have a poke around in arch/x86/kernel/smpboot.c() and find
out what happened here.  I'd be suspecting this code triggered:

        /* no processor from mptable or madt */
        if (!num_processors)
                num_processors = 1;

because ACPI doesn't like that board.

Did you look into updating the BIOS?

