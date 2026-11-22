Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795335071;
	b=Ir9mEl7rieF0m5Ex3Qq5e0YNzvsS+xYwTuod9SDqiy62K3RTu7MuOuTTe0y1H/H0BlkJ
	 SL7VGryuwfMYBs1BrvBxrgXm/vQCOHaiccLRLuo8xdwyy1p0f1SNpeU7x9pH5GR9l/CFr
	 /7AhJRlb8GtMWFm7YNP3wBP+Aism0LBHmjGbQV6LWQ2SzHKqlt8rt9VO5F9tGQKugAfnS
	 jE6grF3lftV/SaBVWKR23yUP0cZGSlgJ1tBEffl3ZOStvve0q4gzl6NXnUAUhv6ZLhyLS
	 nkvX1V3IcUhozLwn2pT69fbA8hzAIbzVITuFds9Gfju7JcUsG9NKyPIjJnYTWs9Nhjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795335071;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-MBO-RS-ID:X-MBO-RS-META;
	bh=OXQIPCAy+eaQ5fg1Vwh7mv8zcCQEMw6r0Y6CCqTMlSs=;
	b=rVBWVnVLmbLvJGiiIyivjBDsHgyGh4NzVCVAySEnqffhnLsQGLUusXR1tvW2rYkYda/V
	 89d9HDPk49pasX5qzgCqZS2K0xbNjFsnwREZ8gxIjvK06Jbgt2Kt8ZApyidBxeKDWHnjK
	 ux9vaiyA/CB2jKAj8Lzqlqq6fCazuOpMph25er/EPVhoahXv9Yr/kuLHmeJQUuJzakPsW
	 EkvFPtiXZZ6P6Hc1NwMWqpY/WZ0P9jY1TImxEV3TZdaG/qj7kD8mxKUSQ4qA+6xuHW0Ye
	 G27J4MfbTMBOc0s8TOnMkimwwqO1dYwkr11K2XmDF/s4CX/OAM7ChH2MImIG1CqDuKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=RdtjCIh2;
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A623606A32A;
	Sun, 22 Nov 2026 08:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A623606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=RdtjCIh2
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jXMGM1gV6zMlLB;
	Sun, 22 Nov 2026 09:11:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795335067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXQIPCAy+eaQ5fg1Vwh7mv8zcCQEMw6r0Y6CCqTMlSs=;
	b=RdtjCIh2Z9yb6x02bW5dMmERxcrf3gd7kRu63m9W0E+/dc+bZqv7jSA7Vfo+SbQlsVp67Z
	IpQf5fBw46626aKIs9NdH0/YAjWsjhYUQfk4jqSFWoOk8oYTjODAMMOZMMboq77Relxml0
	D87xfowWNWecZcIhh6e6HZgQWLM5Q6cHNvYH4qljMF53Bhmg4YiqYsNlXqTMtPcpRoy9n2
	LMhtEKdAe4lf4Ea9jLHlW/a2D5tFaLchk142bgUMQiS8j/T24bgcbZ285AHOb4s015BUme
	JPyogPOl/zCuK3EVdEHglPsfn0KwJ3Z9ec7P987EaT6owHKkF3IBwWZataF/aA==
Message-ID: <67e8543e875b8bf6f7f02d69274f9be8e23cc2ec.camel@mailbox.org>
Subject: Re: [PATCH] ACPI: docs: Fix brackets
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sun, 22 Nov 2026 09:11:04 +0100
In-Reply-To: <20260903160846.734870-2-manuelebnerli@mailbox.org>
References: <20260903160846.734870-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45) 
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MBO-RS-ID: 81eaf0a109a6c61fb71
X-MBO-RS-META: 71r9hrbjseqw9pmq4byawskwswmba85y

