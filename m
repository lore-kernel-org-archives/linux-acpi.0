Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26A63F0750
	for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182377; cv=none; b=lhDZBfptoPdCSVYq0ryEs1wrn6s5DTyQAPgSuyJ3+6Obaope0Lg8kNmVMuQfSqqfKlOIZY2grmfFgU9/kNIVMH3iquTa3mFO7KGLE8pYSSPmnUEsETFGv/M3VELEhEq+Da5ZX+/hvMv9VP3SmU+fDd/x3mgqFZWVMzHRGqe01ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182377; c=relaxed/simple;
	bh=lteANmjksdqMpweUgEVkmD0vjKi/08ZCKd+YoDhaYV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B7nAClWQ8gYNuYXSBkftks9IHPJ4tKEfWICmTJ6kpSA5evmOcXpRgfV3MA3jDseG6aBcV4CzOiJWSa/mvA93DPg61Rp3jzABTJ5b5XlMqAWSlHVrGtba+bnCerO68SzlwdUfanpUkKjPL1TjF12LS/6vorVdTsmq+o/EjTo4MwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1779182364-1eb14e680c64ac0001-I98ny2
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id L5Y5F5wkhmxbezSh; Tue, 19 May 2026 17:19:24 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
X-ASG-Whitelist: Client
X-Append-Disclaimer: 1
Received: from tony.zhaoxin.com (tony.zhaoxin.com [10.32.64.22])
	by zhaoxin.com (8.30) with ESMTP2c850d53ad83a579cfe6097fe4675070
	Tue, 19 May 2026 17:19:22 +0800
X-Eyou-Smtpauth: tonywwangoc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.32.64.22
X-Eyou-EnvelopeSender: TonyWWang-oc@zhaoxin.com
X-Eyou-From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
From: =?UTF-8?B?VG9ueSBXIFdhbmctb2M=?=
 <TonyWWang-oc@zhaoxin.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: CobeChen@zhaoxin.com,
	LindaChai@zhaoxin.com
Subject: [PATCH] ACPI: processor: Add cpuidle driver check in acpi_processor_register_idle_driver
Date: Tue, 19 May 2026 17:19:22 +0800
X-ASG-Orig-Subj: [PATCH] ACPI: processor: Add cpuidle driver check in acpi_processor_register_idle_driver
Message-Id: <20260519091922.42500-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Eyou-Sender: <tonywwang-oc@zhaoxin.com>
X-Barracuda-Connect: zxmail.zhaoxin.com[10.28.208.166]
X-Barracuda-Start-Time: 1779182364
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1587
X-Barracuda-BRTS-Status: 1

Q29tbWl0IDdhOGM5OTRjYmIyZCAoIkFDUEk6IHByb2Nlc3NvcjogaWRsZTogT3B0aW1p
emUgQUNQSSBpZGxlZHJpdmVyIHJlZ2lzdHJhdGlvbiIpIG1vdmVkIHRoZSBBQ1BJIGlk
bGUgZHJpdmVyIHJlZ2lzdHJhdGlvbiB0b2FjcGlfcHJvY2Vzc29yX2RyaXZlcl9pbml0
KCksIGJ1dCBpdCBkaWRuJ3QgY2hlY2sgd2hldGhlciBhIGNwdWlkbGVkcml2ZXIgd2Fz
IGFscmVhZHkgcmVnaXN0ZXJlZC5Gb3IgZXhhbXBsZSwgb24gSW50ZWwgcGxhdGZvcm1z
LCBpZiB0aGUgaW50ZWxfaWRsZSBkcml2ZXIgaXMgYWxyZWFkeWxvYWRlZCwgdGhlIGNv
ZGUgd291bGQgc3RpbGwgZXZhbHVhdGUgdGhlIF9DU1Qgb2JqZWN0IGluIHRoZSBBQ1BJ
dGFibGUgYW5kIGF0dGVtcHQgdG8gcmVnaXN0ZXIgdGhlIGFjcGlfaWRsZSBkcml2ZXIu
IFRoaXMgcmVnaXN0cmF0aW9ud291bGQgZmFpbCB3aXRoIC1FQlVTWSBkdWUgdG8gdGhl
IGV4aXN0aW5nIGNoZWNrIGluIGNwdWlkbGVfcmVnaXN0ZXJfZHJpdmVyLkFkZCBhIGNo
ZWNrIGF0IHRoZSBiZWdpbm5pbmcgb2YgYWNwaV9wcm9jZXNzb3JfcmVnaXN0ZXJfaWRs
ZV9kcml2ZXIoKXRvIGF2b2lkIHVubmVjZXNzYXJ5IF9DU1QgZXZhbHVhdGUgYW5kIHBv
dGVudGlhbCByZWdpc3RyYXRpb24gZmFpbHVyZXMuLS0tIGRyaXZlcnMvYWNwaS9wcm9j
ZXNzb3JfaWRsZS5jIHwgNSArKysrKyAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfaWRsZS5jIGIvZHJp
dmVycy9hY3BpL3Byb2Nlc3Nvcl9pZGxlLmNpbmRleCBlZTVmYWNjY2JlMTAuLjA0MDk0
MTFhYmI4MyAxMDA2NDQtLS0gYS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYysr
KyBiL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfaWRsZS5jQEAgLTEzNTUsNiArMTM1NSwx
MSBAQCB2b2lkIGFjcGlfcHJvY2Vzc29yX3JlZ2lzdGVyX2lkbGVfZHJpdmVyKHZvaWQp
IAlpbnQgcmV0ID0gLUVOT0RFVjsgCWludCBjcHU7ICsJaWYgKGNwdWlkbGVfZ2V0X2Ry
aXZlcigpKSB7KwkJcHJfZGVidWcoImNwdWlkbGUgZHJpdmVyICVwUyBhbHJlYWR5IHJl
Z2lzdGVyZWQuXG4iLCBjcHVpZGxlX2dldF9kcml2ZXIoKSk7KwkJcmV0dXJuOysJfSsg
CWFjcGlfcHJvY2Vzc29yX3VwZGF0ZV9tYXhfY3N0YXRlKCk7ICAJLyotLSAyLjI1LjEK
CgoKCuS/neWvhuWjsOaYjgrmnKzpgq7ku7blkKvmnInkv53lr4bmiJbkuJPmnInkv6Hm
ga/vvIzku4XkvpvmjIflrprmlLbku7bkurrkvb/nlKjjgILkuKXnpoHlr7nmnKzpgq7k
u7bmiJblhbblhoXlrrnlgZrku7vkvZXmnKrnu4/mjojmnYPnmoTmn6XpmIXjgIHkvb/n
lKjjgIHlpI3liLbmiJbovazlj5HjgIIKClRoaXMgZW1haWwgY29udGFpbnMgY29uZmlk
ZW50aWFsIG9yIGxlZ2FsbHkgcHJpdmlsZWdlZCBpbmZvcm1hdGlvbiBhbmQgaXMgZm9y
IHRoZSBzb2xlIHVzZSBvZiBpdHMgaW50ZW5kZWQgcmVjaXBpZW50LiBBbnkgdW5hdXRo
b3JpemVkIHJldmlldywgdXNlLCBjb3B5aW5nIG9yIGZvcndhcmRpbmcgb2YgdGhpcyBl
bWFpbCBvciB0aGUgY29udGVudCBvZiB0aGlzIGVtYWlsIGlzIHN0cmljdGx5IHByb2hp
Yml0ZWQu

