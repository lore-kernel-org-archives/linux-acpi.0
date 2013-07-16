From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [Update][PATCH] ACPI / video / i915: Remove ACPI backlight if
 firmware expects Windows 8
Date: Tue, 16 Jul 2013 17:08:16 +0000
Message-ID: <1373994495.9314.1.camel@x230>
References: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
	 <12270512.1rshgKaUug@vostro.rjw.lan> <51DA7190.6080208@gmail.com>
	 <1683364.CdnoW81WLH@vostro.rjw.lan>
	 <1373981554.1956.5.camel@ThinkPad-X230.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1373981554.1956.5.camel@ThinkPad-X230.localdomain>
Content-Language: en-US
Content-ID: <6DB627994CA01C41BF352B8A36AB0F73@namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Aaron Lu <aaron.lwe@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "seth.forshee@canonical.com" <seth.forshee@canonical.com>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gVHVlLCAyMDEzLTA3LTE2IGF0IDE3OjMyICswNDAwLCBJZ29yIEduYXRlbmtvIHdyb3RlOg0K
PiBIbW0uIEkgZm91bmQgcmVncmVzc2lvbiBpbiB1c2VyLXNwYWNlLiBJbiBHTk9NRSAobWF5YmUg
YW5kIG90aGVyIERFcykgd2Ugbm8gbG9uZ2VyIHNlZSBzd2l0Y2ggc3RhdHVzIG9mIGJhY2tsaWdo
dC4NCg0KWWVhaCwgSSBjYW4gZHVwbGljYXRlIHRoYXQuIFJhZmFlbCwgd2UgaGF2ZSB0byBjYWxs
DQphY3BpX3ZpZGVvX2luaXRfYnJpZ2h0bmVzcygpIGV2ZW4gaWYgd2UncmUgbm90IGdvaW5nIHRv
IGluaXRpYWxpc2UgdGhlDQpiYWNrbGlnaHQgLSBUaGlua3BhZHMgc2VlbSB0byB1c2UgdGhpcyBh
cyB0aGUgdHJpZ2dlciBmb3IgZW5hYmxpbmcgQUNQSQ0Kbm90aWZpY2F0aW9ucyByYXRoZXIgdGhh
biBoYW5kbGluZyBpdCBpbiBmaXJtd2FyZS4gVGhpcyBzZWVtcyB0byBkbyB0aGUNCmpvYjoNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS92aWRlby5jIGIvZHJpdmVycy9hY3BpL3ZpZGVvLmMN
CmluZGV4IDAxYjFhMjUuLjcxODY1ZjcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2FjcGkvdmlkZW8u
Yw0KKysrIGIvZHJpdmVycy9hY3BpL3ZpZGVvLmMNCkBAIC05MDAsNiArOTAwLDkgQEAgc3RhdGlj
IHZvaWQgYWNwaV92aWRlb19kZXZpY2VfZmluZF9jYXAoc3RydWN0DQphY3BpX3ZpZGVvX2Rldmlj
ZSAqZGV2aWNlKQ0KIAkJZGV2aWNlLT5jYXAuX0REQyA9IDE7DQogCX0NCiANCisJaWYgKGFjcGlf
dmlkZW9faW5pdF9icmlnaHRuZXNzKGRldmljZSkpDQorCQlyZXR1cm47DQorDQogCWlmIChhY3Bp
X3ZpZGVvX3ZlcmlmeV9iYWNrbGlnaHRfc3VwcG9ydCgpKSB7DQogCQlzdHJ1Y3QgYmFja2xpZ2h0
X3Byb3BlcnRpZXMgcHJvcHM7DQogCQlzdHJ1Y3QgcGNpX2RldiAqcGRldjsNCkBAIC05MDksOSAr
OTEyLDYgQEAgc3RhdGljIHZvaWQgYWNwaV92aWRlb19kZXZpY2VfZmluZF9jYXAoc3RydWN0DQph
Y3BpX3ZpZGVvX2RldmljZSAqZGV2aWNlKQ0KIAkJc3RhdGljIGludCBjb3VudCA9IDA7DQogCQlj
aGFyICpuYW1lOw0KIA0KLQkJcmVzdWx0ID0gYWNwaV92aWRlb19pbml0X2JyaWdodG5lc3MoZGV2
aWNlKTsNCi0JCWlmIChyZXN1bHQpDQotCQkJcmV0dXJuOw0KIAkJbmFtZSA9IGthc3ByaW50ZihH
RlBfS0VSTkVMLCAiYWNwaV92aWRlbyVkIiwgY291bnQpOw0KIAkJaWYgKCFuYW1lKQ0KIAkJCXJl
dHVybjsNCg0KDQotLSANCk1hdHRoZXcgR2FycmV0dCB8IG1qZzU5QHNyY2YudWNhbS5vcmcNCg==
