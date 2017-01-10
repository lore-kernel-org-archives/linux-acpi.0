From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port acpi_get_table_with_size()
 and early_acpi_os_unmap_memory() from Linux kernel
Date: Tue, 10 Jan 2017 02:27:16 +0100
Message-ID: <CAJZ5v0gRYcC5fJZF207iyehvPR9_2zqprSvWHA_Qt93W9njqAw@mail.gmail.com>
References: <CAJZ5v0hxrz9os4ZpS=EHbdFp8rd7D+BU10bSyfBV-FE6UHQ6FA@mail.gmail.com>
 <CAJZ5v0idFBHG=OKRiBqvsYPgUrWQsqjTKYXfKxfdG023qsCbkw@mail.gmail.com>
 <20170108130355.vxhjmj6dlkqw6hyq@pd.tnic> <1AE640813FDE7649BE1B193DEA596E886CE27B7E@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CE27BEE@SHSMSX101.ccr.corp.intel.com>
 <20170109093329.jd7uwlcpci4icpd3@pd.tnic> <20170109221831.GC3800@linux.vnet.ibm.com>
 <20170109231501.xrhwsv46mznw3kqt@pd.tnic> <20170109233204.GG3800@linux.vnet.ibm.com>
 <20170109234039.mfefmv5dv4shxnfn@pd.tnic> <20170109235211.yetponvbexvalkir@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11354d2a77476c0545b36250
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35228 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755113AbdAJB1R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2017 20:27:17 -0500
In-Reply-To: <20170109235211.yetponvbexvalkir@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, J?rg R?del <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

--001a11354d2a77476c0545b36250
Content-Type: text/plain; charset=UTF-8

On Tue, Jan 10, 2017 at 12:52 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Tue, Jan 10, 2017 at 12:40:39AM +0100, Borislav Petkov wrote:
>> Lemme run it.
>
> Well, it boots but I get:
>
> [    0.291447] ------------[ cut here ]------------
> [    0.291702] WARNING: CPU: 0 PID: 1 at kernel/rcu/tree.c:3993 rcu_scheduler_starting+0x5c/0x70
> [    0.292107] Modules linked in:
> [    0.292277] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.10.0-rc3+ #21
> [    0.292540] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.08 01/28/2016
> [    0.292893] Call Trace:
> [    0.293072]  ? dump_stack+0x46/0x63
> [    0.293285]  ? __warn+0xec/0x110
> [    0.293487]  ? rcu_scheduler_starting+0x5c/0x70
> [    0.293735]  ? kernel_init_freeable+0x58/0x19a
> [    0.293976]  ? rest_init+0x80/0x80
> [    0.294153]  ? kernel_init+0xa/0x100
> [    0.294334]  ? ret_from_fork+0x22/0x30
> [    0.294525] ---[ end trace 4c0fe009ed4dc740 ]---
>
> TBH, I like Rafael's suggestion in the other mail to stick with fixing
> this in ACPI, especially this is an ACPI problem, not RCU. Well,
> more or less: RCU could be taught to *not* do schedule_work() if
> workqueue_init() hasn't happened yet but that's a tangential.
>
> So, I'm going to bed. When I wake up, I want to see working fixes!
>
> :-)))

Well, if the https://patchwork.kernel.org/patch/9504277/ patch from Lv
worked, the attached one should work too (please test), but it can be
justified in a slightly more convincing way.

Namely, the idea is that acpi_os_read/write_memory() should never be
used before invoking acpi_os_initialize() and since those are the only
places where the list of memory regions is walked under RCU without
extra locking, it is safe to skip the RCU synchronization until that
happens.

Thanks,
Rafael

--001a11354d2a77476c0545b36250
Content-Type: text/x-patch; charset=US-ASCII; name="acpi-mem-unmap.patch"
Content-Disposition: attachment; filename="acpi-mem-unmap.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ixqu0ojm0

LS0tCiBkcml2ZXJzL2FjcGkvb3NsLmMgfCAgICA4ICsrKysrKystCiAxIGZpbGUgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpJbmRleDogbGludXgtcG0vZHJpdmVycy9h
Y3BpL29zbC5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9hY3BpL29zbC5j
CisrKyBsaW51eC1wbS9kcml2ZXJzL2FjcGkvb3NsLmMKQEAgLTM3OCw3ICszNzgsOSBAQCBzdGF0
aWMgdm9pZCBhY3BpX29zX2Ryb3BfbWFwX3JlZihzdHJ1Y3QKIHN0YXRpYyB2b2lkIGFjcGlfb3Nf
bWFwX2NsZWFudXAoc3RydWN0IGFjcGlfaW9yZW1hcCAqbWFwKQogewogCWlmICghbWFwLT5yZWZj
b3VudCkgewotCQlzeW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkKCk7CisJCWlmIChhY3BpX29zX2lu
aXRpYWxpemVkKQorCQkJc3luY2hyb25pemVfcmN1X2V4cGVkaXRlZCgpOworCiAJCWFjcGlfdW5t
YXAobWFwLT5waHlzLCBtYXAtPnZpcnQpOwogCQlrZnJlZShtYXApOwogCX0KQEAgLTY3MSw2ICs2
NzMsOCBAQCBhY3BpX29zX3JlYWRfbWVtb3J5KGFjcGlfcGh5c2ljYWxfYWRkcmVzCiAJYm9vbCB1
bm1hcCA9IGZhbHNlOwogCXU2NCBkdW1teTsKIAorCVdBUk5fT05fT05DRSghYWNwaV9vc19pbml0
aWFsaXplZCk7CisKIAlyY3VfcmVhZF9sb2NrKCk7CiAJdmlydF9hZGRyID0gYWNwaV9tYXBfdmFk
ZHJfbG9va3VwKHBoeXNfYWRkciwgc2l6ZSk7CiAJaWYgKCF2aXJ0X2FkZHIpIHsKQEAgLTcxNiw2
ICs3MjAsOCBAQCBhY3BpX29zX3dyaXRlX21lbW9yeShhY3BpX3BoeXNpY2FsX2FkZHJlCiAJdW5z
aWduZWQgaW50IHNpemUgPSB3aWR0aCAvIDg7CiAJYm9vbCB1bm1hcCA9IGZhbHNlOwogCisJV0FS
Tl9PTl9PTkNFKCFhY3BpX29zX2luaXRpYWxpemVkKTsKKwogCXJjdV9yZWFkX2xvY2soKTsKIAl2
aXJ0X2FkZHIgPSBhY3BpX21hcF92YWRkcl9sb29rdXAocGh5c19hZGRyLCBzaXplKTsKIAlpZiAo
IXZpcnRfYWRkcikgewo=
--001a11354d2a77476c0545b36250--
