Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.202.87.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931379;
	b=lvPedd4KVQ7lr9bT6tr8Hc7yRmTDIuwqtLRj55HrWH2INu7P3r3KFrVLoBXfMN9r4giw
	 7wNDFZQWIvam/bUj8VEbMD5B1AzK0UcyXdSlJ9Xpla17Uof07z+kfguIVjDDkbzagiLk1
	 ++ZTA00qZYIRnAmMxtJNTeQx/OmwH0H1F1pw2ChJ92SHQal3bz4JQA3wmvvi9Vp0p25U1
	 ravoFME5/9GPvIKy2hsPuo1hsVLC0gAs+HyPF9yzxtXTntzFtn1QBhNvGjFus0onlYXCv
	 XpoSkBbqbxTYxoewzRU3/WB5by8lk9r8VEuou9M2SyyTIkZlXz4XRAk3M3lukrhyOvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931379;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 Received:Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-originating-ip:x-tm-snts-smtp:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-MAIL;
	bh=0Z6Dp4l7Y62hYWbt/NR163eT1AEccJLWoAE3Sck9re8=;
	b=rkpq9Yjssh8SaF9LWQtgMG9c8MIonlO4V8PGYCa0w1/yJRNGV++n9Kq7JjNKO7FYUK66
	 2sgm5TNIiH5Ku5NQUZx/yXB1Xqe1f5dEsvpBUn29cy2T66fERggYrFdBg8nxg3+jGzrI4
	 iRv9k66A4uSI9/5E+7IBX9vkiHM10MN47p9U7a2tKg8BFuPbOfJE3MDRZzP/sR1tM3MW0
	 5eJVTRK50kuQV02BMS7qen8OkRf4NvPz25ljUmgCf53BJGoJ8qHgsYd72qfMdDOgAuKMC
	 OIazmlI8/3q2IV7mSDs+n0oz8TBdrkJ5n+NENn97k8ZhYXU/jVwNjN1DZtNHs/lRpsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ite.com.tw;
	spf=pass smtp.mailfrom=ite.com.tw;
	dkim=pass header.d=ite.com.tw header.i=@ite.com.tw header.a=rsa-sha256 header.s=dkim header.b=JZrvq0Tt;
	arc=none smtp.remote-ip=210.202.87.179
Received: from ironport.ite.com.tw (unknown [210.202.87.179])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB45C606A326;
	Fri,  6 Nov 2026 02:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB45C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ite.com.tw header.i=@ite.com.tw header.a=rsa-sha256 header.s=dkim header.b=JZrvq0Tt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Z6Dp4l7Y62hYWbt/NR163eT1AEccJLWoAE3Sck9re8=;
  b=JZrvq0TtrDAzPCPnItJgvn+C0fauptYHK4WiBmU/vQ6aYKxDeAb8lUoo
   EpQ33n4SzYyJ458dscO70eQGW8Ot/2TcSPKAPmtV577ODLANj+ZxUXr1s
   JTyc56TZQkfY+W/To//e1RQCUZpaiL4+UO8WKxmt5sWmF1qMkjtfwbPCe
   K7M5RZUrs10YJBnj/qQD+FwzkNqzvgClg8849844SHTxXKe/C9ad5v9x3
   /vZRdJkz7w4L48DtSImQn+2HMkLKJx3dNQLpjV+9G5TWi0z7GG5jRTpzU
   sLo4nTzVyryuuUevap/C0Dk8cg5rbKBQVE2EWtCYwL9rl4dnyom2LeoUP
   A==;
X-CSE-ConnectionGUID: AS/o0JppTbe+lxxK7dX0+w==
X-CSE-MsgGUID: cN3SfbVlR3G7Bf/djPDuMQ==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 06 Nov 2026 10:16:08 +0800
Received: from hscmail1.internal.ite.com.tw (HSCMAIL1.internal.ite.com.tw [192.168.35.58])
	by mse.ite.com.tw with ESMTP id 6A62G4JE029785;
	Fri, 6 Nov 2026 10:16:04 +0800 (+08)
	(envelope-from amber.kao@ite.com.tw)
