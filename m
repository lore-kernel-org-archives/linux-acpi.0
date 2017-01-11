From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port acpi_get_table_with_size()
 and early_acpi_os_unmap_memory() from Linux kernel
Date: Wed, 11 Jan 2017 04:42:16 +0100
Message-ID: <CAJZ5v0gEyaqRvYA79bFrkCcw3Yto3WHbh=AdeG3s22_AjkR5iA@mail.gmail.com>
References: <20170108130355.vxhjmj6dlkqw6hyq@pd.tnic> <1AE640813FDE7649BE1B193DEA596E886CE27B7E@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CE27BEE@SHSMSX101.ccr.corp.intel.com>
 <20170109093329.jd7uwlcpci4icpd3@pd.tnic> <20170109221831.GC3800@linux.vnet.ibm.com>
 <20170109231501.xrhwsv46mznw3kqt@pd.tnic> <20170109233204.GG3800@linux.vnet.ibm.com>
 <20170109234039.mfefmv5dv4shxnfn@pd.tnic> <20170109235211.yetponvbexvalkir@pd.tnic>
 <CAJZ5v0gRYcC5fJZF207iyehvPR9_2zqprSvWHA_Qt93W9njqAw@mail.gmail.com> <20170110094122.hpg4sluemkzomeiw@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113e28ae25a0fa0545c96314
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36516 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754179AbdAKDmS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jan 2017 22:42:18 -0500
In-Reply-To: <20170110094122.hpg4sluemkzomeiw@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, J?rg R?del <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

--001a113e28ae25a0fa0545c96314
Content-Type: text/plain; charset=UTF-8

