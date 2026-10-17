Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C3841F7ED;
	Sat, 17 Oct 2026 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792222592; cv=none; b=pS9mxQOV4WpFHEnLSLcEg+uEQo43+i9Sjon4+ToTsKBPMs4mjwvuiz03Fiv71W5LDgGIno7lPKZeJOCkUPt5l2zyFolt+aJVq4g6FBX1CmjQF72OfuNJdqq6K1LDKg46bc0+WPWFf03kV+U4WGTCpwAV+nNrDNJZeiFaTztLw5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792222592; c=relaxed/simple;
	bh=qIBu0lLZgIyJwYum+m70QrpK7JQ8hY8pBScYT3WP7o8=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=XkiZo+HTc2nn1eyraRrKSGjZyD7dK0Cg/AqAMgxVYLVXYlfQRSUzdRbKo50wQaF17d1ivXaly/HSGpzuEo5Kj0UoPwKW6Apf4u42jwZs3qX1pR0kojsCZSnkATeBRYsGXAjAneqegbG3m7d9D89Z8tbQL3JQ4s9v9dGCHPvM+bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F0CkPqUM; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F0CkPqUM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=qIBu0lLZgIyJwYum+m70QrpK7JQ8hY8pBScYT3WP7o8=; b=F
	0CkPqUMq91qq7GzBIrU6h+ppJ6hCgWUEjo2hcp12kLSCbtK/jFYi3ZhP4QH3qePr
	g7Jfc/1ANCWQ3SNEEA7agepNGuFL+DuMQVipPMEWnucsRIEUUGueLSEyQQBRZ0Gi
	9fiC3E7xqqUP16wkTSXAGQORYkPZNNxIs0yIemt1Qc=
