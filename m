Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F263911B8
	for <linux-acpi@vger.kernel.org>; Sun, 19 Jul 2026 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784458396; cv=none; b=Q5p4mZeA22+fbLqGlO6BGgIY5fbb6b0xddQuwqczzEUm5YsV05iP65KaS6l0qgM3wEz78an5dwso6XRA9BEGKtwz2dA0nCeYS9dslU3xBClg1NKTKQgRfxbvOm/S+vwlmL2ypXTCHcB3is/1MrZAw3JNdGsErwYpg04UPCzLV7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784458396; c=relaxed/simple;
	bh=pA63VflcxP+j4+8wOB1f8R+Ru4uzCjEmE2cEIV1sytc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:
	 References:Subject; b=Nc9AN9Gs4z5YNFKZ2PSHsLdBph1NmlkoFNpGT2l1MKlLJoPHd+3tYt/3+6eA5j8Fj+zPMETybcma0BMbLQGp+VvEeV+AP4wQmcmMbhogpBHhOJixtnh4njgZe/aJQmslQDHEbaN7Sff4RpXjWOigmm4ycx5OTZWR4j3OJsduh30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AchdJJaZ; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AchdJJaZ"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49551652105so357725e9.1
        for <linux-acpi@vger.kernel.org>; Sun, 19 Jul 2026 03:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784458392; x=1785063192; darn=vger.kernel.org;
        h=subject:references:in-reply-to:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pA63VflcxP+j4+8wOB1f8R+Ru4uzCjEmE2cEIV1sytc=;
        b=AchdJJaZJ+TwYONmK6vagYIc9k49rIOa5RdSrY3V2dMWBjnddNzINdEUye+aDC5tAS
         NYZzRB9b9WtlW2APSw8DzUW/NxKY13eSuPm5IU59oTZKuUdJ3fDXuVzv4Z/+WqaOfKXX
         0HcaKQOown2bYThXkO57PCSx50Vn9fXzL5UJNT9U3Yz56Vtg93EGFAyR8kDipRl4gxJV
         iGjJEah1bEEyWJJILjRO2yTjRu/kbpEAmmq0Dg/FHOo+wb9GbhBVX7P6kI/tNEOLmhYB
         tQ2xFViSHv0h0X17FiLnN2RJMr4un/DYtd5M0urRZ6MLze52uZlbfrL09Y8gYmydP3/X
         lX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784458392; x=1785063192;
        h=subject:references:in-reply-to:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pA63VflcxP+j4+8wOB1f8R+Ru4uzCjEmE2cEIV1sytc=;
        b=cGhqADcWhVJu7KQBCQPdRLVjvor0XKSpo6LXNmy/8UzbIl5+KTtBb3g8VFFfGJ6UHm
         do4gLeiGXE7OgvrwOjPR/5vvTELegFuOojTuUwOxLdsIPbpdoMdCr7vpr8tFOpsQIwTf
         7A1QMiB5VKc/byaXmFfIH0DyPHJ/UWt3NB+h6QVc9cx8TVyegy24xlnU0TP5A7l0EmUS
         h3CxHxcLumqNwI6ACrSuDmHvESqh6Iu0Fn2i1oUcfz9OsHSCD0xD0aDMGoot+KOXVacU
         Ox93LdSfdj5n1hMBJqdpjwlh4hWivvNR7uqUhXcoyH3+guBTM2C8HNtwvIHceBUrqCnM
         73lA==
X-Forwarded-Encrypted: i=1; AHgh+RrLyZoucAZiMRYbz2qy4oeb/Z1beZ8gn2Xk5JYIYgjW8oHpr9pDRyXe4eUV0vw3No7seDKw/XBbkZLQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6B0fsxtcIBzL0xonthM3vYnFmzQLaEwmTjNDEbb2r4dHp4u5o
	5pdQwe68Qy+kAnqdty3BGYQyR+++MD+BWEqwZBkLk728DXXTniZsi99FDcVf/Jud
