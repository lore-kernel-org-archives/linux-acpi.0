Received: from mails.wedevs.org (mails.wedevs.org [107.172.252.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29FC33A70A
	for <linux-acpi@vger.kernel.org>; Sun, 26 Jul 2026 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.252.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785099417; cv=none; b=eC9NxWRupyxpl9AkGPCgRB1QX44yzkv7iUEk884Yb4E16liHwJp0fAchz7Yz/dTrzK4T3f6dILANR3Ni6XLjOUWjOzVcayYautPaXR5SY9XMNK4I/LXQOaCEPxXD03wO0/rzs9Ceq86sgShqwr24S705e1mzjMdQB83g43GdfK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785099417; c=relaxed/simple;
	bh=Nb1KN+ksmm8uBKM3h+ZxakFD6eWvdhbw2rkBPn/6QNg=;
	h=Content-Type:MIME-Version:From:To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=IAm+SkULXiI9W8qa+TJNPrYFj0nkLvePDm/TK9pZFOb9DPA/SaTb1EGzQiPkV10WKaFZCAFFoQOXccAlYpsiaopLExzwa2oi4Cqu0eSy3V4RC1nVH9uY3mwWXG577wvSrdnGqO0E46+5Gv5UJeeE78gTeKRihpQJQsOiRIUsXFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mails.wedevs.org; spf=pass smtp.mailfrom=mails.wedevs.org; dkim=pass (2048-bit key) header.d=mails.wedevs.org header.i=@mails.wedevs.org header.b=Our/BW76; dkim=permerror (0-bit key) header.d=mails.wedevs.org header.i=@mails.wedevs.org header.b=olRorSg0; arc=none smtp.client-ip=107.172.252.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mails.wedevs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.wedevs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mails.wedevs.org header.i=@mails.wedevs.org header.b="Our/BW76";
	dkim=permerror (0-bit key) header.d=mails.wedevs.org header.i=@mails.wedevs.org header.b="olRorSg0"
DKIM-Signature: v=1; a=rsa-sha256; s=202601r; d=mails.wedevs.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1785099415; bh=Nb1KN+ksmm8uBKM3h+ZxakF
	D6eWvdhbw2rkBPn/6QNg=; b=Our/BW76xwwlYVloe0kgc6ZrZntOZaOLDM9GTvz3k+P98rfDl8
	lgdgPxLDxhM3YGF0DME6Vo9llXUtd3sPZcrxVyvzZ0BGKzCD7aCu4SrcKp7aXOrI1VO9cdhaD8m
	a4f7A8e64mTxXWrOmKkfm9yWtc3iPDJbW6+Ozg6AUZo4KeemkO9yTPwlekyAgkqqdF0Z3owHNfI
	a+pBTl26GnemOpejJCQUNGeSFN8P/ZfYLFpPICyA+fCd7UXzvFy/47FoVcUSynN/0uWVW4/c64o
	mTi0BvZMXcbuo3OeMrqtJqQcPfoZubFiwIPlBdu3DtHI6YbCOMeV5LxAGKPP0USkQ3A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202601e; d=mails.wedevs.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1785099415; bh=Nb1KN+ksmm8uBKM3h+ZxakF
	D6eWvdhbw2rkBPn/6QNg=; b=olRorSg0mip1wjHA8SKRTFduA7/OFNtUsBV/OVxhjFBmRzL5fm
	3HrYeOKLm77iq+EdUDeFXqzOKrdSu51uxRAw==;
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Bug Report <bugreport@mails.wedevs.org>
To: linux-acpi@vger.kernel.org
Subject: [Bug] ACPI BIOS errors - MECHREVO WUJIE15XA laptop (AMD Phoenix3)
Date: Mon, 27 Jul 2026 04:56:52 +0800
Message-ID: <178509941255.717042.12831748341930108468@mails.wedevs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SGksCgpPbiBhIE1FQ0hSRVZPIFdVSklFMTVYQSBsYXB0b3AgKEFNRCBQaG9lbml4MywgQklPUyB2
MTExKSwgdGhlCmZvbGxvd2luZyBBQ1BJIGVycm9ycyBhcHBlYXIgYXQgYm9vdDoKCiAgQUNQSSBC
SU9TIEVycm9yOiBGYWlsdXJlIGNyZWF0aW5nIG5hbWVkIG9iamVjdCBbXF9TQi5QQ0kwLkdQUDYu
V0xBTi5fRFNNXSwgQUVfQUxSRUFEWV9FWElTVFMKICBBQ1BJIEJJT1MgRXJyb3I6IEZhaWx1cmUg
Y3JlYXRpbmcgbmFtZWQgb2JqZWN0IFtcX1NCLlBDSTAuR1BQNi5fUzBXXSwgQUVfQUxSRUFEWV9F
WElTVFMKICBBQ1BJIEJJT1MgRXJyb3I6IEZhaWx1cmUgY3JlYXRpbmcgbmFtZWQgb2JqZWN0IFtc
X1NCLlBDSTAuR1BQNi5fUFJXXSwgQUVfQUxSRUFEWV9FWElTVFMKICBBQ1BJIEJJT1MgRXJyb3I6
IEZhaWx1cmUgY3JlYXRpbmcgbmFtZWQgb2JqZWN0IFtcX1NCLlBDSTAuR1BQNi5XTEFOLl9TMFdd
LCBBRV9BTFJFQURZX0VYSVNUUwogIEFDUEkgQklPUyBFcnJvcjogQ291bGQgbm90IHJlc29sdmUg
c3ltYm9sIFteXl5eTlBDRi5BQ0JUXSwgQUVfTk9UX0ZPVU5ECiAgQUNQSSBFcnJvcjogQWJvcnRp
bmcgbWV0aG9kIFxfU0IuUENJMC5TQlJHLkVDMC5fUTgzCgpUaGUgZmlyc3QgZm91ciBhcmUgZHVw
bGljYXRlIG5hbWVkIG9iamVjdHMgaW4gdGhlIERTRFQgZm9yIHRoZQpXTEFOIGRldmljZS4gVGhl
IGxhc3QgdHdvIGFmZmVjdCBFQyBxdWVyeSBtZXRob2QgX1E4My4KCktlcm5lbDogTGludXggZGUg
Ni4xMi45NitkZWIxMy1hbWQ2NCAjMSBTTVAgUFJFRU1QVF9EWU5BTUlDIERlYmlhbiA2LjEyLjk2
LTEgKDIwMjYtMDctMjApIHg4Nl82NCBHTlUvTGludXgKRE1JOiBNRUNIUkVWTyBXVUpJRTE1WEEK
QklPUzogQW1lcmljYW4gTWVnYXRyZW5kcyBJbnRlcm5hdGlvbmFsLCBMTEMuIHYxMTEKCklzIHRo
aXMgYSBrbm93biBCSU9TIGJ1Zywgb3IgaXMgYSBrZXJuZWwgd29ya2Fyb3VuZCBwb3NzaWJsZT8K
CkZ1bGwgZG1lc2cgb3V0cHV0IGF2YWlsYWJsZSBvbiByZXF1ZXN0Lg==
