From: Hector Martin <hector@marcansoft.com>
Subject: Re: [PATCH] Work around negative s16 battery current on Acer
Date: Wed, 01 Jul 2009 22:19:16 +0200
Message-ID: <4A4BC4C4.1030407@marcansoft.com>
References: <4A4BA8F9.9070803@marcansoft.com> <20090701112958.1d24e06f.akpm@linux-foundation.org> <4A4BAD0C.9020302@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070100060808020906070103"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from marcansoft.com ([80.68.93.119]:53814 "EHLO smtp.marcansoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700AbZGAUTQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Jul 2009 16:19:16 -0400
In-Reply-To: <4A4BAD0C.9020302@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, lenb@kernel.org, linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------070100060808020906070103
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Alexey Starikovskiy wrote:
> Andrew Morton пишет:
>> On Wed, 01 Jul 2009 20:20:41 +0200
>> acpi_battery has no field `current_now' in 2.6.30 or 2.6.31-rc1.  Which
>> kernel version are you patching here?

2.6.29. Guess I got unlucky.

>> Also, I wonder if we need a quirk.  Is a "negative" value _ever_
>> correct?  If not, could we do the negation unconditionally?

> The problem is that the variable is s64 and not "negative" value is
> related to s16 portion of it.
> It's possible to do this only for "current" mode, in "power" mode values
> of "negative" s16 range may be valid positive values.

Exactly. This is why I further qualified the quirk so it operates for
Acer machines in current (mA) mode only. Currents >32767mA are insane,
but powers >32767mW are not.

The value is nominally a signed 32-bit int as follows:
>=0: charge current
-1: unknown

(The spec defines this in unsigned terms but the result is the same).

The problem here is that my laptop erroneously reports charging currents
as (65536 - current). Interpreting this as a signed 16-bit int yields
the correct signed value, which can then be abs()ed.

The only addition that I'd imagine might make sense would be to check
for current_now != -1 before applying the 16-bit trick, since 32-bit
signed -1 is a valid value that means "unknown current". This does not
conflict with 16-bit -1 because the 16-bits are not sign-extended so
-1mA reports as 65535, not -1. Attached new patch with this change.

For reference, the DSDT does something like this:

s32 current_now;

current_now = (EC_BAT_CURRENT_HIGH<<8) | EC_BAT_CURRENT_LOW;
current_now = (0xFFFF - current_now) + 1;

The "homebrew" two's complement negation attempts to make discharge
currents positive but also makes charge currents negative. It's also
completely wrong for 32-bit quantities, which is what we're dealing with
here.


-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc


--------------070100060808020906070103
Content-Type: text/plain;
 name="acpi-battery-acer-rate-quirk.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="acpi-battery-acer-rate-quirk.patch"

U2lnbmVkLW9mZi1ieTogSGVjdG9yIE1hcnRpbiA8aGVjdG9yQG1hcmNhbnNvZnQuY29tPgot
LS0gbGludXgvZHJpdmVycy9hY3BpL2JhdHRlcnkuYy5vbGQJMjAwOS0wNy0wMSAxOToxNzoz
My4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4L2RyaXZlcnMvYWNwaS9iYXR0ZXJ5LmMJMjAw
OS0wNy0wMSAxOTo1Mjo0My4wMDAwMDAwMDAgKzAyMDAKQEAgLTg0LDYgKzg0LDEwIEBACiAK
IE1PRFVMRV9ERVZJQ0VfVEFCTEUoYWNwaSwgYmF0dGVyeV9kZXZpY2VfaWRzKTsKIAorLyog
Rm9yIGJ1Z2d5IERTRFRzIHRoYXQgcmVwb3J0IG5lZ2F0aXZlIDE2LWJpdCB2YWx1ZXMgZm9y
IGVpdGhlciBjaGFyZ2luZworICogb3IgZGlzY2hhcmdpbmcgYW5kL29yIHJlcG9ydCAwIGFz
IDY1NTM2IGR1ZSB0byBiYWQgbWF0aC4KKyAqLworI2RlZmluZSBRVUlSS19TSUdORUQxNl9D
VVJSRU5UIDB4MDAwMQogCiBzdHJ1Y3QgYWNwaV9iYXR0ZXJ5IHsKIAlzdHJ1Y3QgbXV0ZXgg
bG9jazsKQEAgLTExMSw2ICsxMTUsNyBAQAogCWludCBzdGF0ZTsKIAlpbnQgcG93ZXJfdW5p
dDsKIAl1OCBhbGFybV9wcmVzZW50OworCWxvbmcgcXVpcmtzOwogfTsKIAogI2RlZmluZSB0
b19hY3BpX2JhdHRlcnkoeCkgY29udGFpbmVyX29mKHgsIHN0cnVjdCBhY3BpX2JhdHRlcnks
IGJhdCk7CkBAIC0zODcsNiArMzkyLDEwIEBACiAJCQkJIHN0YXRlX29mZnNldHMsIEFSUkFZ
X1NJWkUoc3RhdGVfb2Zmc2V0cykpOwogCWJhdHRlcnktPnVwZGF0ZV90aW1lID0gamlmZmll
czsKIAlrZnJlZShidWZmZXIucG9pbnRlcik7CisKKwlpZiAoKGJhdHRlcnktPnF1aXJrcyAm
IFFVSVJLX1NJR05FRDE2X0NVUlJFTlQpICYmIGJhdHRlcnktPmN1cnJlbnRfbm93ICE9IC0x
KQorCQliYXR0ZXJ5LT5jdXJyZW50X25vdyA9IGFicygoczE2KWJhdHRlcnktPmN1cnJlbnRf
bm93KTsKKwogCXJldHVybiByZXN1bHQ7CiB9CiAKQEAgLTQ5Miw2ICs1MDEsMTQgQEAKIH0K
ICNlbmRpZgogCitzdGF0aWMgdm9pZCBhY3BpX2JhdHRlcnlfcXVpcmtzKHN0cnVjdCBhY3Bp
X2JhdHRlcnkgKmJhdHRlcnkpCit7CisJYmF0dGVyeS0+cXVpcmtzID0gMDsKKwlpZiAoZG1p
X25hbWVfaW5fdmVuZG9ycygiQWNlciIpICYmIGJhdHRlcnktPnBvd2VyX3VuaXQpIHsKKwkJ
YmF0dGVyeS0+cXVpcmtzIHw9IFFVSVJLX1NJR05FRDE2X0NVUlJFTlQ7CisJfQorfQorCiBz
dGF0aWMgaW50IGFjcGlfYmF0dGVyeV91cGRhdGUoc3RydWN0IGFjcGlfYmF0dGVyeSAqYmF0
dGVyeSkKIHsKIAlpbnQgcmVzdWx0LCBvbGRfcHJlc2VudCA9IGFjcGlfYmF0dGVyeV9wcmVz
ZW50KGJhdHRlcnkpOwpAQCAtNTEwLDYgKzUyNyw3IEBACiAJCXJlc3VsdCA9IGFjcGlfYmF0
dGVyeV9nZXRfaW5mbyhiYXR0ZXJ5KTsKIAkJaWYgKHJlc3VsdCkKIAkJCXJldHVybiByZXN1
bHQ7CisJCWFjcGlfYmF0dGVyeV9xdWlya3MoYmF0dGVyeSk7CiAJCWFjcGlfYmF0dGVyeV9p
bml0X2FsYXJtKGJhdHRlcnkpOwogCX0KICNpZmRlZiBDT05GSUdfQUNQSV9TWVNGU19QT1dF
Ugo=
--------------070100060808020906070103--
