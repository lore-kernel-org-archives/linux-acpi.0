From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/3] pmem: Use the poison list to expose badblocks
Date: Sun, 20 Dec 2015 17:20:52 -0800
Message-ID: <CAPcyv4je_6LPzfULJrGdkDRnc0mzc_ftd=t9942N2UO9rQZe0A@mail.gmail.com>
References: <1450603122-7205-1-git-send-email-vishal@kernel.org>
	<1450603122-7205-4-git-send-email-vishal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36476 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbbLUBUx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Dec 2015 20:20:53 -0500
Received: by mail-yk0-f172.google.com with SMTP id x184so117547409yka.3
        for <linux-acpi@vger.kernel.org>; Sun, 20 Dec 2015 17:20:53 -0800 (PST)
In-Reply-To: <1450603122-7205-4-git-send-email-vishal@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal@kernel.org>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Vishal Verma <vishal.l.verma@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Jeff Moyer <jmoyer@redhat.com>, Linda Knippers <linda.knippers@hpe.com>

On Sun, Dec 20, 2015 at 1:18 AM,  <vishal@kernel.org> wrote:
> From: Vishal Verma <vishal.l.verma@intel.com>
>
> Enable the gendisk badblocks feature for pmem namespaces.
> If the pmem namespace being created has any known poison associated with
> its physical address space, convert the poison ranges to bad sectors
> exposed using the badblocks interface.
>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/nvdimm/pmem.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)

I think we should move this new functionality to the core because
there is not much pmem driver specific.  It's all generic nvdimm-core
and block-core functionality.  The only missing information the core
routine needs is the gendisk and a data offset (if sector-zero is at
an offset from the base address range of the namespace).  Something
like:

nvdimm_namespace_disk_poison(struct nd_namespace_common *ndns,
    resource_size_t offset, struct gendisk *disk)
