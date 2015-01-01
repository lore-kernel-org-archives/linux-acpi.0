From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [PATCH v5 18/18] Documentation: ACPI for ARM64
Date: Thu, 1 Jan 2015 20:04:24 +0000
Message-ID: <20150101200424.GB12770@xora-haswell.xora.org.uk>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org>
 <CAJ5Y-eZ5cu9_OhG24yAv+CZq7zKg0vU+eVGekyN+9dDzaz1OhQ@mail.gmail.com>
 <8fc9550c96a468b3e50d51a37db68a33.squirrel@www.codeaurora.org>
 <54A3B526.9040903@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <54A3B526.9040903@linaro.org>
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
Cc: mark.rutland@arm.com, linaro-acpi@lists.linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, lv.zheng@intel.com, robh@kernel.org, Lorenzo.Pieralisi@arm.com, al.stone@linaro.org, daniel.lezcano@linaro.org, robert.moore@intel.com, linux-acpi@vger.kernel.org, grant.likely@linaro.org, Liviu.Dudau@arm.com, Charles.Garcia-Tobin@arm.com, rric@kernel.org, jason@lakedaemon.net, arnd@arndb.de, marc.zyngier@arm.com, jcm@redhat.com, broonie@kernel.org, "bhelgaas@google.com." <linux-arm-kernel@lists.infradead.org>, graeme.gregory@linaro.org, ashwinc@codeaurora.org, Kangkang.Shen@huawei.com, rdunlap@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, olof@lixom.net
List-Id: linux-acpi@vger.kernel.org

T24gV2VkLCBEZWMgMzEsIDIwMTQgYXQgMDQ6MzQ6NDZQTSArMDgwMCwgSGFuanVuIEd1byB3cm90
ZToKPiBPbiAyMDE05bm0MTLmnIgzMeaXpSAwNDoxMywgYXNod2luY0Bjb2RlYXVyb3JhLm9yZyB3
cm90ZToKPiA+SGkgSGFuanVuLAo+ID4KPiA+T3ZlcmFsbCB0aGUgZG9jdW1lbnQgbG9va3MgZ29v
ZCB0byB1cy4gU29tZSBtaW5vciBjbGFyaWZpY2F0aW9ucyBiZWxvdy4KPiA+Cj4gPj4tLS0tLS0t
LS0tIEZvcndhcmRlZCBtZXNzYWdlIC0tLS0tLS0tLS0KPiA+PkZyb206IEdyYWVtZSBHcmVnb3J5
IDxncmFlbWUuZ3JlZ29yeUBsaW5hcm8ub3JnPgo+ID4+Cj4gPj5BZGQgZG9jdW1lbnRhdGlvbiBm
b3IgdGhlIGd1aWRlbGluZXMgb2YgaG93IHRvIHVzZSBBQ1BJCj4gPj5vbiBBUk02NC4KPiA+Pgo+
ID4+U2lnbmVkLW9mZi1ieTogR3JhZW1lIEdyZWdvcnkgPGdyYWVtZS5ncmVnb3J5QGxpbmFyby5v
cmc+Cj4gPj5TaWduZWQtb2ZmLWJ5OiBBbCBTdG9uZSA8YWwuc3RvbmVAbGluYXJvLm9yZz4KPiA+
PlNpZ25lZC1vZmYtYnk6IEhhbmp1biBHdW8gPGhhbmp1bi5ndW9AbGluYXJvLm9yZz4KPiA+Pi0t
LQo+ID4+ICBEb2N1bWVudGF0aW9uL2FybTY0L2FybS1hY3BpLnR4dCB8ICAzMjMKPiA+PisrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAz
MjMgaW5zZXJ0aW9ucygrKQo+ID4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9h
cm02NC9hcm0tYWNwaS50eHQKPiA+Pgo+ID4KPiA+Wy4uXQo+ID4KPiA+PitSZWxhdGlvbnNoaXAg
d2l0aCBEZXZpY2UgVHJlZQo+ID4+Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPgo+
ID5bLi5dCj4gPgo+ID4+K1doZW4gYm9vdGluZyB1c2luZyBBQ1BJIHRhYmxlcywgdGhlIC9jaG9z
ZW4gbm9kZSBpbiBEVCB3aWxsIHN0aWxsIGJlCj4gPj5wYXJzZWQKPiA+Pit0byBleHRyYWN0IHRo
ZSBrZXJuZWwgY29tbWFuZCBsaW5lIGFuZCBpbml0cmQgcGF0aC4gIE5vIG90aGVyIHNlY3Rpb24g
b2YKPiA+PnRoZQo+ID4+K0RUIHdpbGwgYmUgdXNlZC4KPiA+Cj4gPklzIHRoaXMgc3RpbGwgdHJ1
ZT8KPiAKPiBObywgd2UgY2FuIGJvb3RpbmcgdGhlIEFDUEkgc3lzdGVtIGluIEVGSSBzdHViIHdp
dGhvdXQgZHRiLiBDYXRhbGluCj4gYWxzbyBwb2ludGVkIG91dCB0aGlzIGlzc3VlLCBJIHdpbGwg
cmVtb3ZlIHRoaXMgcGFyYWdyYXBoLgo+IAoKVGhlIHBhcmFncmFwaCBpcyBzdGlsbCBjb3JyZWN0
LCB0aGUgL2Nob3NlbiBub2RlIGlzIGFsd2F5cyBwcmVzZW50IGV2ZW4KaWYgbm90aGluZyBlbHNl
IGlzLgoKR3JhZW1lCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
