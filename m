Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1902A3BC69E;
	Sat, 17 Oct 2026 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792222110; cv=none; b=hbv8bk0dBf31/WLOMgvYVKUYA722cdaKT+WZEYg2LjaQfQ5Qez01hBTuzpr5GSPVC/3wl5/Ot5cWIOk258KykAP7MZQCqWahD+/sJy+zeufCLe13dMRYOmTN7wmTyC2ErteS11um9jcoRIUCMMquENGf7PkCivqeEG+FrT4QkwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792222110; c=relaxed/simple;
	bh=Kqv08JFs1GVmokdle3dKIgDyIu1HfnKQDRV0AJtUm2Q=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=lpzpM9hhkMzT79/e5b2DFw5WyTcDrOOaj3NFXU7Y5TR2MD4HxoE+TdTburkkmoppaLyBOaM7BEou9CtEdLCKSDkVP64BH0QNMV3zmhQ2EJqF0PWfeOxNQ7wvdK1r0SB12rfklgGcduxwJtohqm1+iBg92vYXPtoYILq3LOsuc3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fGDcqFNX; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fGDcqFNX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Kqv08JFs1GVmokdle3dKIgDyIu1HfnKQDRV0AJtUm2Q=; b=f
	GDcqFNXV9kH9htJmw3Q5aoYmoEDoAyDWTMR8qQsrty3wUxtOPTHQfk9onjax0HaG
	sr0ZE5EgmLwz4gpPkH5nWhuXqDh/5PDA0Mg+X7d5OuRbj0Bf2L6tqD8LMzV3lmS2
	vbaPX5Tt2SMpibeiKq6CDIw3n55sU2yLWzw/bj2yTo=
Date: Sat, 17 Oct 2026 15:28:21 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:[PATCH 1/6] ACPI: irqchip: validate MADT entry bounds before
 probing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20261016141357.2793046-2-yaojiale02@163.com>
References: <20261016141357.2793046-1-yaojiale02@163.com>
 <20261016141357.2793046-2-yaojiale02@163.com>
X-NTES-SC: AL_Qu2SAP6ZvUkr5yKdY+kdnEkQgO0/WsS1vfQu2Y5Wc+wEgCbN4z0YdHxaDHHN8e6DOSarnDiOagNHzNRcb4JHowsQ61sa6MyGk7RczZHWUQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <49c1871f.181e.1a148c2ff14.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZygvCgDnX2WVI9NqIPtaAA--.128W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRV9t2rTI5UFugAA3i
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0xMC0xNiAyMjoxMzo1MiwgIkppYWxlIFlhbyIgPHlhb2ppYWxlMDJAMTYzLmNvbT4g
d3JvdGU6Cj5JUlEgY2hpcCBwcm9iaW5nIGludm9rZXMgdmFsaWRhdGlvbiBhbmQgcHJvYmUgY2Fs
bGJhY2tzIGFmdGVyIHRoZSBjb21tb24KPnRhYmxlIHdhbGtlciBoYXMgb25seSBlc3RhYmxpc2hl
ZCB0aGF0IGEgZ2VuZXJpYyBzdWJ0YWJsZSBoZWFkZXIgaXMKPnJlYWRhYmxlLiBBIG1hbGZvcm1l
ZCBsZW5ndGggY2FuIGxlYXZlIGNhbGxiYWNrIGZpZWxkIGFjY2Vzc2VzIG91dHNpZGUKPnRoZSBN
QURULgo+Cj5WYWxpZGF0ZSB0aGUgZ2VuZXJpYyBoZWFkZXIgbGVuZ3RoIGFuZCBlbnN1cmUgdGhl
IGNvbXBsZXRlIGRlY2xhcmVkCj5lbnRyeSBpcyBjb250YWluZWQgaW4gdGhlIHRhYmxlIGJlZm9y
ZSBpbnZva2luZyBJUlEgY2hpcCBjYWxsYmFja3MuCj4KCkZpeGVzOiBlNjQ3YjUzMjI3NWIgKCJB
Q1BJOiBBZGQgZWFybHkgZGV2aWNlIHByb2JpbmcgaW5mcmFzdHJ1Y3R1cmUiKQoKPlNpZ25lZC1v
ZmYtYnk6IEppYWxlIFlhbyA8eWFvamlhbGUwMkAxNjMuY29tPgo+LS0tCj4gZHJpdmVycy9hY3Bp
L3NjYW4uYyB8IDcgKysrKysrKwo+IDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKPgo+
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9zY2FuLmMgYi9kcml2ZXJzL2FjcGkvc2Nhbi5jCj5p
bmRleCAxNjNhM2NjY2YxOTcuLmVmOGU4NDQxYjZlZiAxMDA2NDQKPi0tLSBhL2RyaXZlcnMvYWNw
aS9zY2FuLmMKPisrKyBiL2RyaXZlcnMvYWNwaS9zY2FuLmMKPkBAIC0yODg5LDYgKzI4ODksMTMg
QEAgc3RhdGljIERFRklORV9NVVRFWChhY3BpX3Byb2JlX211dGV4KTsKPiBzdGF0aWMgaW50IF9f
aW5pdCBhY3BpX21hdGNoX21hZHQodW5pb24gYWNwaV9zdWJ0YWJsZV9oZWFkZXJzICpoZWFkZXIs
Cj4gCQkJCSAgY29uc3QgdW5zaWduZWQgbG9uZyBlbmQpCj4gewo+Kwl1bnNpZ25lZCBsb25nIHN0
YXJ0ID0gKHVuc2lnbmVkIGxvbmcpaGVhZGVyOwo+Kwo+KwlpZiAoc3RhcnQgPj0gZW5kIHx8IGVu
ZCAtIHN0YXJ0IDwgc2l6ZW9mKGhlYWRlci0+Y29tbW9uKSB8fAo+KwkgICAgaGVhZGVyLT5jb21t
b24ubGVuZ3RoIDwgc2l6ZW9mKGhlYWRlci0+Y29tbW9uKSB8fAo+KwkgICAgaGVhZGVyLT5jb21t
b24ubGVuZ3RoID4gZW5kIC0gc3RhcnQpCj4rCQlyZXR1cm4gLUVJTlZBTDsKPisKPiAJaWYgKCFh
cGUtPnN1YnRhYmxlX3ZhbGlkIHx8IGFwZS0+c3VidGFibGVfdmFsaWQoJmhlYWRlci0+Y29tbW9u
LCBhcGUpKQo+IAkJaWYgKCFhcGUtPnByb2JlX3N1YnRibChoZWFkZXIsIGVuZCkpCj4gCQkJYWNw
aV9wcm9iZV9jb3VudCsrOwo+LS0gCj4yLjM0LjEK
