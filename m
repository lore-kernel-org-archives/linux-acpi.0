From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC part1 PATCH 5/7] ARM64 / ACPI: Introduce arm_core.c and its
 related head file
Date: Thu, 5 Dec 2013 21:40:42 +0100
Message-ID: <201312052140.42269.arnd@arndb.de>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312050438.05117.arnd@arndb.de> <52A084EB.5010103@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52A084EB.5010103@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Al Stone <al.stone@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, Jon Masters <jonathan@jonmasters.org>, patches@linaro.org, Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>
List-Id: linux-acpi@vger.kernel.org

T24gVGh1cnNkYXkgMDUgRGVjZW1iZXIgMjAxMywgSGFuanVuIEd1byB3cm90ZToKPiBPbiAyMDEz
5bm0MTLmnIgwNeaXpSAxMTozOCwgQXJuZCBCZXJnbWFubiB3cm90ZToKPiA+IE9uIFR1ZXNkYXkg
MDMgRGVjZW1iZXIgMjAxMywgSGFuanVuIEd1byB3cm90ZToKPiA+PiArc3RhdGljIHVuc2lnbmVk
IGludCBnc2lfdG9faXJxKHVuc2lnbmVkIGludCBnc2kpCj4gPj4gK3sKPiA+PiArICAgICAgIGlu
dCBpcnEgPSBpcnFfY3JlYXRlX21hcHBpbmcoTlVMTCwgZ3NpKTsKPiA+PiArCj4gPj4gKyAgICAg
ICByZXR1cm4gaXJxOwo+ID4+ICt9Cj4gPiBJIHRoaW5rIHRoaXMgY291bGQgdXNlIGEgY29tbWVu
dCByZWdhcmRpbmcgeW91ciBwbGFucyBmb3IgSVJRIGRvbWFpbnMuCj4gPgo+ID4gRG8geW91IGV4
cGVjdCB0aGF0IGFsbCBBQ1BJIHN5c3RlbXMgd291bGQgaGF2ZSBvbmx5IGEgc2luZ2xlIEdJQyBJ
UlEKPiA+IGNvbnRyb2xsZXIgYW5kIGEgc2luZ2xlIGRvbWFpbiwgb3IgZG8geW91IHBsYW4gdG8g
YWRkIGlycWRvbWFpbiBjb2RlCj4gPiBsYXRlcj8KPiAKPiB3ZSBhZGRlZCBpcnFkb21haW4gY29k
ZSBpbiB0aGUgcGFydDIgcGF0Y2ggc2V0LCBpcyB0aGF0IHRoZSBjb2RlIG9rCj4gd2l0aCB5b3U/
CgpJIGRvbid0IHNlZSB3aGVyZSBpdCBnZXRzIGFkZGVkLiBEbyB5b3UgbWVhbiAiW1JGQyBwYXJ0
MiBQQVRDSCA4LzldIEFDUEkgLwpBUk02NDogVXBkYXRlIGFjcGlfcmVnaXN0ZXJfZ3NpIHRvIHJl
Z2lzdGVyIHdpdGggdGhlIGNvcmUgSVJRIHN1YnN5c3RlbSI/ClRoYXQgc3RpbGwganVzdCB1c2Vz
IGEgc2luZ2xlIGRvbWFpbi4KCldoZW4gd2UgdGFsa2VkIGFib3V0IEFDUEkgc3VwcG9ydCBhdCBM
aW5hcm8gY29ubmVjdCwgc29tZW9uZSBtZW50aW9uZWQKdGhhdCB0aGUgQUNQSSBzcGVjIGRvZXMg
aGF2ZSB0aGUgY29uY2VwdCBvZiBJUlEgZG9tYWlucywgYnV0IGl0IHNlZW1zCnRoZXkgYXJlIG5v
dCBpbXBsZW1lbnRlZCBieSBMaW51eC4KCkhvdyBkbyB5b3UgZ2V0IGEgbWFwcGluZyBmb3IgYW4g
SVJRIG9uIGEgc2Vjb25kYXJ5IGlycWNoaXAgc3VjaCBhcwphIEdQSU8gZXh0ZW5kZXI/CgoJQXJu
ZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
