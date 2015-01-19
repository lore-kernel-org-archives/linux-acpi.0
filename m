From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC Patch 00/19] Improve ACPI resource parsing interfaces and data structures
Date: Mon, 19 Jan 2015 16:06:06 +0100
Message-ID: <1650558.f4xRROdpd4@vostro.rjw.lan>
References: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com> <2025625.5YhoBnTE03@vostro.rjw.lan> <54BD13F8.2040105@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <54BD13F8.2040105@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, January 19, 2015 10:26:00 PM Jiang Liu wrote:
> On 2015/1/12 6:38, Rafael J. Wysocki wrote:
> > On Thursday, January 08, 2015 10:32:47 AM Jiang Liu wrote:
> >> During enabling ACPI based IOAPIC hotplug, Thomas noticed some issues
> >> in ACPI resource parsing interfaces. So this is an effort to improve them.
> >>
> >> Patch 1-12 improve ACPI resource parsing interfaces and also fixes some
> >> bugs.
> >>
> >> Patch 13-19 try to share the common data structure resource_list_entry
> >> between PCI and ACPI. It may also be shared with PNP too.
> > 
> > I've looked at the patches briefly.
> > 
> > I like the changes at the general level, but there are some things I'm
> > potentially concerned about in them.  Need more time to look at them,
> > I'll do my best to do that this week while at the conference.
> Hi Rafael,
> 	Thanks for your time. Any comments about this series?

Please give me some more time.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
