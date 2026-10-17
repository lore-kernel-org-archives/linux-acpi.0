Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F2438DC44;
	Sat, 17 Oct 2026 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792222076; cv=none; b=C/G+08sGPwaPh9dHTZ6y5Ln4z6A1H2Gs2fWkm4RMdvFQlkiTU7h68tu6fb53Lml4WQy1q7qxCRgAO4Vt5NZrumpnf77Z98N+oudqfjzAJ22ADb5DBWIMrrnolmbzi7ifHphOrYKRtOF8TwFJQYWdgOm570eVO7TMT/jF6dBzYpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792222076; c=relaxed/simple;
	bh=uag8eDuXNCghqFea+HDD/P9mLBrRtHxF/aw/3zF84HE=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=sKsvFbdZ8wb4p5jr80Bcc9jKjYUzgCcrqDKhfe96Dq3WfF5haKbdYv9b3HI2spr7nDQO9tXOiu9RU7wiBYdVULyDrLSUUMGYxlhuuBlGTD2fsIj4Hmzrfn88e170BB6s7pSyJT63BZFalyJiLKh2mw74F5+K9sgzP1zuJTLVycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G0v2yNz0; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G0v2yNz0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=uag8eDuXNCghqFea+HDD/P9mLBrRtHxF/aw/3zF84HE=; b=G
	0v2yNz0NcKBucBC6zPvgGDAj9irdzxtOpBVLS64PyIDkcTaDyRtDfb6h9ikm9IZ5
	rI3cWVLGvb3VPXDjA1y3KHuD6IrqWoT0DomqD2X0SdQetsG1JEGnyipLrEroD4td
	8YYHyz9HoTX1O52tjoMFyVwkKpd/vwVwCtoVavEXzg=
Date: Sat, 17 Oct 2026 15:27:17 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Sunil V L" <sunilvl@ventanamicro.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>, "Paul Walmsley" <pjw@kernel.org>,
	"Palmer Dabbelt" <palmer@dabbelt.com>,
	"Albert Ou" <aou@eecs.berkeley.edu>,
	"Alexandre Ghiti" <alex@ghiti.fr>, linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:[PATCH 2/2] ACPI: riscv: validate interrupt controller MADT
 entries
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20261016141249.2791819-3-yaojiale02@163.com>
References: <20261016141249.2791819-1-yaojiale02@163.com>
 <20261016141249.2791819-3-yaojiale02@163.com>