X-Gm-Gg: AfdE7clTM02aHOZ18bnCqViddFId3plUkelflLbs6UdAu/Xy6bSRKs3ppg2xell3/rD
	rpL+bqut1nNeGOnhU4VacEKc6MGkRF3yTni6DZhqzP7gRWDLPOP3gjRdOQ7jozefLWnKCfMGDiz
	lBztdRndTUFNMR7BAmQJTPD61/OEblzkeDbCKYMPQRZE8YyotqA4XOTINFeEfW7TW+zyZlmF8r0
	yhBZ6hpVNZ/kJDKQd2OHOXx48Bwfo2bK1Bhaf3xZND2LC0NVLF7Y2uAD/z2xZE6/EcryaX+0edR
	cBZzaHw93YriQ5bfl9uYjgOa6ydvr4ZKLog5Pevd4F76nb80qQuTB6a3iTXSRcdeKiqESRa1PLo
	mmUO88R9PAVPziDBv9sqdmHIGt8EEcJqwxzlpX3sawsASpsHbbYRs17V+FjCGITa0fVku2/Y/P/
	DEVEtiyNU+FcHHvg==
X-Received: by 2002:a05:600c:1c23:b0:490:846d:4edf with SMTP id 5b1f17b1804b1-4954a3ebc81mr58673285e9.1.1784458392404;
        Sun, 19 Jul 2026 03:53:12 -0700 (PDT)
Received: from [127.0.1.1] ([95.70.199.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49548e075d4sm141919705e9.1.2026.07.19.03.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:53:10 -0700 (PDT)
Message-ID: <6a5cac96.b39440a8.65068.287a@mx.google.com>
Date: Sun, 19 Jul 2026 03:53:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: =?utf-8?q?Metehan_G=C3=BCnen?= <metehangnen@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-gpio@vger.kernel.org
In-Reply-To: <2026071801-headdress-gab-348e@gregkh>
References: <2026071801-headdress-gab-348e@gregkh>
Subject: =?utf-8?q?Re=3A_=5BPATCH_1/4=5D_include/uapi/linux=3A_add_gxfp=5Fioctl=2Eh_f?=
 =?utf-8?q?or_GXFP5130_fingerprint_sensor?=

T24gU2F0LCBKdWwgMTgsIDIwMjYgYXQgMTE6MDc6NDdBTSArMDIwMCwgR3JlZyBLSCB3cm90ZToK
PiBDIHZhcmlhYmxlcyBkbyBub3Qgc3RhcnQgd2l0aCBfLCB0aGlzIGlzbid0IHJ1c3QgOikKPgo+
IEFuZCBhcmUgeW91IGNoZWNraW5nIHRoaXMgZm9yIDA/CgpXaWxsIHJlbmFtZSBfcnN2ZDAgdG8g
cmVzZXJ2ZWQgYW5kIGFkZCBhIHplcm8tY2hlY2sgaW4gdjI6CgogIGlmIChoZHIucmVzZXJ2ZWQg
IT0gMCkKICAgICAgICAgIHJldHVybiAtRUlOVkFMOwoKPiBBcmUgeW91IGNoZWNraW5nIHRoaXMg
Zm9yIDA/CgpTYW1lIGZvciBfcGFkMDogd2lsbCByZW5hbWUgdG8gcGFkIGFuZCBhZGQgemVybyB2
YWxpZGF0aW9uLgoKPiBObyBkZWZpbml0aW9uIG9mIHdoYXQgdGhlc2UgZmxhZ3MgYXJlPwoKVGhl
IGZsYWdzIGZpZWxkIHdhcyBwbGFjZWhvbGRlciBjb2RlIHRoYXQgd2FzIG5ldmVyIHdpcmVkIHVw
IOKAlCB0aGVyZSBhcmUKbm8gZmxhZyB2YWx1ZXMgZGVmaW5lZCBvciB1c2VkIGFueXdoZXJlLiBJ
IHdpbGwgcmVtb3ZlIHRoZSBmaWVsZCBlbnRpcmVseQppbiB2MiB0byBrZWVwIHRoZSBBQkkgY2xl
YW4uCgpUaGFua3MsCk1ldGVoYW4gR8O8bmVu

