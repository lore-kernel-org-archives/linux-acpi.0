From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [GIT PULL] More ACPI updates for v4.10-rc1
Date: Thu, 5 Jan 2017 01:07:03 +0100
Message-ID: <CAJZ5v0goQvQ2e7XY_Y3w+T1HJmoZNzDS8pTTwrEOjF4-Ck+HfQ@mail.gmail.com>
References: <CAJZ5v0iq8z-cdja46o2z__Pfs9M+j2q4SXFu=7cS4LHY3XqL4g@mail.gmail.com>
 <CA+55aFxB_vuENriLFT6S+HMfWouKvrOaaM3NYgeYGnmTYsKU=g@mail.gmail.com>
 <CAJZ5v0hqsoFXvhhyzFAcoi238-dDPesm1-HkGuogJgxLfy2d3g@mail.gmail.com>
 <CA+55aFw3e_L-H=B6svoBK8234xNEws254VCKhedg4o+eF9+5dg@mail.gmail.com> <CA+55aFxF+x46jC1z_Qy7S+GheuR9_rDS4CToxJjPazjXt_-zVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=94eb2c09d6125bde2505454dae57
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33219 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032052AbdAEAHE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jan 2017 19:07:04 -0500
In-Reply-To: <CA+55aFxF+x46jC1z_Qy7S+GheuR9_rDS4CToxJjPazjXt_-zVA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

--94eb2c09d6125bde2505454dae57
Content-Type: text/plain; charset=UTF-8

On Thu, Jan 5, 2017 at 12:46 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Jan 4, 2017 at 3:19 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> This is my normal desktop, so pretty plain HW.
>>
>> It doesn't happen on my laptop, so it's obviously hw-related or
>> possibly config-related.
>
> .. and here's the stack trace.

Thanks!

I reproduced it too in the meantime (but on an older system I rarely use).

> Side note: should the '\n' be deleted? ACPI_ERROR() seems to add that
> silly "where it happened" at the end, but due to the '\n' we end up
> with two lines...
>
>                   Linus
>
> ---
>
>   ACPI Warning: Table ffffffffb0e6c0a0, Validation count is zero
> before decrement
>    (20160930/tbutils-456)
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 0 at drivers/acpi/acpica/tbutils.c:457
> acpi_tb_put_table+0x4e/0x62
>   Modules linked in:
>   CPU: 0 PID: 0 Comm: swapper Not tainted
> 4.10.0-rc2-00103-g4cf184638bcf-dirty #1
>   Hardware name: System manufacturer System Product Name/Z170-K, BIOS
> 1803 05/06/2016
>   Call Trace:
>      acpi_tb_put_table+0x4e/0x62
>      acpi_put_table+0x40/0x4d
>      detect_intel_iommu+0x9d/0xed
>      pci_iommu_alloc+0x50/0x6c
>      mem_init+0xf/0x8a
>      start_kernel+0x21e/0x454
>      x86_64_start_reservations+0x24/0x26
>      x86_64_start_kernel+0x182/0x193
>      start_cpu+0x14/0x14
>     ---[ end trace 5e897a808e950ddc ]---

And the attached thing makes it go away for me.

I'll post a proper patch shorlty.

Cheers,
Rafael

--94eb2c09d6125bde2505454dae57
Content-Type: text/x-patch; charset=US-ASCII; name="acpi-table-put-debug.patch"
Content-Disposition: attachment; filename="acpi-table-put-debug.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ixjm2pw50

LS0tCiBkcml2ZXJzL2lvbW11L2RtYXIuYyB8ICAgIDYgKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMv
aW9tbXUvZG1hci5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9pb21tdS9k
bWFyLmMKKysrIGxpbnV4LXBtL2RyaXZlcnMvaW9tbXUvZG1hci5jCkBAIC05MDMsOCArOTAzLDEw
IEBAIGludCBfX2luaXQgZGV0ZWN0X2ludGVsX2lvbW11KHZvaWQpCiAJCXg4Nl9pbml0LmlvbW11
LmlvbW11X2luaXQgPSBpbnRlbF9pb21tdV9pbml0OwogI2VuZGlmCiAKLQlhY3BpX3B1dF90YWJs
ZShkbWFyX3RibCk7Ci0JZG1hcl90YmwgPSBOVUxMOworCWlmIChkbWFyX3RibCkgeworCQlhY3Bp
X3B1dF90YWJsZShkbWFyX3RibCk7CisJCWRtYXJfdGJsID0gTlVMTDsKKwl9CiAJdXBfd3JpdGUo
JmRtYXJfZ2xvYmFsX2xvY2spOwogCiAJcmV0dXJuIHJldCA/IDEgOiAtRU5PREVWOwo=
--94eb2c09d6125bde2505454dae57--
