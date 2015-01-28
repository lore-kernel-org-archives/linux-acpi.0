From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v7 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Wed, 28 Jan 2015 21:53:07 +0800
Message-ID: <54C8E9C3.9010508@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <54C7CF0D.4050607@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54C7CF0D.4050607@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, wangyijing@huawei.com, Mark Brown <broonie@kernel.org>, ashwin.chaugule@linaro.org, msalter@redhat.com, suravee.suthikulpanit@amd.com, Sudeep Holla <Sudeep.Holla@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, phoenix.liyi@huawei.com, linux-arm-kernel@lists.infradead.org, Charles.Garcia-Tobin@arm.com
List-Id: linux-acpi@vger.kernel.org

T24gMjAxNeW5tDAx5pyIMjjml6UgMDE6NDYsIFRpbXVyIFRhYmkgd3JvdGU6Cj4gT24gMDEvMTQv
MjAxNSAwOTowNCBBTSwgSGFuanVuIEd1byB3cm90ZToKPj4gVGhpcyBpcyB0aGUgdjcgb2YgQUNQ
SSBjb3JlIHBhdGNoZXMgZm9yIEFSTTY0IGJhc2VkIG9uIEFDUEkgNS4xCj4+Cj4KPiBUZXN0ZWQt
Ynk6IFRpbXVyIFRhYmkgPHRpbXVyQGNvZGVhdXJvcmEub3JnPgoKVGhhbmtzIQoKPgo+IEhvd2V2
ZXIsIHRoZXNlIDE3IHBhdGNoZXMgYXJlIGluc3VmZmljaWVudCB0byBtYWtlIEFDUEkgd29yayBj
b21wbGV0ZWx5Cj4gb24gQVJNNjQuICBJIG5lZWQgdG8gYWRkIHR3byBwYXRjaGVzOgo+Cj4gYWNw
aTogYWRkIGFybSB0byB0aGUgcGxhdGZvcm1zIHRoYXQgdXNlIGlvcmVtYXAKPiBodHRwOi8vbGlz
dHMubGluYXJvLm9yZy9waXBlcm1haWwvbGluYXJvLWFjcGkvMjAxNC1Ob3ZlbWJlci8wMDI5NDMu
aHRtbAo+Cj4gYWNwaTogZml4IGFjcGlfb3NfaW9yZW1hcCBmb3IgYXJtNjQKPiBodHRwOi8vbGlz
dHMubGluYXJvLm9yZy9waXBlcm1haWwvbGluYXJvLWFjcGkvMjAxNC1Ob3ZlbWJlci8wMDI4NTku
aHRtbAo+Cj4gV2l0aG91dCB0aGVzZSB0d28gcGF0Y2hlcywgbXkgQUNQSS1iYXNlZCBkZXZpY2Ug
ZHJpdmVycyBkb24ndCBwcm9iZS4gQ2FuCj4gd2UgYWRkIHRoZW0gdG8gdGhpcyAxNy1wYXRjaCBw
YXRjaHNldD8KCkkgd2lsbCBhZGQgdGhlbSBpbnRvIG5leHQgdmVyc2lvbiA6KQoKQmVzdCBSZWdh
cmRzLApIYW5qdW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
