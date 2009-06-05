From: david@lang.hm
Subject: Re: only a single core (out of 8) initialized
Date: Fri, 5 Jun 2009 09:47:37 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0906050946530.7953@asgard>
References: <alpine.DEB.1.10.0906041949030.7953@asgard> <20090604202933.d7c24c3d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.lang.hm ([64.81.33.126]:40972 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988AbZFEQsB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 5 Jun 2009 12:48:01 -0400
In-Reply-To: <20090604202933.d7c24c3d.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>

On Thu, 4 Jun 2009, Andrew Morton wrote:

> On Thu, 4 Jun 2009 19:52:36 -0700 (PDT) david@lang.hm wrote:
>
>> this is 2.6.30-rc7
>
> Were any earlier kernels OK?

sorry, I missed this question.

I was running 2.6.29.1 when I noticed this problem. I haven't tried older 
kernels yet.

David Lang

>>  with a patch added to debug a nv sata driver
>> incompatibility with the Intel SSDs on a tyan motherboard
>>
>> on one system it sees all 8 cores, on the other system it only initializes
>> one core.
>>
>> can anyone help me spot what's going wrong in the one that's only seeing a
>> single core? If I'm reading things correctly it's seeing both sockets for
>> the NUMA setup, but then only initializing one core on the first socket.
>
> good:
> 	SMP: Allowing 8 CPUs, 4 hotplug CPUs
>
> bad:
> 	SMP: Allowing 1 CPUs, 0 hotplug CPUs
>
> perhaps due to
> 	ACPI: No APIC-table, disabling MPS
>
> You could have a poke around in arch/x86/kernel/smpboot.c() and find
> out what happened here.  I'd be suspecting this code triggered:
>
>        /* no processor from mptable or madt */
>        if (!num_processors)
>                num_processors = 1;
>
> because ACPI doesn't like that board.
>
> Did you look into updating the BIOS?
>
>
