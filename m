From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] More ACPI updates for v4.10-rc1
Date: Wed, 4 Jan 2017 15:46:47 -0800
Message-ID: <CA+55aFxF+x46jC1z_Qy7S+GheuR9_rDS4CToxJjPazjXt_-zVA@mail.gmail.com>
References: <CAJZ5v0iq8z-cdja46o2z__Pfs9M+j2q4SXFu=7cS4LHY3XqL4g@mail.gmail.com>
 <CA+55aFxB_vuENriLFT6S+HMfWouKvrOaaM3NYgeYGnmTYsKU=g@mail.gmail.com>
 <CAJZ5v0hqsoFXvhhyzFAcoi238-dDPesm1-HkGuogJgxLfy2d3g@mail.gmail.com> <CA+55aFw3e_L-H=B6svoBK8234xNEws254VCKhedg4o+eF9+5dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:33852 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758307AbdADXrY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jan 2017 18:47:24 -0500
In-Reply-To: <CA+55aFw3e_L-H=B6svoBK8234xNEws254VCKhedg4o+eF9+5dg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Jan 4, 2017 at 3:19 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This is my normal desktop, so pretty plain HW.
>
> It doesn't happen on my laptop, so it's obviously hw-related or
> possibly config-related.

.. and here's the stack trace.

Side note: should the '\n' be deleted? ACPI_ERROR() seems to add that
silly "where it happened" at the end, but due to the '\n' we end up
with two lines...

                  Linus

---

  ACPI Warning: Table ffffffffb0e6c0a0, Validation count is zero
before decrement
   (20160930/tbutils-456)
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 0 at drivers/acpi/acpica/tbutils.c:457
acpi_tb_put_table+0x4e/0x62
  Modules linked in:
  CPU: 0 PID: 0 Comm: swapper Not tainted
4.10.0-rc2-00103-g4cf184638bcf-dirty #1
  Hardware name: System manufacturer System Product Name/Z170-K, BIOS
1803 05/06/2016
  Call Trace:
     acpi_tb_put_table+0x4e/0x62
     acpi_put_table+0x40/0x4d
     detect_intel_iommu+0x9d/0xed
     pci_iommu_alloc+0x50/0x6c
     mem_init+0xf/0x8a
     start_kernel+0x21e/0x454
     x86_64_start_reservations+0x24/0x26
     x86_64_start_kernel+0x182/0x193
     start_cpu+0x14/0x14
    ---[ end trace 5e897a808e950ddc ]---
