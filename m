From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4] acpi, nfit: treat virtual ramdisk SPA as pmem region
Date: Thu, 14 Jul 2016 22:24:32 -0700
Message-ID: <CAPcyv4hg=CGMCopRnxNdB33yJ0E9qpyyYQUix0yh2KtS_kFzgw@mail.gmail.com>
References: <1468555535-30902-1-git-send-email-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33423 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbcGOFYi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jul 2016 01:24:38 -0400
Received: by mail-oi0-f43.google.com with SMTP id j185so142404485oih.0
        for <linux-acpi@vger.kernel.org>; Thu, 14 Jul 2016 22:24:38 -0700 (PDT)
In-Reply-To: <1468555535-30902-1-git-send-email-jlee@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linda Knippers <linda.knippers@hpe.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>, Gary Lin <GLin@suse.com>

On Thu, Jul 14, 2016 at 9:05 PM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> This patch adds logic to treat virtual ramdisk SPA as pmem region, then
> ramdisk's /dev/pmem* device can be mounted with iso9660.
>
> It's useful to work with the httpboot in EFI firmware to pull a remote
> ISO file to the local memory region for booting and installation.
>
> Wiki page of UEFI HTTPBoot with OVMF:
>         https://en.opensuse.org/UEFI_HTTPBoot_with_OVMF
>
> The ramdisk function in EDK2/OVMF generates a ACPI0012 root device that
> it contains empty _STA but without _DSM:
>
> DefinitionBlock ("ssdt2.aml", "SSDT", 2, "INTEL ", "RamDisk ", 0x00001000)
> {
>     Scope (\_SB)
>     {
>         Device (NVDR)
>         {
>             Name (_HID, "ACPI0012")  // _HID: Hardware ID
>             Name (_STR, Unicode ("NVDIMM Root Device"))  // _STR: Description String
>             Method (_STA, 0, NotSerialized)  // _STA: Status
>             {
>                 Return (0x0F)
>             }
>         }
>     }
> }
>
> In section 5.2.25.2 of ACPI 6.1 spec, it mentions that the "SPA Range
> Structure Index" of virtual SPA shall be set to zero. That means virtual SPA
> will not be associated by any NVDIMM region mapping.
>
> The VCD's SPA Range Structure in NFIT is similar to virtual disk region
> as following:
>
> [028h 0040   2]                Subtable Type : 0000 [System Physical Address Range]
> [02Ah 0042   2]                       Length : 0038
>
> [02Ch 0044   2]                  Range Index : 0000
> [02Eh 0046   2]        Flags (decoded below) : 0000
>                    Add/Online Operation Only : 0
>                       Proximity Domain Valid : 0
> [030h 0048   4]                     Reserved : 00000000
> [034h 0052   4]             Proximity Domain : 00000000
> [038h 0056  16]           Address Range GUID : 77AB535A-45FC-624B-5560-F7B281D1F96E
> [048h 0072   8]           Address Range Base : 00000000B6ABD018
> [050h 0080   8]         Address Range Length : 0000000005500000
> [058h 0088   8]         Memory Map Attribute : 0000000000000000
>
> The way to not associate a SPA range is to never reference it from a "flush hint",
> "interleave", or "control region" table.
>
> After testing on OVMF, pmem driver can support the region that it doesn't
> assoicate to any NVDIMM mapping. So, treat VCD like pmem is a idea to get
> a pmem block device that it contains iso.
>
> v4:
> Instoduce nfit_spa_is_virtual() to check virtual ramdisk SPA and create
> pmem region.
>
> v3:
> To simplify patch, removed useless VCD region in libnvdimm.
>
> v2:
> Removed the code for setting VCD to a read-only region.
>
> Cc: Gary Lin <GLin@suse.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Linda Knippers <linda.knippers@hpe.com>
> Signed-off-by: Lee, Chun-Yi <jlee@suse.com>

Applied, thanks.
