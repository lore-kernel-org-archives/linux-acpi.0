From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [Patch v3 5/7] PCI/ACPI: Consolidate common PCI host bridge code
 into ACPI core
Date: Fri, 22 May 2015 19:23:32 +0800
Message-ID: <555F11B4.8000503@linaro.org>
References: <1431593803-5213-1-git-send-email-jiang.liu@linux.intel.com>
 <1431593803-5213-6-git-send-email-jiang.liu@linux.intel.com>
 <5559E44B.2010702@linaro.org> <555BFC72.3060703@linux.intel.com>
 <555C0091.6050301@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <555C0091.6050301@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jiang Liu <jiang.liu@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Yijing Wang <wangyijing@huawei.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

T24gMjAxNeW5tDA15pyIMjDml6UgMTE6MzMsIEhhbmp1biBHdW8gd3JvdGU6Cj4gK0NDIFN1cmF2
ZWUsCj4KPiBPbiAyMDE15bm0MDXmnIgyMOaXpSAxMToxNiwgSmlhbmcgTGl1IHdyb3RlOgo+PiBP
biAyMDE1LzUvMTggMjE6MDgsIEhhbmp1biBHdW8gd3JvdGU6Cj4+PiBIaSBKaWFuZywKPj4+Cj4+
PiBPbiAyMDE15bm0MDXmnIgxNOaXpSAxNjo1NiwgSmlhbmcgTGl1IHdyb3RlOgo+Pj4+IEludHJv
ZHVjZSBjb21tb24gaW50ZXJmYWNlIGFjcGlfcGNpX3Jvb3RfY3JlYXRlKCkgYW5kIHJlbGF0ZWQg
ZGF0YQo+Pj4+IHN0cnVjdHVyZXMgdG8gY3JlYXRlIFBDSSByb290IGJ1cyBmb3IgQUNQSSBQQ0kg
aG9zdCBicmlkZ2VzLiBJdCB3aWxsCj4+Pj4gYmUgdXNlZCB0byBraWxsIGR1cGxpY2F0ZWQgYXJj
aCBzcGVjaWZpYyBjb2RlIGZvciBJQTY0IGFuZCB4ODYuIEl0IG1heQo+Pj4+IGFsc28gaGVscCBB
Uk02NCBpbiBmdXR1cmUuCj4+Pgo+Pj4gQXMgSSBjb21tZW50ZWQgaW4gcHJldmlvdXMgdmVyc2lv
biwgdGhpcyBwYXRjaCB3aWxsIGludHJvZHVjZQo+Pj4gY29tcGlsZSBlcnJvciBvbiBBQ1BJIGVu
YWJsZWQgQVJNNjQga2VybmVsIGJlY2F1c2Ugc3RydWN0Cj4+PiBwY2lfY29udHJvbGxlciBpcyBu
b3QgZGVmaW5lZCBmb3IgQVJNNjQsIHNvIGhvdyBhYm91dCBhZGRpbmcKPj4+IHRoZSBmb2xsb3dp
bmcgcGF0Y2ggYmVmb3JlIHRoaXMgcGF0Y2gsIG9yIHNxdWFzaCB0byB0aGlzIG9uZSwKPj4+IGRv
ZXMgaXQgbWFrZSBzZW5zZT8KPj4gSGkgSGFuanVuLAo+PiAgICAgVGhhbmtzIGZvciBmaXhpbmcg
dGhpcyBidWlsZGluZyBpc3N1ZSBmb3IgQVJNNjQuIFRoZSBwYXRjaAo+PiBpcyByZWFsbHkgd2hh
dCBJIHdhbnQ6KS4gV2lsbCBtZXJnZSBpdCBpbnRvIG5leHQgdmVyc2lvbi4gV2l0aCB0aGlzCj4+
IHBhdGNoIGFwcGxpZWQsIGFyZSB0aGVyZSBhbnkgb3RoZXIgaXNzdWVzIGZyb20gQVJNNjQgc2lk
ZT8KPgo+IFN1cmF2ZWUgaXMgdGVzdGluZyBBUk02NCBQQ0kgb24gdG9wIG9mIHlvdXIgcGF0Y2gg
c2V0LCBoZSBjYW4gY29uZmlybQo+IHRoYXQgaWYgdGhlcmUgYXJlIGFueSBvdGhlciBpc3N1ZXMg
OikgKFN1cmF2ZWUgaGFzIGEgcmVhbCBBUk02NCBoYXJkd2FyZQo+IGluIGhhbmQpCgpBZnRlciBj
b25maXJtZWQgd2l0aCBTdXJhdmVlLCB0aGlzIHBhdGNoIHNldCB3b3JrcyBPSyBvbiBBUk02NApo
YXJkd2FyZSBmb3IgUENJIGhvc3RicmlkZ2UgaW5pdCwgYW5kIGNhbiBlbnVtZXJhdGUgUENJIGRl
dmljZXMKKGFkZGluZyBzb21lIEFSTTY0IHJlbGF0ZWQgUENJIHBhdGNoZXMpIGFuZCB3b3JrcyBm
aW5lIHdpdGggbGVnYWN5CmludGVycnVwdCwgc28gdG8gbWUsIHRoaXMgcGF0Y2ggc2V0IGlzIGdv
b2QgdG8gZ28gOikKCkZvciB0aGlzIHBhdGNoc2V0OgoKVGVzdGVkLWJ5OiBTdXJhdmVlIFN1dGhp
a3VscGFuaXQgPHN1cmF2ZWUuc3V0aGlrdWxwYW5pdEBhbWQuY29tPgoKSSB3aWxsIGFkZCBteSBS
ZXZpZXdlZC1ieSBmb3Igc29tZSBvZiBwYXRjaGVzIGxhdGVyLgoKVGhhbmtzCkhhbmp1bgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
