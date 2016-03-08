From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2-UPDATE2 3/4] resource: Add device-managed insert/remove_resource()
Date: Tue, 8 Mar 2016 14:23:48 -0800
Message-ID: <CA+55aFxPn3J68MsqQd7OVv7jetZjPduP53MFmw2f_-z7=ebpXQ@mail.gmail.com>
References: <1457460530-17959-1-git-send-email-toshi.kani@hpe.com>
	<CA+55aFy=V-esUXZa2AogS685k+r9PyyNStkZrrUUkWSKvLFUGQ@mail.gmail.com>
	<CAPcyv4gT1RvnEquYXVo7sZscdUrkiWpG-Yvr_EX4=L25397X0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35689 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbcCHWXt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2016 17:23:49 -0500
In-Reply-To: <CAPcyv4gT1RvnEquYXVo7sZscdUrkiWpG-Yvr_EX4=L25397X0g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Toshi Kani <toshi.kani@hpe.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Mar 8, 2016 at 12:59 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>
> Here's the usage patch from Toshi [1] (copied below).  It is indeed a
> resource injected by nfit / nvdimm bus implementation.  We just happen
> to support nfit and libnvdimm as modules.
>
> The goal of these patches is to use the ACPI NFIT data to create a
> "Persistent Memory" rather than "reserved" resource.  This is for
> platform-firmware implementations that use E820-Type2 rather than
> E820-Type7 to describe pmem.

So my worry is that there is likely exactly one or two of these kinds of sites.

Why couldn't they just use insert_resource() and then remove it manually?

                 Linus
