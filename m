From: Jack Steiner <steiner@sgi.com>
Subject: Re: [PATCH] - Mapping ACPI tables as CACHED
Date: Tue, 14 Dec 2010 20:41:36 -0600
Message-ID: <20101215024136.GB19601@sgi.com>
References: <20101214220932.GA1206@sgi.com> <alpine.LFD.2.00.1012141903210.25387@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1012141903210.25387@x980>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: hpa@zytor.com, hmh@hmh.eng.br, tony.luck@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, gbeshers@sgi.com
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 14, 2010 at 07:04:13PM -0500, Len Brown wrote:
> hmm, my arrandale laptop fails to get into graphics mode w/ this patch 
> applied -- last thing i see is the kernel freeing memory, then black 
> screen.
> 
> thanks,
> Len Brown, Intel Open Source Technology Center

Do you know where the ACPI tables actually reside? In RAM
or in another type of memory.

The original version of this patch made the cacheable mapping
a platform attribute that was set via a function called thru
the x86_platform_ops.  This was intended to minimize the potential
for breaking systems with BIOSes that used non-RAM ACPI tables.
There are a lot of different BIOSes and I'm not even close to
understanding them all.

Wonder if I should resurrect that version of the patch....
