Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67951435514
	for <linux-acpi@vger.kernel.org>; Thu, 23 Jul 2026 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801277; cv=none; b=nea2dwuzVcv2yQSkRgR59Hl+VRe9dsKUHXiSn4/mm77tbYGMx8ufhWqHS6sbp7edg9SnFsz51K9OLA9WRgYcw9GaqGab0nzqsX10ybnZUloMu5TPN64wBMOhk53RHKs2/8wjO6dz/mHRUzfd/TGpiYiRVzoiXwihffYbZGja7Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801277; c=relaxed/simple;
	bh=qPE1Fr7D2oTtJwhgrsWehdR9toNeK1V5anzNUe9deV8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:
	 References:Subject; b=mYy8FsGDcK4qy9+vyZWOYJ2khTrS6AqY/2xN69EFwFsXK9DNrhnHJ1L8rvKwZewnxOTIFCK4ys8OqTYCW9QMokU4WfmFuZLdIoO8kBhmcOpHJ2quFqROfM5bJLfG/zEPsVXLWVaW3Wxs8Ej/Iq3QMxEO3dVvo8VOThJbNj0o03Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh3xyWtc; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh3xyWtc"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-4705f607bcbso27272f8f.0
        for <linux-acpi@vger.kernel.org>; Thu, 23 Jul 2026 03:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784801273; x=1785406073; darn=vger.kernel.org;
        h=subject:references:in-reply-to:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qPE1Fr7D2oTtJwhgrsWehdR9toNeK1V5anzNUe9deV8=;
        b=Dh3xyWtcWcOpNK790vmpX9OHeOZh2VrjObTBkv31ALqKaGtMfBD39hFebTHTX/a8eq
         3TwlpD/tXOTxJQRxiS11V6yfuzjrQfo85H+J0TuEdlZVuKpXU6JVnVnSQ2/VLvwjO61u
         6/+Au7tv8nbwiNE+uL2n9yPUQd3g5h+UpCpdkuyb58HUnZymAWezH4d4woAkv9baV+l1
         9zfuf7ILrmp4QYNaX6DhZplq39BhZPvhp3rtQrLfyzmm5HeD9H7MZbGKhn201omZ7Deq
         04vzg188VG3mBdnmuvfr2ENsp1dKYGK1LCeU3vIdBr5P+12b0RZcuIu+wvkoZFFShDYk
         2UjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784801273; x=1785406073;
        h=subject:references:in-reply-to:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qPE1Fr7D2oTtJwhgrsWehdR9toNeK1V5anzNUe9deV8=;
        b=bPi3h9WAfYFuGmwhRKfj+wtp/O3cZS9rqG4gizkFSnDmy9gneNX4UfpG+raHQTUDTW
         CGXLLXGgPNyFjueUPTZ7Hob0Efm8FezZ1OYm4BSz9VfoGBCXNDBzYtMol93c46FkOVYR
         p6mD7CyaewR8wX+UTpzM4jbii9hUy0KtbbDnrbmS9OqkXWBH4FwpXB69rTNkkPOSw4GL
         xAAw+h6zxWwV/Ug4CLaKlN/YDbQ5M7bQzsqzMLgYE+zgVgrDl9dqBqISHjwXsnsSbEFy
         oWb0Lfo4R3vuilRo6CySbxtGLbNaRlROST3edddys4UAMRAegpCeleRmQGQfcv+HiEvw
         CDdQ==
X-Forwarded-Encrypted: i=1; AHgh+RqXEJpKvu5Gf8bkXlWJ+I0KUdtwTxWMsSIIENOiKL+Efqk5cHiJTPV64ip6/pPOHlOzEe8bIZcU0lxY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9U5VrTJW9pCo7HavDFZ7BlZAZOW77+t1WSNd+VtrNzNvcoCz4
	oGKBpXgsIJc46eyVXTca1SAHMsIRNf7JrpVoJfRGPdXrwuAdGWZfDkhz
X-Gm-Gg: AR+sD13NEFcEW5ZCSV2gPDRbs2ZJhMJVd9KUs5OF8sL8UbWVmMaQZ/FETy4ZTSL+Axn
	0LPSjwC2AE7tWorF4It8m1LaGryiRRCAbNNTYE5i7xx6Ql5mQ/NFCyKdbBGeFtv00K7aX5VKNg+
	MZGms1laAvfzX2GUG2mUYChhdBc8wgctQJjjGwUdkgo+qMxiotybEoV30NNlqhUIeD6Pf/HCIoP
	4Y1lZjMAt/PfxyWPWTi1LjKIGXclJGcAHtezEboHWkOtzMInczYFYoBs554zPBJn0lDxYKH4yJ5
	XYPqycnYG6js+mZxvxEqqOdfB6AL653RBiKUmhm8MNi+Rkuvlm02yBSewGGidcwVrwYmO/y/OZT
	IYqqr7COEeaWWqbr+B8i76hY/Sj+uvX9VOh/ZErelcFrLna9f6UYjvDwKZ6fPgNpFM3BFuKlCak
	9PUWxMmO9tSMlAgSk=
