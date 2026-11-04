Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793768459;
	b=xa5eWsdJP8tjg7yfsQ4eLHfxx1u28qcks01V/VTls0e26qHIpy7InrgY7OPYu1oYiCkA
	 q62gHJ6xLrq7zDXNcbvCTsO6l0QqWzGB68lNOqKuoGgv8J310ilaVGxzEIjQrFoKUYO1z
	 VI4AjtIGOQiMBTZYbp2BN1QY4DXELV+oNxajmLqaBktl8vEkHwRzVTd6ri54EzsiIXsbm
	 v5TpV4pNKhggm8V90BsBQU4WOBCUywvt/dSgzZe1lGH+Rfv2P35bOhxxoA3es67rVegnt
	 J634+ufS0dSsCjI4c6FpJrO7j/r7TIdmHQgee9Q8PYV4zVV6mBvsaXGGOVBoX9H/WQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793768459;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:X-Priority:
	 X-Mailer:In-Reply-To:References:X-NTES-SC:Content-Transfer-Encoding:
	 Content-Type:MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=gGM3rtDy+TSKEQiPWemcFNlQHG908iQeBDcJyZ8Gfow=;
	b=f/dGW7zX22YrPE9RkGcPd6s+Ib9vfMbGwUzT1SUW9bbrwpSgHkV3XgBPVO+pmMPIlZJi
	 +2hIoNOmJAwdxRonhV9Z/HewBFIr9Hv7POJ74YeCCDE/rDLArWs/dS96wN4vvFEzwmdm/
	 dgHstlDn8SBckV8pt3WJPSgjPRzmK4HgbsbetY6HVMHvAk/wUKSDVmunniHtKzei5OmZf
	 YdUAzvw0qscQgix3JUWgcizwgTY76lBlKkcuHuxxA8rL2IWpFWXENk180GGnP6bWSxbYD
	 ELoOgSdfAjga1+tgPmSwbzgb2w8FYckUaGPTBXsTck1c1QBgpusTPWI61WkAkBAvRHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="K/CxIZkq";
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D3E606A31B;
	Wed,  4 Nov 2026 05:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3D3E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=K/CxIZkq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=gGM3rtDy+TSKEQiPWemcFNlQHG908iQeBDcJyZ8Gfow=; b=K
	/CxIZkqhVUVeJcYprK/gSWkCWr/nNBJKZs3yMmKtDMw+FKH02DIqtEjH6IC5tYjX
	LaPVySJWJTtnXkqepnbYlpl6Aqgz38Ng1JFIbTr/oa5MX5vtlJxnSd7suoocGb9E
	mwsjrVp9TlebKhQYlyJuC+fAd24kcF9bzCO7HVnmnw=
Date: Wed, 4 Nov 2026 13:00:19 +0800 (CST)
From: zl020895  <zl020895@163.com>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "Michael Walle" <mwalle@kernel.org>, longzhao@ambarella.com,
	"Bartosz Golaszewski" <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	"Linus Walleij" <linusw@kernel.org>, "Rob Herring" <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	"Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Mika Westerberg" <westeri@kernel.org>, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v13 08/13] gpio: regmap: remove gpiochip before
 tearing down irqchip
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <auoeysEHqGemmuhO@ashevche-desk.local>
References: <20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com>
 <20261102-cv75-gpio-v13-8-4f93114ea204@ambarella.com>
 <DMKL43ZCOSQ3.3TAJL8BRQ6ZTH@kernel.org>
 <auoeysEHqGemmuhO@ashevche-desk.local>
X-NTES-SC: AL_Qu2SAfudt0wq7yabZukdnUoTj+Y/XMK0uvwk1YdVc/MEowHJxQIGWnRdNkvU8OC1DCKOgD2oSz9X5e9rXqZ/mLKz3bznp4Mwil7U0JdC+g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <236ce5b0.4058.1a1a4edf139.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eCgvCgD33_Lju+pqRhpnAA--.564W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbC7QN87Wrqu+Ms4AAA3r
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjYtMTEtMDQgMDE6NTA6MDIsICJBbmR5IFNoZXZjaGVua28iIDxhbmRyaXkuc2hldmNo
ZW5rb0BsaW51eC5pbnRlbC5jb20+IHdyb3RlOgo+Cj5ZZWFoLCB0aGlzIGlzIHVuZm9ydHVuYXRl
LiBJIHRoaW5rIHRvIG1ha2UgaXQgd29yayBhcyBwcm9wb3NlZCB0aGUgSVJRIGRvbWFpbgo+aGFu
ZGxpbmcgaW4gR1BJT0xJQiBzaG91bGQgYmUgcmV2aXNpdGVkLiBTbywgYXQgbGVhc3QgYSBnb29k
IGNvbW1lbnQgaXMgYSBtdXN0LAo+aW5kZWVkLgo+CqGtCj4+IFRoaXMgc2hvdWxkIGJlIHNwbGl0
IGludG8gYSBzZXBlcmF0ZSBwYXRjaCB3aXRoIGEgRml4ZXM6IHRhZy4KPgo+Tm90IHN1cmUgaWYg
d2UgbmVlZCBhIHNlcGFyYXRlIGNoYW5nZSBoZXJlIGFzIHR3byBhcmUgY291cGxlZC4KPkkgbGVh
dmUgaXQgdG8gQmFydCB0byBkZWNpZGUuCgpIaSBBbmR5LCBNaWNoYWVsLAoKRm9sbG93aW5nIE1p
Y2hhZWwncyBzdWdnZXN0aW9uLCBJIGFscmVhZHkgc2VudCB0aGUgcmVnaXN0cmF0aW9uIGVycm9y
LXBhdGgKbGVhayBhcyBhIHNlcGFyYXRlIHBhdGNoIHdpdGggYSBGaXhlczogdGFnIHllc3RlcmRh
eToKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYxMTAzLWdwaW8tcmVnbWFwLWlycWNo
aXAtbGVhay12MS0xLWQwMzhhMjA4NDBmN0BhbWJhcmVsbGEuY29tLwoKVGhlIHVucmVnaXN0ZXIt
b3JkZXIgY2hhbmdlIHN0YXlzIGluIHRoZSBzZXJpZXMsIGFuZCBJIHdpbGwgYWRkIGEgY29kZQpj
b21tZW50IGZvciB0aGF0IGRldmlhdGlvbiBpbiB2MTQuCgpCZXN0IHJlZ2FyZHMsCkxvbmcgWmhh
bw==
