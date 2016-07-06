From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dax: use devm_add_action_or_reset()
Date: Wed, 6 Jul 2016 15:18:31 -0700
Message-ID: <CAPcyv4ivACkVySPL_-EQGWCVE=QHjQ+yBk-7tC12Ui29iuFWUQ@mail.gmail.com>
References: <1467697807-27067-1-git-send-email-vikas.cha.sajjan@hpe.com>
 <20160705065904.ek4ltpveavadqdqt@c203.arch.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20160705065904.ek4ltpveavadqdqt-3LAbnSA0sDC4fIQPS+WK3rNAH6kLmebB@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Johannes Thumshirn <jthumshirn-l3A5Bk7waGM@public.gmane.org>
Cc: Vikas C Sajjan <vikas.cha.sajjan-ZPxbGqLxI0U@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

VGhhbmtzLCBhcHBsaWVkLgoKT24gTW9uLCBKdWwgNCwgMjAxNiBhdCAxMTo1OSBQTSwgSm9oYW5u
ZXMgVGh1bXNoaXJuIDxqdGh1bXNoaXJuQHN1c2UuZGU+IHdyb3RlOgo+IE9uIFR1ZSwgSnVsIDA1
LCAyMDE2IGF0IDExOjIwOjA3QU0gKzA1MzAsIFZpa2FzIEMgU2FqamFuIHdyb3RlOgo+PiBJZiBk
ZXZtX2FkZF9hY3Rpb24oKSBmYWlscywgd2UgYXJlIGV4cGxpY2l0bHkgY2FsbGluZyB0aGUgY2xl
YW51cCB0byBmcmVlCj4+IHRoZSByZXNvdXJjZXMgYWxsb2NhdGVkLiBVc2UgdGhlIGhlbHBlciBk
ZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoKQo+PiBhbmQgcmV0dXJuIGRpcmVjdGx5IGluIGNhc2Ug
b2YgZXJyb3IsIHNpbmNlIHRoZSBjbGVhbnVwIGZ1bmN0aW9uCj4+IGhhcyBiZWVuIGFscmVhZHkg
Y2FsbGVkIGJ5IHRoZSBoZWxwZXIgaWYgdGhlcmUgd2FzIGFueSBlcnJvci4KPj4KPj4gUmVwb3J0
ZWQtYnk6IFN1ZGlwIE11a2hlcmplZSA8c3VkaXBtLm11a2hlcmplZUBnbWFpbC5jb20+Cj4+IFNp
Z25lZC1vZmYtYnk6IFZpa2FzIEMgU2FqamFuIDx2aWthcy5jaGEuc2FqamFuQGhwZS5jb20+Cj4K
PiBSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqdGh1bXNoaXJuQHN1c2UuZGU+Cj4K
PiAtLQo+IEpvaGFubmVzIFRodW1zaGlybiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFN0b3JhZ2UKPiBqdGh1bXNoaXJuQHN1c2UuZGUgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg5Cj4gU1VTRSBMSU5VWCBHbWJILCBNYXhmZWxk
c3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKPiBHRjogRmVsaXggSW1lbmTDtnJmZmVyLCBKYW5lIFNt
aXRoYXJkLCBHcmFoYW0gTm9ydG9uCj4gSFJCIDIxMjg0IChBRyBOw7xybmJlcmcpCj4gS2V5IGZp
bmdlcnByaW50ID0gRUMzOCA5Q0FCIEMyQzQgRjI1RCA4NjAwIEQwRDAgMDM5MyA5NjlEIDJENzYg
MDg1MApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udmRpbW0gbWFpbGluZyBsaXN0CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKaHR0cHM6Ly9s
aXN0cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udmRpbW0K
