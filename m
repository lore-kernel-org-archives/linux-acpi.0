From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 1/2] ACPI/IORT: set online numa node for smmuv3 device
Date: Wed, 27 Mar 2019 22:24:14 +0800
Message-ID: <26a2333f-0ea0-f6c4-d22e-bc4a1e91ff35@huawei.com>
References: <20190315021940.86905-1-wangkefeng.wang@huawei.com>
 <20190315021940.86905-2-wangkefeng.wang@huawei.com>
 <d45aa526-2cd9-2381-8856-6ddb7e7ced7d@arm.com>
 <20190320140016.GA8694@e107981-ln.cambridge.arm.com>
 <c0ba61db-0d99-0a50-92c6-cf6f9ad97872@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <c0ba61db-0d99-0a50-92c6-cf6f9ad97872@huawei.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, Hanjun Guo <hanjun.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-acpi@vger.kernel.org

S2luZGx5IHBpbmcsIHRoYW5rcy4KCk9uIDIwMTkvMy8yMSAxNDowOCwgS2VmZW5nIFdhbmcgd3Jv
dGU6Cj4gT24gMjAxOS8zLzIwIDIyOjAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90ZToKPj4gT24g
V2VkLCBNYXIgMjAsIDIwMTkgYXQgMTE6NDE6MThBTSArMDAwMCwgUm9iaW4gTXVycGh5IHdyb3Rl
Ogo+Pj4gT24gMTUvMDMvMjAxOSAwMjoxOSwgS2VmZW5nIFdhbmcgd3JvdGU6Cj4+Pj4gSWYgdGhl
cmUgaXMgb25seSBub2RlIDAgaW4gc3lzdGVtLCBidXQgc21tdXYzIGRldmljZSBpcyBzZXQgdG8g
b2ZmbGluZQo+Pj4+IG5vZGUgMSwgcGFyc2VkIGZyb20gcHJveGltaXR5IGRvbWFpbiBpbiBTTU1V
djMgSU9SVCB0YWJsZSwgaXQgd2lsbCBsZWFkCj4+Pj4gdG8gZm9sbG93aW5nIGNyYXNoLAo+Pj4g
U3VyZWx5IHRoYXQncyBqdXN0IGEgZmlybXdhcmUgYnVnPyBJZiBub2RlIDEgZG9lc24ndCBleGlz
dCBpbiB0aGUgc3lzdGVtCj4+PiB0aGVuIEFGQUlDUyBpZiB3ZSdyZSBwcmVzZW50ZWQgd2l0aCBh
IGRldmljZSBjbGFpbWluZyB0byBiZSBvbiB0aGF0IG5vZGUgd2UKPj4+IGNhbiBvbmx5IGFzc3Vt
ZSB0aGUgd2hvbGUgdGhpbmcgaXMgYm9ndXMuIFRodXMgaWYgd2UncmUgZ29pbmcgdG8gd29yayBh
cm91bmQKPj4+IGl0IGF0IGFsbCwgaXQgc2VlbXMgdG8gbWUgbGlrZSB3ZSBzaG91bGQgcmVqZWN0
IHRoZSBlbnRpcmUgZGV2aWNlIHJhdGhlcgo+Pj4gdGhhbiBqdXN0IGJvZGdpbmcgaXQgdG8gc29t
ZSBvdGhlciBub2RlLgo+IFllcywgSSBtZXQgdGhpcyBvb3BzIHdpdGggYSB3cm9uZyBJT1JUIGNv
bmZpZ3VyYXRpb24sCj4KPj4gSSBzdXNwZWN0IHRoYXQncyB0aGUgc2FtZSBpc3N1ZSB0aGlzIHRo
cmVhZCBhZGRyZXNzZWQ6Cj4+Cj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBjaS9D
QUVyU3BvNlMwcXRSNDJ0akdackZ1NGFNRkZ5VGh4MWhrSFRTb3dUdDZ0M1hlcnBIbkFAbWFpbC5n
bWFpbC5jb20vCj4gYW5kIHRoZSBzaXR1YXRpb24gbWVudGlvbmVkIGFib3ZlIHNob3VsZCB3aWxs
IHRyaWdnZXIgdGhpcyBpc3N1ZSB0b28uCj4KPiBJZiB0aGUgbm9kZSBpcyBvZmZsaW5lLCB3ZSBj
YW4ganVzdCByZXR1cm4gZnJvbSBhcm1fc21tdV92M19zZXRfcHJveGltaXR5KCkswqAgYW55IGJl
dHRlciB3YXkgdG8gZml4IHRoaXM/Cj4KPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
