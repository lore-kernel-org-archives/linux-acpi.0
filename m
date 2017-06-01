From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 5/5] ACPI: Switch to use generic guid_t
	in acpi_evaluate_dsm()
Date: Thu, 1 Jun 2017 07:24:00 -0700
Message-ID: <CAPcyv4jz0RHf5hLQgVvDQZvwcHeg0dV__N0OndS54EjpoS+EDw@mail.gmail.com>
References: <20170531194152.65927-1-andriy.shevchenko@linux.intel.com>
 <20170531194152.65927-6-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20170531194152.65927-6-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, intel-gfx@lists.freedesktop.org, Amir Goldstein <amir73il@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Ben Skeggs <bskeggs@redhat.com>, Borislav Petkov <bp@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Christoph Hellwig <hch@lst.de>
List-Id: linux-acpi@vger.kernel.org

T24gV2VkLCBNYXkgMzEsIDIwMTcgYXQgMTI6NDEgUE0sIEFuZHkgU2hldmNoZW5rbwo8YW5kcml5
LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPiB3cm90ZToKPiBhY3BpX2V2YWx1YXRlX2RzbSgp
IGFuZCBmcmllbmRzIHRha2UgYSBwb2ludGVyIHRvIGEgcmF3IGJ1ZmZlciBvZiAxNgo+IGJ5dGVz
LiBJbnN0ZWFkIHdlIGNvbnZlcnQgdGhlbSB0byB1c2UgZ3VpZF90IHR5cGUuIEF0IHRoZSBzYW1l
IHRpbWUgd2UKPiBjb252ZXJ0IGN1cnJlbnQgdXNlcnMuCj4KPiBhY3BpX3N0cl90b191dWlkKCkg
YmVjb21lcyB1c2VsZXNzIGFmdGVyIHRoZSBjb252ZXJzaW9uIGFuZCBpdCdzIHNhZmUgdG8KPiBn
ZXQgcmlkIG9mIGl0Lgo+Cj4gQ2M6IEJvcmlzbGF2IFBldGtvdiA8YnBAc3VzZS5kZT4KPiBDYzog
RGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+Cj4gQ2M6IEFtaXIgR29sZHN0
ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Cj4gQ2M6IEphcmtrbyBTYWtraW5lbiA8amFya2tvLnNh
a2tpbmVuQGxpbnV4LmludGVsLmNvbT4KPiBSZXZpZXdlZC1ieTogSmFuaSBOaWt1bGEgPGphbmku
bmlrdWxhQGludGVsLmNvbT4KPiBBY2tlZC1ieTogSmFuaSBOaWt1bGEgPGphbmkubmlrdWxhQGlu
dGVsLmNvbT4KPiBDYzogQmVuIFNrZWdncyA8YnNrZWdnc0ByZWRoYXQuY29tPgo+IEFja2VkLWJ5
OiBCZW5qYW1pbiBUaXNzb2lyZXMgPGJlbmphbWluLnRpc3NvaXJlc0ByZWRoYXQuY29tPgo+IEFj
a2VkLWJ5OiBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4KPiBDYzogQWRyaWFuIEh1bnRl
ciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+Cj4gQ2M6IFlpc2VuIFpodWFuZyA8eWlzZW4uemh1
YW5nQGh1YXdlaS5jb20+Cj4gQWNrZWQtYnk6IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2ds
ZS5jb20+Cj4gQWNrZWQtYnk6IEZlbGlwZSBCYWxiaSA8ZmVsaXBlLmJhbGJpQGxpbnV4LmludGVs
LmNvbT4KPiBBY2tlZC1ieTogTWF0aGlhcyBOeW1hbiA8bWF0aGlhcy5ueW1hbkBsaW51eC5pbnRl
bC5jb20+Cj4gUmV2aWV3ZWQtYnk6IEhlaWtraSBLcm9nZXJ1cyA8aGVpa2tpLmtyb2dlcnVzQGxp
bnV4LmludGVsLmNvbT4KPiBDYzogTGlhbSBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWlsLmNvbT4K
PiBDYzogTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPgo+IFNpZ25lZC1vZmYtYnk6IEFu
ZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPgo+IC0tLQo+
ICBkcml2ZXJzL2FjcGkvYWNwaV9leHRsb2cuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0
ICsrLS0KPiAgZHJpdmVycy9hY3BpL2J1cy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAyMyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gIGRyaXZlcnMvYWNwaS9uZml0L2NvcmUu
YyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrLS0tCgpBY2tlZC1ieTogRGFuIFdp
bGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