Received: from HSCMAIL1.internal.ite.com.tw (192.168.35.58) by
 HSCMAIL1.internal.ite.com.tw (192.168.35.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 6 Nov 2026 10:16:03 +0800
Received: from HSCMAIL1.internal.ite.com.tw ([fe80::d4ad:7d1f:bb56:79ee]) by
 HSCMAIL1.internal.ite.com.tw ([fe80::d4ad:7d1f:bb56:79ee%6]) with mapi id
 15.02.2562.046; Fri, 6 Nov 2026 10:16:03 +0800
From: <amber.kao@ite.com.tw>
To: <edward.blair@gmail.com>, <ite_pd@ite.com.tw>
CC: <W_Armin@gmx.de>, <gregkh@linuxfoundation.org>,
        <heikki.krogerus@linux.intel.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <mika.westerberg@linux.intel.com>,
        <rafael@kernel.org>
Subject: RE: [PATCH v3 2/2] usb: typec: ucsi: add ITE885x I2C transport driver
Thread-Topic: [PATCH v3 2/2] usb: typec: ucsi: add ITE885x I2C transport
 driver
Thread-Index: AQHdY8AcuVqZ4jd75kmEYEi9svaOt7cMMrGAgBQtWrA=
Date: Fri, 6 Nov 2026 02:16:03 +0000
Message-ID: <c54acb44ee6e49949c69c9d84c19f350@ite.com.tw>
References: <20260829145516.13500-3-edward.blair@gmail.com>
 <20261002082552.7084-1-ite_pd@ite.com.tw>
 <CAJDQNghzjreMHXTVEWTZ-Oyo1cCpzLyDUyt68EZvPD30Wp0txQ@mail.gmail.com>
 <CAJDQNgiJCqAJQ+7zNLd+UD9vMuzu9e46zG5b5voKD+_gaKJcww@mail.gmail.com>
In-Reply-To: <CAJDQNgiJCqAJQ+7zNLd+UD9vMuzu9e46zG5b5voKD+_gaKJcww@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-snts-smtp: AE084F4A9C5FFA3D5030995CE64D295C0A80F95788C43523781FC904FB1994772002:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MAIL:mse.ite.com.tw 6A62G4JE029785

SGkgRWR3YXJkLA0KDQo+IEknbSBoYXBweSB0byBkcm9wIHRoZSBzZXBhcmF0ZSB0cmFuc3BvcnQg
ZHJpdmVyIGluIGZhdm91ciBvZg0KPiB1Y3NpX2l0ZXBkLiBXb3VsZCB5b3UgYmUgd2lsbGluZyB0
byB0YWtlIHRoZSBsZWFkIG9uIGFkZGluZyB0aGUgQUNQSQ0KPiBzdXBwb3J0IGFuZCBhbnkgaGFu
ZGxpbmcgbmVlZGVkIGZvciB0aGVzZSBBU1VTIGJvYXJkcz8NCg0KVGhhbmsgeW91IGZvciB5b3Vy
IHdvcmsgb24gQUNQSSBzdXBwb3J0IGZvciB0aGVzZSBjb250cm9sbGVycywgYW5kIGZvcg0KYWdy
ZWVpbmcgdG8gY29uc29saWRhdGUgb24gdWNzaV9pdGVwZC4NCg0KWWVzLCB3ZSB3aWxsIHRha2Ug
dGhlIGxlYWQuIEknbGwgc3RhcnQgYWRkaW5nIEFDUEkgc3VwcG9ydCB0bw0KdWNzaV9pdGVwZCwg
Y292ZXJpbmcgdGhlIElURTg4NTMgYW5kIElURTg4MDAtSVRFODgwNSBJRHMgYXMgd2VsbCBhcw0K
YW55IHBsYXRmb3JtLXNwZWNpZmljIGhhbmRsaW5nIHRoZSBBU1VTIGJvYXJkcyBuZWVkLg0KDQo+
IFBsZWFzZSBmZWVsIGZyZWUgdG8gcmV1c2UgYW55dGhpbmcgdXNlZnVsIGZyb20gbXkgcGF0Y2hl
cy4gSSBjYW4gaGVscA0KPiB0ZXN0IHlvdXIgY2hhbmdlcyBvbiBteSBBU1VTIFJPRyBTdHJpeCBa
NzkwLUUgR2FtaW5nIFdpRmkgd2l0aCBJVEU4ODUzDQo+IGFuZCBwcm92aWRlIGxvZ3Mgb3IgQUNQ
SSB0YWJsZXMuDQoNClRoYW5rIHlvdS4gWW91ciBwYXRjaGVzIGFyZSBhIHZlcnkgdXNlZnVsIHJl
ZmVyZW5jZSwgYW5kIEknbGwgbWFrZSBzdXJlDQp5b3VyIHdvcmsgaXMgcHJvcGVybHkgY3JlZGl0
ZWQgd2hlcmUgaXQgaXMgcmV1c2VkLiBJJ2xsIENjIHlvdSBvbiB0aGUNCnNlcmllcywgYW5kIHlv
dXIgdGVzdGluZyBvbiB0aGUgWjc5MC1FIChhbmQgYSBUZXN0ZWQtYnksIGlmIGFsbCBnb2VzDQp3
ZWxsKSB3b3VsZCBiZSBtdWNoIGFwcHJlY2lhdGVkLg0KDQo+IFRoZSBNU0ZUODAwMCBlbnVtZXJh
dGlvbiBmaXggaW4gcGF0Y2ggMSBpcyBzZXBhcmF0ZSBmcm9tIHRoZSB0cmFuc3BvcnQNCj4gZHJp
dmVyIGFuZCBoYXMgQXJtaW4ncyBSZXZpZXdlZC1ieSBhbmQgUmFmYWVsJ3MgQWNrZWQtYnkuIFRo
YXQgc2hvdWxkDQo+IHJlbWFpbiBwYXJ0IG9mIHRoZSBzb2x1dGlvbiBmb3IgdGhlc2UgYm9hcmRz
Lg0KDQpBZ3JlZWQuIFBhdGNoIDEgaXMgaW5kZXBlbmRlbnQgb2YgdGhlIHRyYW5zcG9ydCBkcml2
ZXIgYW5kIHNob3VsZCBnbw0KaW4gYXMgaXMuIFRoZSBBQ1BJIHN1cHBvcnQgaW4gdWNzaV9pdGVw
ZCB3aWxsIHJlbHkgb24gaXQgZm9yIHRoZXNlDQpib2FyZHMuDQoNCkZpbmFsbHksIGdpdmVuIHlv
dXIgd29yayBvbiB0aGVzZSBjb250cm9sbGVycyBhbmQgeW91ciBhY2Nlc3MgdG8gdGhlDQpoYXJk
d2FyZSwgd2Ugd291bGQgbGlrZSB0byBhZGQgeW91IGFzIG9uZSBvZiB0aGUgbWFpbnRhaW5lcnMg
b2YNCnVjc2lfaXRlcGQgaW4gTUFJTlRBSU5FUlMuIFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3Ug
YXJlIE9LIHdpdGggdGhhdC4NCg0KVGhhbmtzLA0KQW1iZXIgS2FvIDxpdGVfcGRAaXRlLmNvbS50
dz4NCg==