Date: Sat, 17 Oct 2026 15:35:58 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Andrew Morton" <akpm@linux-foundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re:[PATCH] lib/firmware_table: validate subtable bounds
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20261016144154.2818962-1-yaojiale02@163.com>
References: <20261016144154.2818962-1-yaojiale02@163.com>
X-NTES-SC: AL_Qu2SAP6ZvU0u7iCbY+kdnEkQgO0/WsS1vfQu2Y5Wc+wEgCbN4z0YdHxaDHHN8e6DOSarnDiOagNHzNRcb4JHKfYfXorfoK9hJKwKQdp63w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <49fd03ca.189c.1a148c9f760.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZygvCgD3P19eJdNq0PtaAA--.139W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzR7vKmrTJV4fdQAA3+
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0xMC0xNiAyMjo0MTo1NCwgIkppYWxlIFlhbyIgPHlhb2ppYWxlMDJAMTYzLmNvbT4g
d3JvdGU6Cj5UaGUgZ2VuZXJpYyBmaXJtd2FyZSB0YWJsZSB3YWxrZXIgZGlzcGF0Y2hlcyBtYXRj
aGluZyBlbnRyaWVzIGFmdGVyIG9ubHkKPmNoZWNraW5nIHRoYXQgYSBnZW5lcmljIHN1YnRhYmxl
IGhlYWRlciBpcyBwcmVzZW50LiBBIHJlY29yZCB3aG9zZQo+ZGVjbGFyZWQgbGVuZ3RoIGlzIHNo
b3J0ZXIgdGhhbiBpdHMgaGVhZGVyIG9yIGV4dGVuZHMgcGFzdCB0aGUgdGFibGUgY2FuCj50aGVy
ZWZvcmUgcmVhY2ggYSBoYW5kbGVyIGJlZm9yZSBpdHMgYm91bmRzIGhhdmUgYmVlbiBlc3RhYmxp
c2hlZC4KPgo+VmFsaWRhdGUgdGhlIGNvbXBsZXRlIGdlbmVyaWMgaGVhZGVyIGFuZCB0aGUgZGVj
bGFyZWQgcmVjb3JkIHJhbmdlCj5iZWZvcmUgbG9va2luZyB1cCBvciBpbnZva2luZyBhIGhhbmRs
ZXIuIFRoaXMgYWxzbyByZWplY3RzIHplcm8tbGVuZ3RoCj5yZWNvcmRzIGFuZCBwcmV2ZW50cyBt
YWxmb3JtZWQgbGVuZ3RocyBmcm9tIGFkdmFuY2luZyB0aGUgY3Vyc29yIG91dHNpZGUKPnRoZSB0
YWJsZS4KPgoKRml4ZXM6IDYwNTc0ZDFlMDViMCAoImFjcGk6IENyZWF0ZSBzdWJ0YWJsZSBwYXJz
aW5nIGluZnJhc3RydWN0dXJlIikKCj5TaWduZWQtb2ZmLWJ5OiBKaWFsZSBZYW8gPHlhb2ppYWxl
MDJAMTYzLmNvbT4KPi0tLQo+IGxpYi9md190YWJsZS5jIHwgMjUgKysrKysrKysrKysrKystLS0t
LS0tLS0tLQo+IDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMo
LSkKPgo+ZGlmZiAtLWdpdCBhL2xpYi9md190YWJsZS5jIGIvbGliL2Z3X3RhYmxlLmMKPmluZGV4
IDE2MjkxODE0NDUwZS4uODRjMjUxNWVkZGU3IDEwMDY0NAo+LS0tIGEvbGliL2Z3X3RhYmxlLmMK
PisrKyBiL2xpYi9md190YWJsZS5jCj5AQCAtMTcyLDcgKzE3MiwyMCBAQCBhY3BpX3BhcnNlX2Vu
dHJpZXNfYXJyYXkoY2hhciAqaWQsIHVuc2lnbmVkIGxvbmcgdGFibGVfc2l6ZSwKPiAJICAgICgo
dW5zaWduZWQgbG9uZyl0YWJsZV9oZWFkZXIgKyB0YWJsZV9zaXplKTsKPiAJc3VidGFibGVfbGVu
ID0gYWNwaV9nZXRfc3VidGFibGVfaGVhZGVyX2xlbmd0aCgmZW50cnkpOwo+IAo+LQl3aGlsZSAo
KCh1bnNpZ25lZCBsb25nKWVudHJ5LmhkcikgKyBzdWJ0YWJsZV9sZW4gPCB0YWJsZV9lbmQpIHsK
PisJd2hpbGUgKCh1bnNpZ25lZCBsb25nKWVudHJ5LmhkciA8IHRhYmxlX2VuZCkgewo+KwkJaWYg
KHRhYmxlX2VuZCAtICh1bnNpZ25lZCBsb25nKWVudHJ5LmhkciA8IHN1YnRhYmxlX2xlbikgewo+
KwkJCXByX2VycigiWyU0LjRzXSBJbnZhbGlkIHN1YnRhYmxlIGhlYWRlclxuIiwgaWQpOwo+KwkJ
CXJldHVybiAtRUlOVkFMOwo+KwkJfQo+Kwo+KwkJZW50cnlfbGVuID0gYWNwaV9nZXRfZW50cnlf
bGVuZ3RoKCZlbnRyeSk7Cj4rCQlpZiAoZW50cnlfbGVuIDwgc3VidGFibGVfbGVuIHx8Cj4rCQkg
ICAgZW50cnlfbGVuID4gdGFibGVfZW5kIC0gKHVuc2lnbmVkIGxvbmcpZW50cnkuaGRyKSB7Cj4r
CQkJcHJfZXJyKCJbJTQuNHM6MHglMDJseF0gSW52YWxpZCBsZW5ndGggJWx1XG4iLCBpZCwKPisJ
CQkgICAgICAgYWNwaV9nZXRfZW50cnlfdHlwZSgmZW50cnkpLCBlbnRyeV9sZW4pOwo+KwkJCXJl
dHVybiAtRUlOVkFMOwo+KwkJfQo+Kwo+IAkJZm9yIChpID0gMDsgaSA8IHByb2NfbnVtOyBpKysp
IHsKPiAJCQlpZiAoYWNwaV9nZXRfZW50cnlfdHlwZSgmZW50cnkpICE9IHByb2NbaV0uaWQpCj4g
CQkJCWNvbnRpbnVlOwo+QEAgLTE4NiwxNiArMTk5LDYgQEAgYWNwaV9wYXJzZV9lbnRyaWVzX2Fy
cmF5KGNoYXIgKmlkLCB1bnNpZ25lZCBsb25nIHRhYmxlX3NpemUsCj4gCQkJYnJlYWs7Cj4gCQl9
Cj4gCj4tCQkvKgo+LQkJICogSWYgZW50cnktPmxlbmd0aCBpcyAwLCBicmVhayBmcm9tIHRoaXMg
bG9vcCB0byBhdm9pZAo+LQkJICogaW5maW5pdGUgbG9vcC4KPi0JCSAqLwo+LQkJZW50cnlfbGVu
ID0gYWNwaV9nZXRfZW50cnlfbGVuZ3RoKCZlbnRyeSk7Cj4tCQlpZiAoZW50cnlfbGVuID09IDAp
IHsKPi0JCQlwcl9lcnIoIlslNC40czoweCUwMnhdIEludmFsaWQgemVybyBsZW5ndGhcbiIsIGlk
LCBwcm9jLT5pZCk7Cj4tCQkJcmV0dXJuIC1FSU5WQUw7Cj4tCQl9Cj4tCj4gCQllbnRyeS5oZHIg
PSAodW5pb24gYWNwaV9zdWJ0YWJsZV9oZWFkZXJzICopCj4gCQkgICAgKCh1bnNpZ25lZCBsb25n
KWVudHJ5LmhkciArIGVudHJ5X2xlbik7Cj4gCX0KPi0tIAo+Mi4zNC4xCg==
