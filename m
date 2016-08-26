From: "Kani, Toshimitsu" <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
Subject: Re: [PATCH 2/3] acpi, nfit: add dimm device notification support
Date: Fri, 26 Aug 2016 18:26:19 +0000
Message-ID: <1472235940.1532.23.camel@hpe.com>
References: <147198925154.3136.14739108342311837939.stgit@dwillia2-desk3.amr.corp.intel.com>
 <147198926249.3136.6163137762013359047.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <147198926249.3136.6163137762013359047.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Content-ID: <6EF9A0222886D94BA6BE5CF9B308A8C5-mmYPd6ayCNGroOM5E8FhRbjFIynDaujOfM0AETQt39g@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

T24gVHVlLCAyMDE2LTA4LTIzIGF0IDE0OjU0IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IFBlciAiQUNQSSA2LjEgU2VjdGlvbiA5LjIwLjMiIE5WRElNTSBkZXZpY2VzLCBjaGlsZHJlbiBv
ZiB0aGUNCj4gQUNQSTAwMTIgTlZESU1NIFJvb3QgZGV2aWNlLCBjYW4gcmVjZWl2ZSBoZWFsdGgg
ZXZlbnQgbm90aWZpY2F0aW9ucy4NCj4gDQo+IEdpdmVuIHRoYXQgdGhlc2UgZGV2aWNlcyBhcmUg
cHJlY2x1ZGVkIGZyb20gcmVnaXN0ZXJpbmcgYQ0KPiBub3RpZmljYXRpb24gaGFuZGxlciB2aWEg
YWNwaV9kcml2ZXIuYWNwaV9kZXZpY2Vfb3BzIChkdWUgdG8gbm8NCj4gX0hJRCksIHdlIHVzZSBh
Y3BpX2luc3RhbGxfbm90aWZ5X2hhbmRsZXIoKSBkaXJlY3RseS7CoMKgDQoNCkkndmUgY29uZmly
bWVkIHRoYXQgdGhpcyBBQ1BJIG5vdGlmeSBoYW5kbGVyIGlzIGNhbGxlZCBwcm9wZXJseS4NCg0K
PiBUaGUgcmVnaXN0ZXJlZCBoYW5kbGVyLCBhY3BpX252ZGltbV9ub3RpZnkoKSwgdHJpZ2dlcnMg
YSBwb2xsKDIpDQo+IGV2ZW50IG9uIHRoZSBubWVtWC9uZml0L2ZsYWdzIHN5c2ZzIGF0dHJpYnV0
ZSB3aGVuIGEgaGVhbHRoIGV2ZW50DQo+IG5vdGlmaWNhdGlvbiBpcyByZWNlaXZlZC4NCg0KVGhp
cyBzb3VuZHMgZ29vZCBpZGVhLCBidXQgc2hvdWxkIHdlIGRvY3VtZW50IHRoYXQgdGhlIHZhbHVl
IG9mIHN5c2ZzDQonZmxhZ3MnIGl0c2VsZiBkb2VzIG5vdCBnZXQgdXBkYXRlZD8gwqBVc2VyIHNw
YWNlIHByb2dyYW0gd2lsbCB0aGVuIG5lZWQNCnRvIGNhbGwgaXRzIF9EU00gdG8gZ2V0IGhlYWx0
aCBzdGF0dXMuDQoNClRoYW5rcywNCi1Ub3NoaQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdApMaW51eC1udmRp
bW1AbGlzdHMuMDEub3JnCmh0dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZkaW1tCg==
