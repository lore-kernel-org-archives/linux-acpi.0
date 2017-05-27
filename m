From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/16] Convert WMI to a proper bus
Date: Sat, 27 May 2017 21:49:25 +0200
Message-ID: <3214691.4YNsAb1L33@aspire.rjw.lan>
References: <cover.1495862272.git.dvhart@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42548 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750737AbdE0T4P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 27 May 2017 15:56:15 -0400
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, May 26, 2017 10:31:14 PM Darren Hart wrote:
> From: "Darren Hart (VMware)" <dvhart@infradead.org>
> 
> This series is based on the original work of
> Andy Lutomirski <luto@amacapital.net> [1]. I have made minor edits, and in
> one instance, squashed two patches in which the latter undid the former.
> 
> This series converts WMI [2] into a proper bus, adds some useful information via
> sysfs, and exposes the embedded MOF [3] binary. It converts dell-wmi to use the
> new WMI bus architecture.
> 
> This is the first part of an ongoing effort to enhance the WMI infrastructure
> within the kernel, and eventually expose WMI to userspace for the consumption of
> management utilities as it was intended.
> 
> 1. https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=platform/wmi
> 2. https://msdn.microsoft.com/en-us/library/windows/hardware/dn614028(v=vs.85).aspx
> 3. https://msdn.microsoft.com/en-us/library/aa823192(v=vs.85).aspx
> 
> Andy Lutomirski (15):
>   platform/x86: wmi: Drop "Mapper (un)loaded" messages
>   platform/x86: wmi: Pass the acpi_device through to parse_wdg
>   platform/x86: wmi: Clean up acpi_wmi_add
>   platform/x86: wmi: Track wmi devices per ACPI device
>   platform/x86: wmi: Turn WMI into a bus driver
>   platform/x86: wmi: Fix error handling when creating devices
>   platform/x86: wmi: Split devices into types and add basic sysfs attributes
>   platform/x86: wmi: Probe data objects for read and write capabilities
>   platform/x86: wmi: Instantiate all devices before adding them
>   platform/x86: wmi: Incorporate acpi_install_notify_handler
>   platform/x86: wmi: Add a new interface to read block data
>   platform/x86: wmi: Bind the platform device, not the ACPI node
>   platform/x86: wmi: Add an interface for subdrivers to access sibling devices
>   platform/x86: wmi-mof: New driver to expose embedded WMI MOF metadata
>   platform/x86: dell-wmi: Convert to the WMI bus infrastructure
> 
> Darren Hart (VMware) (1):
>   platform/x86: wmi: Require query for data blocks, rename writable to setable
> 
>  drivers/platform/x86/Kconfig    |  12 +
>  drivers/platform/x86/Makefile   |   1 +
>  drivers/platform/x86/dell-wmi.c | 136 ++++----
>  drivers/platform/x86/wmi-mof.c  | 125 ++++++++
>  drivers/platform/x86/wmi.c      | 677 ++++++++++++++++++++++++++++++++--------
>  include/linux/wmi.h             |  59 ++++
>  6 files changed, 815 insertions(+), 195 deletions(-)
>  create mode 100644 drivers/platform/x86/wmi-mof.c
>  create mode 100644 include/linux/wmi.h

All of this makes sense from the ACPI core perspective, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the series and I'm assuming that it will go in via the platform/x86 tree.

Thanks,
Rafael