X-NTES-SC: AL_Qu2SAP6ZvUgo4SmdbekdnEkQgO0/WsS1vfQu2Y5Wc+wEgCbN4z0YdHxaDHHN8e6DOSarnDiOagNHzNRcb4JH72PtZul3jkFAPXl2Mno+hw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4c6df8ce.1812.1a148c207d4.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZygvCgDnL7VWI9NqDPtaAA--.151W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRZtp2rTI1YCZgAA35
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0xMC0xNiAyMjoxMjo0OCwgIkppYWxlIFlhbyIgPHlhb2ppYWxlMDJAMTYzLmNvbT4g
d3JvdGU6Cj5UaGUgUExJQyBhbmQgQVBMSUMgTUFEVCBjYWxsYmFja3MgY2FzdCBnZW5lcmljIHN1
YnRhYmxlIGhlYWRlcnMgdG8KPmZpeGVkLXNpemUgcmVjb3JkcyBiZWZvcmUgY2hlY2tpbmcgdGhh
dCB0aGUgY29tcGxldGUgcmVjb3JkcyBhcmUKPnByZXNlbnQuIFRydW5jYXRlZCBmaXJtd2FyZSBl
bnRyaWVzIGNhbiB0aGVyZWZvcmUgY2F1c2Ugb3V0LW9mLWJvdW5kcwo+ZmllbGQgcmVhZHMuCj4K
PlJlamVjdCBlbnRyaWVzIHRoYXQgZG8gbm90IGNvbnRhaW4gdGhlIGNvbXBsZXRlIGNvbnRyb2xs
ZXItc3BlY2lmaWMKPnN0cnVjdHVyZSBiZWZvcmUgcmVnaXN0ZXJpbmcgYW4gaW50ZXJydXB0IGNv
bnRyb2xsZXIuCj4KCkZpeGVzOiBlNzdiOGRjMDJhMWMgKCJBQ1BJOiBSSVNDLVY6IEluaXRpYWxp
emUgR1NJIG1hcHBpbmcgc3RydWN0dXJlcyIpCgo+U2lnbmVkLW9mZi1ieTogSmlhbGUgWWFvIDx5
YW9qaWFsZTAyQDE2My5jb20+Cj4tLS0KPiBkcml2ZXJzL2FjcGkvcmlzY3YvaXJxLmMgfCA2ICsr
KysrKwo+IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPgo+ZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvYWNwaS9yaXNjdi9pcnEuYyBiL2RyaXZlcnMvYWNwaS9yaXNjdi9pcnEuYwo+aW5kZXgg
ZGEyYzQyZTBlYmZkLi4xZjZmZWU1YzU3NDYgMTAwNjQ0Cj4tLS0gYS9kcml2ZXJzL2FjcGkvcmlz
Y3YvaXJxLmMKPisrKyBiL2RyaXZlcnMvYWNwaS9yaXNjdi9pcnEuYwo+QEAgLTIyMCw2ICsyMjAs
OSBAQCBzdGF0aWMgaW50IF9faW5pdCByaXNjdl9hY3BpX2FwbGljX3BhcnNlX21hZHQodW5pb24g
YWNwaV9zdWJ0YWJsZV9oZWFkZXJzICpoZWFkZQo+IHsKPiAJc3RydWN0IGFjcGlfbWFkdF9hcGxp
YyAqYXBsaWMgPSAoc3RydWN0IGFjcGlfbWFkdF9hcGxpYyAqKWhlYWRlcjsKPiAKPisJaWYgKEJB
RF9NQURUX0VOVFJZKGFwbGljLCBlbmQpKQo+KwkJcmV0dXJuIC1FSU5WQUw7Cj4rCj4gCXJldHVy
biByaXNjdl9hY3BpX3JlZ2lzdGVyX2V4dF9pbnRjKGFwbGljLT5nc2lfYmFzZSwgYXBsaWMtPm51
bV9zb3VyY2VzLCBhcGxpYy0+bnVtX2lkY3MsCj4gCQkJCQkgICAgYXBsaWMtPmlkLCBBQ1BJX1JJ
U0NWX0lSUUNISVBfQVBMSUMpOwo+IH0KPkBAIC0yMjksNiArMjMyLDkgQEAgc3RhdGljIGludCBf
X2luaXQgcmlzY3ZfYWNwaV9wbGljX3BhcnNlX21hZHQodW5pb24gYWNwaV9zdWJ0YWJsZV9oZWFk
ZXJzICpoZWFkZXIKPiB7Cj4gCXN0cnVjdCBhY3BpX21hZHRfcGxpYyAqcGxpYyA9IChzdHJ1Y3Qg
YWNwaV9tYWR0X3BsaWMgKiloZWFkZXI7Cj4gCj4rCWlmIChCQURfTUFEVF9FTlRSWShwbGljLCBl
bmQpKQo+KwkJcmV0dXJuIC1FSU5WQUw7Cj4rCj4gCXJldHVybiByaXNjdl9hY3BpX3JlZ2lzdGVy
X2V4dF9pbnRjKHBsaWMtPmdzaV9iYXNlLCBwbGljLT5udW1faXJxcywgMCwKPiAJCQkJCSAgICBw
bGljLT5pZCwgQUNQSV9SSVNDVl9JUlFDSElQX1BMSUMpOwo+IH0KPi0tIAo+Mi4zNC4xCg==
