From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 0/3] ACPI/i915: Add support for PMIC MIPI sequence elements
Date: Fri, 14 Dec 2018 13:24:14 +0100
Message-ID: <20181214122417.2729-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

SGkgQWxsLAoKVGhlIG1haW4gcmVhc29uIGZvciBzZW5kaW5nIG91dCB0aGlzIHY1IGlzIGJlY2F1
c2UgdGhlIENJIGZhaWxlZCB2NAooZXZlbiB0aG91Z2ggaXQgbGlrZWQgdjEtdjMgYW5kIG5vdGhp
bmcgc2lnbmlmaWNhbnQgY2hhbmdlZCksIHRoaXMKd2FzIGxpa2VseSBhIGZhbHNlIHBvc2l0aXZl
LCBzbyB0aGUgbWFpbiBnb2FsIG9mIHRoaXMgdmVyc2lvbiBpcyB0byBnaXZlCnRoaXMgYW5vdGhl
ciBDSSBydW4uCgpCZXNpZGVzIHRoYXQgSSd2ZSBkcm9wcGVkIHRoZSB1bm5lY2Vzc2FyeSAjaW5j
bHVkZSBmcm9tIHRoZSAybmQgcGF0Y2gKd2hpY2ggTWlrYSBwb2ludGVkIG91dC4KClBhdGNoZXMg
MSBhbmQgMiBoYXZlIGJlZW4gQWNrZWQgZm9yIG1lcmdpbmcgdGhyb3VnaCBkcm0taW50ZWwtbmV4
dC1xdWV1ZWQKZXZlbiB0aG91Z2ggdGhleSBhcmUgZm9yIHRoZSBBQ1BJIHN1YnN5cywgc28gdGhh
dCB3ZSBjYW4ga2VlcCB0aGUgc2V0CnRvZ2V0aGVyLgoKSWYgSSBjYW4gZ2V0IGEgUmV2aWV3ZWQt
Ynkgb3IgQWNrZWQtYnkgZm9yIHRoZSAzdGggcGF0Y2ggZnJvbSBvbmUgb2YgdGhlCmk5MTUgcGVv
cGxlLCB0aGVuIEkgY2FuIHB1c2ggdGhpcyBzZXQgdG8gZGlucS4KClJlZ2FyZHMsCgpIYW5zCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwg
bWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