T24gVGh1LCAyMDI2LTA5LTAzIGF0IDE4OjA4ICswMjAwLCBNYW51ZWwgRWJuZXIgd3JvdGU6Cj4g
QWRkIG1pc3NpbmcgJyknIHRvIGZ1bmN0aW9ucy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBNYW51ZWwg
RWJuZXIgPG1hbnVlbGVibmVybGlAbWFpbGJveC5vcmc+CgpDYW4gSSBkbyBhbnl0aGluZyB0byBn
ZXQgdGhpcyBhcHBsaWVkPwoKVGhhbmtzCiBNYW51ZWwKCj4gLS0tCj4gwqBEb2N1bWVudGF0aW9u
L2Zpcm13YXJlLWd1aWRlL2FjcGkvZW51bWVyYXRpb24ucnN0IHwgMiArLQo+IMKgRG9jdW1lbnRh
dGlvbi9maXJtd2FyZS1ndWlkZS9hY3BpL2kyYy1tdXhlcy5yc3TCoMKgIHwgMiArLQo+IMKgMiBm
aWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZmlybXdhcmUtZ3VpZGUvYWNwaS9lbnVtZXJhdGlvbi5yc3Qg
Yi9Eb2N1bWVudGF0aW9uL2Zpcm13YXJlLWd1aWRlL2FjcGkvZW51bWVyYXRpb24ucnN0Cj4gaW5k
ZXggMTY4YzQzMDEyLi5kYTdjYzg1MjggMTAwNjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9maXJt
d2FyZS1ndWlkZS9hY3BpL2VudW1lcmF0aW9uLnJzdAo+ICsrKyBiL0RvY3VtZW50YXRpb24vZmly
bXdhcmUtZ3VpZGUvYWNwaS9lbnVtZXJhdGlvbi5yc3QKPiBAQCAtMzc0LDcgKzM3NCw3IEBAIEZv
ciBleGFtcGxlOjoKPiDCoAl7Cj4gwqAJCU1ldGhvZCAoX0NSUywgMCwgTm90U2VyaWFsaXplZCkK
PiDCoAkJewo+IC0JCQlOYW1lIChTQlVGLCBSZXNvdXJjZVRlbXBsYXRlKCkKPiArCQkJTmFtZSAo
U0JVRiwgUmVzb3VyY2VUZW1wbGF0ZSgpKQo+IMKgCQkJewo+IMKgCQkJCS8vIFVzZWQgdG8gcG93
ZXIgb24vb2ZmIHRoZSBkZXZpY2UKPiDCoAkJCQlHcGlvSW8gKEV4Y2x1c2l2ZSwgUHVsbE5vbmUs
IDAsIDAsIElvUmVzdHJpY3Rpb25PdXRwdXRPbmx5LAo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2Zpcm13YXJlLWd1aWRlL2FjcGkvaTJjLW11eGVzLnJzdCBiL0RvY3VtZW50YXRpb24vZmly
bXdhcmUtZ3VpZGUvYWNwaS9pMmMtbXV4ZXMucnN0Cj4gaW5kZXggOTZlZjQwMTJkLi5kNGNlOTBk
MDAgMTAwNjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9maXJtd2FyZS1ndWlkZS9hY3BpL2kyYy1t
dXhlcy5yc3QKPiArKysgYi9Eb2N1bWVudGF0aW9uL2Zpcm13YXJlLWd1aWRlL2FjcGkvaTJjLW11
eGVzLnJzdAo+IEBAIC0zNSw3ICszNSw3IEBAIHdoaWNoIGNvcnJlc3BvbmRzIHRvIHRoZSBmb2xs
b3dpbmcgQVNMIChpbiB0aGUgc2NvcGUgb2YgXF9TQik6Ogo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIERldmljZSAoQ0xJQSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOYW1lIChf
SElELCAuLi4pCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5hbWUg
KF9DUlMsIFJlc291cmNlVGVtcGxhdGUgKCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBOYW1lIChfQ1JTLCBSZXNvdXJjZVRlbXBsYXRlICgpKSB7Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEkyY1NlcmlhbEJ1cyAo
MHg1MCwgQ29udHJvbGxlckluaXRpYXRlZCwgSTJDX1NQRUVELAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBB
ZGRyZXNzaW5nTW9kZTdCaXQsICJcXF9TQi5TTUIxLk1VWDAuQ0gwMCIsCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDB4MDAsIFJlc291cmNlQ29uc3VtZXIsLCkK

