From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v20 08/17] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
Date: Thu, 19 Jan 2017 20:41:14 +0800
Message-ID: <74160889-5eb0-ceb2-2727-61e9d538cf2f@linaro.org>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-9-fu.wei@linaro.org>
 <cafa8c7a-9c7c-51ba-5566-0cfe1fe6f764@linaro.org>
 <CADyBb7uGVu6Po4hCD45WOrQvWYwZgtSbE5z9rbRa7gZ1P5-4tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CADyBb7uGVu6Po4hCD45WOrQvWYwZgtSbE5z9rbRa7gZ1P5-4tg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fu Wei <fu.wei@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, rruigrok@codeaurora.org, Wim Van Sebroeck <wim@iguana.be>, Wei Huang <wei@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, "Abdulhamid,
 Harb" <harba@codeaurora.org>, Julien Grall <julien.grall@arm.com>, linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Christopher Covington <cov@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists
List-Id: linux-acpi@vger.kernel.org

T24gMjAxNy8xLzE5IDE3OjQ0LCBGdSBXZWkgd3JvdGU6Cj4gSGkgSGFuanVuLAo+Cj4gT24gMTkg
SmFudWFyeSAyMDE3IGF0IDE2OjAyLCBIYW5qdW4gR3VvIDxoYW5qdW4uZ3VvQGxpbmFyby5vcmc+
IHdyb3RlOgo+PiBIaSBGdXdlaSwKPj4KPj4gT25lIGNvbW1lbnRzIGJlbG93Lgo+Pgo+Pgo+PiBP
biAyMDE3LzEvMTggMjE6MjUsIGZ1LndlaUBsaW5hcm8ub3JnIHdyb3RlOgo+Pj4KPj4+IEZyb206
IEZ1IFdlaSA8ZnUud2VpQGxpbmFyby5vcmc+Cj4+Pgo+Pj4gVGhlIGNvdW50ZXIgZnJlcXVlbmN5
IGRldGVjdGlvbiBjYWxsKGFyY2hfdGltZXJfZGV0ZWN0X3JhdGUpIGNvbWJpbmVzIHR3bwo+Pj4g
d2F5cyB0byBnZXQgY291bnRlciBmcmVxdWVuY3k6IHN5c3RlbSBjb3Byb2Nlc3NvciByZWdpc3Rl
ciBhbmQgTU1JTyB0aW1lci4KPj4+IEJ1dCBpbiBhIHNwZWNpZmljIHRpbWVyIGluaXQgY29kZSwg
d2Ugb25seSBuZWVkIG9uZSB3YXkgdG8gdHJ5Ogo+Pj4gZ2V0dGluZyBmcmVxdWVuY3kgZnJvbSBN
TUlPIHRpbWVyIHJlZ2lzdGVyIHdpbGwgYmUgbmVlZGVkIG9ubHkgd2hlbiB3ZQo+Pj4gaW5pdCBN
TUlPIHRpbWVyOyBnZXR0aW5nIGZyZXF1ZW5jeSBmcm9tIHN5c3RlbSBjb3Byb2Nlc3NvciByZWdp
c3RlciB3aWxsCj4+PiBiZSBuZWVkZWQgb25seSB3aGVuIHdlIGluaXQgYXJjaCB0aW1lci4KPj4+
Cj4+PiBUaGlzIHBhdGNoIHNlcGFyYXRlcyBwYXRocyB0byBkZXRlcm1pbmUgZnJlcXVlbmN5Ogo+
Pj4gU2VwYXJhdGUgb3V0IHRoZSBNTUlPIGZyZXF1ZW5jeSBhbmQgdGhlIHN5c3JlZyBmcmVxdWVu
Y3kgZGV0ZWN0aW9uIGNhbGwsCj4+PiBhbmQgdXNlIHRoZSBhcHByb3ByaWF0ZSBvbmUgZm9yIHRo
ZSBjb3VudGVyLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEZ1IFdlaSA8ZnUud2VpQGxpbmFyby5v
cmc+Cj4+PiAtLS0KPj4+ICBkcml2ZXJzL2Nsb2Nrc291cmNlL2FybV9hcmNoX3RpbWVyLmMgfCA0
MAo+Pj4gKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCj4+PiAgMSBmaWxlIGNo
YW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Nsb2Nrc291cmNlL2FybV9hcmNoX3RpbWVyLmMKPj4+IGIvZHJpdmVycy9j
bG9ja3NvdXJjZS9hcm1fYXJjaF90aW1lci5jCj4+PiBpbmRleCA2NDg0Zjg0Li45NDgyNDgxIDEw
MDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9jbG9ja3NvdXJjZS9hcm1fYXJjaF90aW1lci5jCj4+PiAr
KysgYi9kcml2ZXJzL2Nsb2Nrc291cmNlL2FybV9hcmNoX3RpbWVyLmMKPj4+IEBAIC00ODgsMjMg
KzQ4OCwzMyBAQCBzdGF0aWMgaW50IGFyY2hfdGltZXJfc3RhcnRpbmdfY3B1KHVuc2lnbmVkIGlu
dCBjcHUpCj4+PiAgICAgICAgIHJldHVybiAwOwo+Pj4gIH0KPj4+Cj4+PiAtc3RhdGljIHZvaWQg
YXJjaF90aW1lcl9kZXRlY3RfcmF0ZSh2b2lkIF9faW9tZW0gKmNudGJhc2UpCj4+PiArc3RhdGlj
IHZvaWQgX19hcmNoX3RpbWVyX2RldGVybWluZV9yYXRlKHUzMiByYXRlKQo+Pj4gIHsKPj4+IC0g
ICAgICAgLyogV2hvIGhhcyBtb3JlIHRoYW4gb25lIGluZGVwZW5kZW50IHN5c3RlbSBjb3VudGVy
PyAqLwo+Pj4gLSAgICAgICBpZiAoYXJjaF90aW1lcl9yYXRlKQo+Pj4gLSAgICAgICAgICAgICAg
IHJldHVybjsKPj4+ICsgICAgICAgLyogQ2hlY2sgdGhlIHRpbWVyIGZyZXF1ZW5jeS4gKi8KPj4+
ICsgICAgICAgaWYgKCFhcmNoX3RpbWVyX3JhdGUpIHsKPj4+ICsgICAgICAgICAgICAgICBpZiAo
cmF0ZSkKPj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGFyY2hfdGltZXJfcmF0ZSA9IHJhdGU7
Cj4+PiArICAgICAgICAgICAgICAgZWxzZQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgcHJf
d2FybigiZnJlcXVlbmN5IG5vdCBhdmFpbGFibGVcbiIpOwo+Pj4gKyAgICAgICB9IGVsc2UgaWYg
KHJhdGUgJiYgYXJjaF90aW1lcl9yYXRlICE9IHJhdGUpIHsKPj4KPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgXgo+PiBUeXBvPyBJIHRoaW5rIGl0J3MgIiYiIGhlcmUuCj4KPiBOb3QgYSB0eXBv
LCBJdCdzIGRlZmluaXRlbHkgYSDigJwmJuKAnSAgOi0pCj4KPiBIZXJlIGFyY2hfdGltZXJfcmF0
ZSBpcyBub3QgemVyby4KPgo+IElmIHJhdGUgaXMgbm90IHplcm8odGhhdCBtZWFucyB3ZSBnb3Qg
YSB2YWxpZCByYXRlKSwgYW5kCj4gYXJjaF90aW1lcl9yYXRlICE9IHJhdGUgLAo+IHdlIHdpbGwg
cHJpbnQgd2FybmluZyBtZXNzYWdlLgoKQWgsIG1pc3JlYWRpbmcgdGhlIGNvZGUsIHRoYW5rcyBm
b3IgY2xhcmlmeSA6KQoKSGFuanVuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