On Tue, Jan 10, 2017 at 10:41 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Tue, Jan 10, 2017 at 02:27:16AM +0100, Rafael J. Wysocki wrote:
>> Well, if the https://patchwork.kernel.org/patch/9504277/ patch from Lv
>> worked, the attached one should work too (please test), but it can be
>> justified in a slightly more convincing way.
>
> No workie:
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 57fb5f4..acb6118 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -378,7 +378,11 @@ static void acpi_os_drop_map_ref(struct acpi_ioremap *map)
>  static void acpi_os_map_cleanup(struct acpi_ioremap *map)
>  {
>         if (!map->refcount) {
> -               synchronize_rcu_expedited();
> +               if (acpi_os_initialized) {
> +                       pr_err("%s: acpi_os_initialized\n", __func__);
> +                       synchronize_rcu_expedited();
> +               }
> +
>                 acpi_unmap(map->phys, map->virt);
>                 kfree(map);
>         }
>
> The pr_err() gets issued before the box hangs.
>
> Lv's version which set the bool in acpi_os_map_generic_address() did
> work though.

Well, it would if nothing mapped by acpi_os_map_generic_address() was
in the memory address space, for example, but then it would never use
the RCU synchronization as well (not good).

Basically, we need to find a point during the initialization such that
acpi_os_read/write_memory() is not invoked earlier and set a flag in
there.

Let's try the attached one.

BTW, I'm going to travel to the LCA starting tomorrow, so I guess I
will be a bit unresponsive during the next few days.

Thanks,
Rafael

--001a113e28ae25a0fa0545c96314
Content-Type: text/x-patch; charset=US-ASCII; name="acpi-debug-table-load.patch"
Content-Disposition: attachment; filename="acpi-debug-table-load.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ixseb0qd0

LS0tCiBkcml2ZXJzL2FjcGkvYnVzLmMgICAgIHwgICAgNiArKysrKysKIGRyaXZlcnMvYWNwaS9v
c2wuYyAgICAgfCAgICA5ICsrKysrKysrLQogaW5jbHVkZS9hY3BpL2FjcGlfaW8uaCB8ICAgIDEg
KwogMyBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpJbmRl
eDogbGludXgtcG0vZHJpdmVycy9hY3BpL2J1cy5jCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9y
aWcvZHJpdmVycy9hY3BpL2J1cy5jCisrKyBsaW51eC1wbS9kcml2ZXJzL2FjcGkvYnVzLmMKQEAg
LTExOTEsNiArMTE5MSwxMiBAQCBzdGF0aWMgaW50IF9faW5pdCBhY3BpX2luaXQodm9pZCkKIAkJ
YWNwaV9rb2JqID0gTlVMTDsKIAl9CiAKKwkvKgorCSAqIGFjcGlfb3NfcmVhZF9tZW1vcnkoKS9h
Y3BpX29zX3dyaXRlX21lbW9yeSgpIHNob3VsZCBub3QgYmUgaW52b2tlZAorCSAqIGJlZm9yZSB0
aGlzIHBvaW50LgorCSAqLworCWFjcGlfc3luY19tZW1vcnlfdW5tYXAgPSB0cnVlOworCiAJaW5p
dF9hY3BpX2RldmljZV9ub3RpZnkoKTsKIAlyZXN1bHQgPSBhY3BpX2J1c19pbml0KCk7CiAJaWYg
KHJlc3VsdCkgewpJbmRleDogbGludXgtcG0vZHJpdmVycy9hY3BpL29zbC5jCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
LS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9hY3BpL29zbC5jCisrKyBsaW51eC1wbS9kcml2ZXJz
L2FjcGkvb3NsLmMKQEAgLTc3LDYgKzc3LDcgQEAgc3RhdGljIHN0cnVjdCB3b3JrcXVldWVfc3Ry
dWN0ICprYWNwaV9obwogc3RhdGljIGJvb2wgYWNwaV9vc19pbml0aWFsaXplZDsKIHVuc2lnbmVk
IGludCBhY3BpX3NjaV9pcnEgPSBJTlZBTElEX0FDUElfSVJROwogYm9vbCBhY3BpX3Blcm1hbmVu
dF9tbWFwID0gZmFsc2U7Citib29sIGFjcGlfc3luY19tZW1vcnlfdW5tYXA7CiAKIC8qCiAgKiBU
aGlzIGxpc3Qgb2YgcGVybWFuZW50IG1hcHBpbmdzIGlzIGZvciBtZW1vcnkgdGhhdCBtYXkgYmUg
YWNjZXNzZWQgZnJvbQpAQCAtMzc4LDcgKzM3OSw5IEBAIHN0YXRpYyB2b2lkIGFjcGlfb3NfZHJv
cF9tYXBfcmVmKHN0cnVjdAogc3RhdGljIHZvaWQgYWNwaV9vc19tYXBfY2xlYW51cChzdHJ1Y3Qg
YWNwaV9pb3JlbWFwICptYXApCiB7CiAJaWYgKCFtYXAtPnJlZmNvdW50KSB7Ci0JCXN5bmNocm9u
aXplX3JjdV9leHBlZGl0ZWQoKTsKKwkJaWYgKGFjcGlfc3luY19tZW1vcnlfdW5tYXApCisJCQlz
eW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkKCk7CisKIAkJYWNwaV91bm1hcChtYXAtPnBoeXMsIG1h
cC0+dmlydCk7CiAJCWtmcmVlKG1hcCk7CiAJfQpAQCAtNjcxLDYgKzY3NCw4IEBAIGFjcGlfb3Nf
cmVhZF9tZW1vcnkoYWNwaV9waHlzaWNhbF9hZGRyZXMKIAlib29sIHVubWFwID0gZmFsc2U7CiAJ
dTY0IGR1bW15OwogCisJV0FSTl9PTl9PTkNFKCFhY3BpX3N5bmNfbWVtb3J5X3VubWFwKTsKKwog
CXJjdV9yZWFkX2xvY2soKTsKIAl2aXJ0X2FkZHIgPSBhY3BpX21hcF92YWRkcl9sb29rdXAocGh5
c19hZGRyLCBzaXplKTsKIAlpZiAoIXZpcnRfYWRkcikgewpAQCAtNzE2LDYgKzcyMSw4IEBAIGFj
cGlfb3Nfd3JpdGVfbWVtb3J5KGFjcGlfcGh5c2ljYWxfYWRkcmUKIAl1bnNpZ25lZCBpbnQgc2l6
ZSA9IHdpZHRoIC8gODsKIAlib29sIHVubWFwID0gZmFsc2U7CiAKKwlXQVJOX09OX09OQ0UoIWFj
cGlfc3luY19tZW1vcnlfdW5tYXApOworCiAJcmN1X3JlYWRfbG9jaygpOwogCXZpcnRfYWRkciA9
IGFjcGlfbWFwX3ZhZGRyX2xvb2t1cChwaHlzX2FkZHIsIHNpemUpOwogCWlmICghdmlydF9hZGRy
KSB7CkluZGV4OiBsaW51eC1wbS9pbmNsdWRlL2FjcGkvYWNwaV9pby5oCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0t
IGxpbnV4LXBtLm9yaWcvaW5jbHVkZS9hY3BpL2FjcGlfaW8uaAorKysgbGludXgtcG0vaW5jbHVk
ZS9hY3BpL2FjcGlfaW8uaApAQCAtMTQsNiArMTQsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgX19p
b21lbSAqYWNwaV9vc19pb3JlCiAjZW5kaWYKIAogZXh0ZXJuIGJvb2wgYWNwaV9wZXJtYW5lbnRf
bW1hcDsKK2V4dGVybiBib29sIGFjcGlfc3luY19tZW1vcnlfdW5tYXA7CiAKIHZvaWQgX19pb21l
bSAqX19yZWYKIGFjcGlfb3NfbWFwX2lvbWVtKGFjcGlfcGh5c2ljYWxfYWRkcmVzcyBwaHlzLCBh
Y3BpX3NpemUgc2l6ZSk7Cg==
--001a113e28ae25a0fa0545c96314--
