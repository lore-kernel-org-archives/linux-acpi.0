From: Len Brown <lenb@kernel.org>
Subject: Re: [git pull request] ACPI Processor Aggregator Driver for 2.6.32-rc1
Date: Mon, 05 Oct 2009 18:20:44 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910051818130.32307@localhost.localdomain>
References: <alpine.LFD.2.00.0910030145140.25240@localhost.localdomain>
 <20091005033256.GA26592@balbir.in.ibm.com> <200910052159.24920.rjw@sisk.pl>
 <20091005140415.57f1db5e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754771AbZJEWVn@vger.kernel.org>
In-reply-to: <20091005140415.57f1db5e.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, balbir@linux.vnet.ibm.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, a.p.zijlstra@chello.nl, shaohua.li@intel.com, svaidy@linux.vnet.ibm.com
List-Id: linux-acpi@vger.kernel.org

> Technical question: the overall feature, which I'd describe as
> "shutting down CPUs when an external agent tells us the
> thermal/electrical/other load is too high" is not at all specific to
> the x86 CPU.  Should the code have been designed in such a way as to
> permit other architectures to play?  

I agree with Peter and Vaidy that a generic capability in the Linux 
scheduler would be wonderful.  But we don't have that today.

Re: this driver in particular...
acpi_pad accepts an ACPI event from the platform and then
does something with it.

Today, ACPI runs on just x86 and ia64, and I'm not aware
of any plans to implement this particularly feature on ia64 platforms.

cheers,
Len Brown, Intel Open Source Technology Center
