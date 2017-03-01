From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/4] Revert"x86/acpi: Enable MADT APIs to return
 disabled apicids"
Date: Wed, 1 Mar 2017 11:52:22 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1703011151090.4005@nanos>
References: <1487580471-17665-1-git-send-email-douly.fnst@cn.fujitsu.com> <1487580471-17665-3-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487580471-17665-3-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: mingo@kernel.org, peterz@infradead.org, rjw@rjwysocki.net, hpa@zytor.com, rafael@kernel.org, cl@linux.com, tj@kernel.org, akpm@linux-foundation.org, rafael.j.wysocki@intel.com, len.brown@intel.com, izumi.taku@jp.fujitsu.com, xiaolong.ye@intel.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 20 Feb 2017, Dou Liyang wrote:

> After we never do the last mapping of "cpuid <-> nodeid" at booting time. we
> also no need to enable MADT APIs to return disabled apicid.
> 
> So, The patch work for reverting the commit 8ad893faf2:
> "x86/acpi: Enable MADT APIs to return disabled apicids"

Again, this changelog is confusing. A simple:

  Remove the leftovers of the boot time 'cpuid <-> nodeid' mapping approach.

would be sufficient and entirely clear.

Thanks,

	tglx
