From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC Patch 12/19] ACPI: Enforce stricter checks for address space descriptors
Date: Wed, 21 Jan 2015 04:01:18 +0100
Message-ID: <7576859.KlxNWQfAaD@vostro.rjw.lan>
References: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com> <12267175.FvlCJYWCa5@vostro.rjw.lan> <54BF0C71.5080508@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54BF0C71.5080508@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, January 21, 2015 10:18:25 AM Jiang Liu wrote:
> On 2015/1/21 8:45, Rafael J. Wysocki wrote:
> > On Thursday, January 08, 2015 10:32:59 AM Jiang Liu wrote:
> >> Enforce stricter checks for address space descriptors according to
> >> ACPI spec.
> > 
> > So is the spec the only reason for doing this?  If so, I'd say don't.
> Hi Rafael,
> 	Yes, it's just for spec. I will drop this patch to avoid
> regressions.

A debug message covering that may be useful, though, in case things don't
work and this is the reason.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
