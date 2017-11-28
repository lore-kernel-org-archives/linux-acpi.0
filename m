From: Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: 2f47e7e19f ("x86/mm/kaiser: Use PCID feature to make user and
 .."): WARNING: CPU: 0 PID: 1 at mm/early_ioremap.c:114 __early_ioremap
Date: Mon, 27 Nov 2017 17:22:02 -0800
Message-ID: <9f73a515-ce07-c833-4e6b-2062fe03f354@linux.intel.com>
References: <5a1aaa36.CWNgvwmmRFzeAlPc%fengguang.wu@intel.com>
 <20171127101814.jsglrh7typy3pxxp@gmail.com>
 <bdfdf131-ca57-68c3-3a6c-039cd21c3bb5@linux.intel.com>
 <CAJZ5v0hyAt1cPj3jpm9njOZAo02WmN-83ozeyvDF5qipBXqH=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:12912 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752712AbdK1BWF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Nov 2017 20:22:05 -0500
In-Reply-To: <CAJZ5v0hyAt1cPj3jpm9njOZAo02WmN-83ozeyvDF5qipBXqH=Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, kernel test robot <fengguang.wu@intel.com>, LKP <lkp@01.org>, kvm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, wfg@linux.intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Bjorn Helgaas <bhelgaas@google.com>

I think I narrowed this down.

__native_flush_tlb_single() depends on cpu_tlbstate.loaded_mm_asid
matching what is in CR3.  But, while we are still "early" in boot, CR3
has hardware ASID=0, but cpu_tlbstate.loaded_mm_asid=0 which is actually
hardware ASID=1.

So, we have ASID=0 in CR3 and we try to *flush* ASID=1 with INVPCID,
which does nothing for us, effectively missing the TLB flush.

I think we need to steer __native_flush_tlb_single() into the
"!this_cpu_has(X86_FEATURE_INVPCID_SINGLE)" path if we get called before
initialize_tlbstate_and_flush() gives us a "real" ASID in CR3, but I
haven't found a nice way to do it, yet.

We probably also need a debugging warning in there to read CR3 and check
it against cpu_tlbstate.loaded_mm_asid.  I'll look at this in some more
detail tomorrow if nobody beats me to it.