X-Received: by 2002:a05:600c:5715:b0:495:4044:11fc with SMTP id 5b1f17b1804b1-49573cf0130mr10416385e9.7.1784801273183;
        Thu, 23 Jul 2026 03:07:53 -0700 (PDT)
Received: from [127.0.1.1] ([79.123.179.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956537c6besm197711895e9.8.2026.07.23.03.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:07:52 -0700 (PDT)
Message-ID: <6a61e7f8.e11288f4.4669c.c3b1@mx.google.com>
Date: Thu, 23 Jul 2026 03:07:52 -0700 (PDT)
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
In-Reply-To: <2026071842-timing-distress-ad5a@gregkh>
References: <2026071842-timing-distress-ad5a@gregkh>
Subject: =?utf-8?q?Re=3A_=5BPATCH_0/4=5D_drivers/misc=3A_add_Goodix_GXFP5130_eSPI_fin?=
 =?utf-8?q?gerprint_sensor_driver?=

SSBhbSB3aXRoZHJhd2luZyB0aGlzIHBhdGNoIHNlcmllcyAodjEpLgoKQWZ0ZXIgY29uc3VsdGlu
ZyB3aXRoIFZvaWQ3NTUsIHdobyB3cm90ZSB0aGUgb3JpZ2luYWwgb3V0LW9mLXRyZWUgZHJpdmVy
CnRoaXMgc3VibWlzc2lvbiB3YXMgYmFzZWQgb24sIGl0IGJlY2FtZSBjbGVhciB0aGF0IHRoZSBk
cml2ZXIgaXMgbm90IHJlYWR5CmZvciBtYWlubGluZSBpbmNsdXNpb24geWV0LiBTcGVjaWZpY2Fs
bHk6CgogIC0gVGhlIGtlcm5lbCBtb2R1bGUgY3VycmVudGx5IGhhbmRsZXMgc2Vuc29yLXNwZWNp
ZmljIHByb3RvY29sIGxvZ2ljCiAgICAoTVAgcHJvdG9jb2wsIEdvb2RpeCBjb21tYW5kIHN0cnVj
dHVyZXMpIHRoYXQgYmVsb25ncyBpbiB1c2Vyc3BhY2UuCiAgICBUaGlzIGlzIGNvbnNpc3RlbnQg
d2l0aCB0aGUgY29uY2VybiB5b3UgcmFpc2VkIGFib3V0IHdoeSBhIGtlcm5lbAogICAgZHJpdmVy
IGlzIG5lZWRlZCBhdCBhbGwuCgogIC0gQSBzaWJsaW5nIHNlbnNvciAoU0lMNjI1MCkgc2hhcmVz
IHRoZSBzYW1lIGVTUEkgbWFpbGJveCB0cmFuc3BvcnQKICAgIG1lY2hhbmlzbS4gQSBwcm9wZXJs
eSByZWZhY3RvcmVkLCB0cmFuc3BvcnQtb25seSBrZXJuZWwgZHJpdmVyIGNvdWxkCiAgICBzdXBw
b3J0IGJvdGggc2Vuc29ycywgd2hpY2ggd291bGQgbWFrZSBhIHN0cm9uZ2VyIGNhc2UgZm9yIG1h
aW5saW5lLgoKICAtIFRoZSBvcmlnaW5hbCBhdXRob3IgcHJlZmVycyBvdXQtb2YtdHJlZSBtYWlu
dGVuYW5jZSBmb3Igbm93IHdoaWxlCiAgICB0aGUgYXJjaGl0ZWN0dXJlIGlzIHJld29ya2VkLgoK
SSB3aWxsIHJlc3VibWl0IG9uY2UgdGhlIGtlcm5lbC91c2Vyc3BhY2UgYm91bmRhcnkgaXMgcHJv
cGVybHkgZGVzaWduZWQKYW5kIHRoZSBkcml2ZXIgaXMgaW4gYSBzdGF0ZSB0aGUgb3JpZ2luYWwg
YXV0aG9yIGNvbnNpZGVycyByZWFkeS4KClRoYW5rIHlvdSBmb3IgdGhlIGRldGFpbGVkIHJldmll
dyBvZiB2MS4KCk1ldGVoYW4gR8O8bmVu

