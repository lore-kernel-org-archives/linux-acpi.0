From: "Kani, Toshimitsu" <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
Subject: Re: [PATCH] libnvdimm, pmem: fix badblocks notification crash
Date: Thu, 27 Apr 2017 22:25:07 +0000
Message-ID: <1493331874.30303.1.camel@hpe.com>
References: <149333101097.4714.1923436715100717938.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <149333101097.4714.1923436715100717938.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Content-ID: <421223E9121FF449B0C5ABD81595181C-mmYPd6ayCNGroOM5E8FhRbjFIynDaujOfM0AETQt39g@public.gmane.org>
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
Cc: "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

T24gVGh1LCAyMDE3LTA0LTI3IGF0IDE1OjEwIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IFRoZSBuZF9wbWVtX25vdGlmeSgpIHJvdXRpbmUgaXMgY2FsbGVkIHdoZW5ldmVyIGFuIEFSUw0K
PiAoYWRkcmVzcy1yYW5nZS1zY3J1YikgY29tcGxldGVzIHRvIGNvbW11bmljYXRlIHJlc3VsdHMg
dG8gdGhlDQo+IHBlci1uYW1lc3BhY2UgYmFkYmxvY2tzIGluc3RhbmNlcy4NCj4gDQo+IFdoZW4g
dGhlIG5hbWVzcGFjZSBpcyBpbiBidHQgbW9kZSB3ZSBjcmFzaCBiZWNhdXNlIHdlIGRvIG5vdCBh
bGxvY2F0ZQ0KPiBhIHN0cnVjdCBwbWVtX2RldmljZSBpbnN0YW5jZSBpbiB0aGF0IGNhc2UuIFJl
c3VsdGluZyBpbiB0aGUNCj4gZm9sbG93aW5nIGNyYXNoIHNpZ25hdHVyZToNCj4gDQo+IMKgQlVH
OiB1bmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQNCj4g
MDAwMDAwMDAwMDAwMDAzMA0KPiDCoElQOiBuZF9wbWVtX25vdGlmeSsweDMwLzB4ZjAgW25kX3Bt
ZW1dDQo+IMKgQ2FsbCBUcmFjZToNCj4gwqAgbmRfZGV2aWNlX25vdGlmeSsweDQwLzB4NTANCj4g
wqAgY2hpbGRfbm90aWZ5KzB4MTAvMHgyMA0KPiDCoCBkZXZpY2VfZm9yX2VhY2hfY2hpbGQrMHg1
MC8weDkwDQo+IMKgIG5kX3JlZ2lvbl9ub3RpZnkrMHgyMC8weDMwDQo+IMKgIG5kX2RldmljZV9u
b3RpZnkrMHg0MC8weDUwDQo+IMKgIG52ZGltbV9yZWdpb25fbm90aWZ5KzB4MjcvMHgzMA0KPiDC
oCBhY3BpX25maXRfc2NydWIrMHgzNDEvMHg1OTAgW25maXRdDQo+IMKgIHByb2Nlc3Nfb25lX3dv
cmsrMHgxOTcvMHg0NTANCj4gwqAgd29ya2VyX3RocmVhZCsweDRlLzB4NGEwDQo+IMKgIGt0aHJl
YWQrMHgxMDkvMHgxNDANCj4gDQo+IEdpdmVuIHRoYXQgd2UgZG9uJ3QgZXZlbiBwb3B1bGF0ZSB0
aGUgYnR0IGJhZGJsb2NrcyBpbnN0YW5jZSwganVzdA0KPiByZXR1cm4gZWFybHkgYW5kIHNraXAg
dGhlIGRldmljZSB0byByZWdpb24gbG9va3VwLg0KDQpXZSBwb3B1bGF0ZSB0aGUgYnR0IGJhZGJs
b2NrcyBpbnRvIG5zaW8tPmJiLCBhbmQgY2hlY2svY2xlYXIgdGhlbSBpbg0KbnNpb19yd19ieXRl
cygpLg0KDQpUaGFua3MsDQotVG9zaGkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlz
dHMuMDEub3JnCmh0dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZk
aW1tCg==
