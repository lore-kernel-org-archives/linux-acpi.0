Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793767967;
	b=lBQnKe7eR6AsVuwqXYkWsXY8fXs8a2BqAVEVVWMb2+RT+O4CklYBeLvwNgpntr0Sj9h1
	 bQZ2HY6yEJO6z6zrMxxkx+kgkHst8MfXYnCGlb93yMOqzBbAnYZwdqXiNsTzRxM+SF7ke
	 F77H9W0MhBmQh67q+XoubbJAjjwjOQvoJsi86WIvd48+fqcyJ26P2zYthXy8sEq+Mkl/i
	 ar+5Wx6PCLhqfUbZHvPB2c/1NHuXPsDuF3nzE/zGIpgGD4tslKtDb33TuNdxNUU8PpgBv
	 GOAXYzTdGKiPQAsAcOG6feieL8XC8a8Q653ZYoKLytj5qshwY2FocWYzrVIV2b/RVWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793767967;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:X-Priority:
	 X-Mailer:In-Reply-To:References:X-NTES-SC:Content-Transfer-Encoding:
	 Content-Type:MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=9s30YauoSh2f/s/qdcNGmaBQfPClCcjdMNaF5cdDkAs=;
	b=KIMnU5wSkVRoRRID3eU8hlJUnJauxYKFAMwjszgmM71j2xqDpruuhBbU0kVnTz37jahf
	 lKE/r8kN6CR0Npz04v5gu22v0evKSRig+xp3UqvJKlpbiu0wRoFU3z3T5UewFMhA9NdAk
	 UO9Ce/LjfXt/JFKP/jDTFgG974PtfK4PxP+yQD6wVumUCD7J52eKJr8uIaLB2sAv2fY5B
	 49nrt3MA6cqoZrjJQ/pVq1mfqjzIHv2oQrt4goXu0MjxvOOqetqK/UzhPzFycAsfKIr0O
	 n2uVSeQoWzdduZt+dJk8BNugMFKP7RPTYTuC3MjS6X8ScYX+NBWymSIGUWPxwR/EL8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BlJLjDoL;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B313606A31B;
	Wed,  4 Nov 2026 04:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B313606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BlJLjDoL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=9s30YauoSh2f/s/qdcNGmaBQfPClCcjdMNaF5cdDkAs=; b=B
	lJLjDoLmEplJfrB1HCGzhw/okIN4KzaMQiHdUeXaue9uj5zjqSxb2Pi4+qwpnM3+
	WGp1SH+XQpeqhqv0ahqZ3rDt7NyX+wnx8vi1sqTFArTMrE4RWGEBq6kn81LuJjhs
	xIsQy4HrCm3G1Gek4yOdx82ol6oC3X3YrKDbwddE8o=
Date: Wed, 4 Nov 2026 12:52:06 +0800 (CST)
From: zl020895  <zl020895@163.com>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: longzhao@ambarella.com, "Bartosz Golaszewski" <brgl@kernel.org>,
	linux-gpio@vger.kernel.org, "Linus Walleij" <linusw@kernel.org>,
	"Michael Walle" <mwalle@kernel.org>, "Rob Herring" <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	"Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Mika Westerberg" <westeri@kernel.org>, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v13 09/13] gpiolib: request ACPI GPIO events for
 external IRQ domains
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <aunMedCPibzJsfUi@ashevche-desk.local>
References: <20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com>
 <20261102-cv75-gpio-v13-9-4f93114ea204@ambarella.com>
 <aunMedCPibzJsfUi@ashevche-desk.local>
X-NTES-SC: AL_Qu2SAfuduEEp4CScZOkdnUoTj+Y/XMK0uvwk1YdVc/MEowHJxQIGWnRdNkvU8OC1DCKOgD2oSz9X5e9rXqZ/2JrJBen1cEeledNqWLtO5A==
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
Message-ID: <479263db.3fa7.1a1a4e66ab1.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eCgvCgC3__P2uepqcRlnAA--.574W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbC7RYBcmrqufa+SAAA3x
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjYtMTEtMDMgMTk6NTg6NDksICJBbmR5IFNoZXZjaGVua28iIDxhbmRyaXkuc2hldmNo
ZW5rb0BsaW51eC5pbnRlbC5jb20+IHdyb3RlOgo+PiArCWFjcGlfZ3Bpb2NoaXBfcmVxdWVzdF9p
bnRlcnJ1cHRzKGdjKTsKPgo+SW4gc3VjaCBhIGNhc2Ugd2hlcmUgaXMgdGhlIGZyZWVpbmcgdGhl
c2UgcmVxdWVzdGVkIGludGVycnVwdHM/CgpIaSBBbmR5LAoKZ3Bpb2NoaXBfcmVtb3ZlKCkgYWx3
YXlzIGNhbGxzIGdwaW9jaGlwX2lycWNoaXBfcmVtb3ZlKCksIHdoaWNoIGZyZWVzCnRoZSBBQ1BJ
IGV2ZW50cyBiZWZvcmUgaXQgbG9va3MgYXQgdGhlIGRvbWFpbjoKICAgIGdwaW9jaGlwX3JlbW92
ZSgpCiAgICAgIC0+IGdwaW9jaGlwX2lycWNoaXBfcmVtb3ZlKCkKICAgICAgICAgICAtPiBhY3Bp
X2dwaW9jaGlwX2ZyZWVfaW50ZXJydXB0cyhnYykKICAgICAgICAgICAtPiBpZiAoIWdjLT5pcnEu
ZG9tYWluX2lzX2FsbG9jYXRlZF9leHRlcm5hbGx5KQogICAgICAgICAgICAgICAgICBkaXNwb3Nl
IG1hcHBpbmdzIC8gcmVtb3ZlIGRvbWFpbgoKZG9tYWluX2lzX2FsbG9jYXRlZF9leHRlcm5hbGx5
IG9ubHkgc2tpcHMgdGhlIGRvbWFpbiB0ZWFyZG93bi4gVGhlCmV2ZW50cyByZXF1ZXN0ZWQgaW4g
Z3Bpb2NoaXBfaXJxY2hpcF9hZGRfZG9tYWluKCkgYXJlIHJlbGVhc2VkIG9uIHRoYXQKcGF0aC4g
UEwwNjEgZ29lcyB0aHJvdWdoIGl0IHZpYSBncGlvX3JlZ21hcF91bnJlZ2lzdGVyKCkuCgpJIHdp
bGwgZHJvcCB0aGUgZHVwbGljYXRlIENjIGZvciBNaWthIGFuZCBtb3ZlIHRoZSBDYyBsaXN0IGJl
bG93IHRoZQonLS0tJyBtYXJrZXIgaW4gdjE0LgoKQmVzdCByZWdhcmRzLApMb25nIFpoYW8K
