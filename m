From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2-UPDATE2 3/4] resource: Add device-managed insert/remove_resource()
Date: Tue, 8 Mar 2016 14:44:28 -0800
Message-ID: <CAPcyv4i2GwujqK=MDJpSKhvufJprmCV4vmQRpS_UP-n1kau+mg@mail.gmail.com>
References: <1457460530-17959-1-git-send-email-toshi.kani@hpe.com>
	<CA+55aFy=V-esUXZa2AogS685k+r9PyyNStkZrrUUkWSKvLFUGQ@mail.gmail.com>
	<CAPcyv4gT1RvnEquYXVo7sZscdUrkiWpG-Yvr_EX4=L25397X0g@mail.gmail.com>
	<CA+55aFxPn3J68MsqQd7OVv7jetZjPduP53MFmw2f_-z7=ebpXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33836 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbcCHWo3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2016 17:44:29 -0500
Received: by mail-ob0-f182.google.com with SMTP id ts10so29237282obc.1
        for <linux-acpi@vger.kernel.org>; Tue, 08 Mar 2016 14:44:28 -0800 (PST)
In-Reply-To: <CA+55aFxPn3J68MsqQd7OVv7jetZjPduP53MFmw2f_-z7=ebpXQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Toshi Kani <toshi.kani@hpe.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Mar 8, 2016 at 2:23 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Mar 8, 2016 at 12:59 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> Here's the usage patch from Toshi [1] (copied below).  It is indeed a
>> resource injected by nfit / nvdimm bus implementation.  We just happen
>> to support nfit and libnvdimm as modules.
>>
>> The goal of these patches is to use the ACPI NFIT data to create a
>> "Persistent Memory" rather than "reserved" resource.  This is for
>> platform-firmware implementations that use E820-Type2 rather than
>> E820-Type7 to describe pmem.
>
> So my worry is that there is likely exactly one or two of these kinds of sites.
>
> Why couldn't they just use insert_resource() and then remove it manually?

You mean instead of introducing a devm_insert_resource() as a helpful
first-class-citizen api, just arrange for the resource to be inserted
locally?  Sure.

I assume Toshi was looking to keep the devm semantics like the rest of
the nfit driver, but we can do that locally with devm_add_action() and
skip the new general purpose api.
