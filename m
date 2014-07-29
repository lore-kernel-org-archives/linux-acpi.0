From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 01/19] ARM64 / ACPI: Get RSDP and ACPI boot-time tables
Date: Tue, 29 Jul 2014 22:07:40 +0800
Message-ID: <53D7AAAC.6070606@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-2-git-send-email-hanjun.guo@linaro.org>
 <53D69678.20002@arm.com> <53D79CD8.9050709@linaro.org>
 <53D7A6A2.9020005@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <53D7A6A2.9020005@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Mark Brown <broonie@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "graeme.gregory@linaro.org" <graeme.gregory>
List-Id: linux-acpi@vger.kernel.org

T24gMjAxNOW5tDA35pyIMjnml6UgMjE6NTAsIFN1ZGVlcCBIb2xsYSB3cm90ZToKPgo+IE9uIDI5
LzA3LzE0IDE0OjA4LCBIYW5qdW4gR3VvIHdyb3RlOgo+PiBPbiAyMDE0LTctMjkgMjoyOSwgU3Vk
ZWVwIEhvbGxhIHdyb3RlOgo+PiBbLi4uXQo+Pj4+ICsKPj4+PiArLyoKPj4+PiArICogV2UgbmV2
ZXIgcGxhbiB0byB1c2UgUlNEVCBvbiBhcm0vYXJtNjQgYXMgaXRzIGRlcHJlY2F0ZWQgaW4gc3Bl
YyBidXQgdGhpcwo+Pj4+ICsgKiB2YXJpYWJsZSBpcyBzdGlsbCByZXF1aXJlZCBieSB0aGUgQUNQ
SSBjb3JlCj4+Pj4gKyAqLwo+Pj4+ICt1MzIgYWNwaV9yc2R0X2ZvcmNlZDsKPj4+Cj4+PiBUaGlz
IGxvb2tzIGxpa2UgeWV0IGFub3RoZXIgc3RyYXkgdmFyaWFibGUgbm90IHVzZWQgYW55d2hlcmUg
aW5jbHVkaW5nCj4+PiBjb3JlIEFDUEkKPj4KPj4gSXQgd2lsbCBiZSB1c2VkIGJ5IEFDUElDQSB0
byBnZXQgdGhlIFJTRFAgaW4gYWNwaV90Yl9wYXJzZV9yb290X3RhYmxlKCkKPj4gaW4gdGJ1dGls
cy5jLgo+Pgo+Cj4gTm8gSSBjb3VsZG4ndCBmaW5kIGl0IGluIG1haW5saW5lL2FjcGljYS9saW51
eC1uZXh0KHBtIHRyZWUpLgo+Cj4gT24gZnVydGhlciBkaWdnaW5nIGZvdW5kIHRoYXQgY29tbWl0
IGZhYjQ2MTA1ODM4NSgiQUNQSUNBOiBDbGVhbnVwIHRoZQo+IG9wdGlvbiBvZiBmb3JjaW5nIHRo
ZSB1c2Ugb2YgdGhlIFJTRFQiKSBoYXMgcmVuYW1lZCBpdCB0bwo+IGFjcGlfZ2JsX2RvX25vdF91
c2VfeHNkdCBhbmQgbW92ZWQgaXQgaW50byBhY3BpY2Egd2l0aCBkZWZhdWx0IGZhbHNlLgo+IFNv
IHlvdSBjYW4gcmVtb3ZlIHRoaXMuCgpBaCwgbXkgYmFkLiBJIGdyZXBwZWQgaXQgaW4gYW5vdGhl
ciB2ZXJzaW9uIG9mIGtlcm5lbCBhbmQgZm91bmQgdGhlIG91dGRhdGVkCnJlc3VsdCwgSSB3aWxs
IHVwZGF0ZSB0aGlzIHBhdGNoLgoKVGhhbmtzCkhhbmp1bgoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
