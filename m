Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795290849;
	b=pPsGO3jmbAMBClE2acMvsSM5FkUn6gx/f2mkl3tAm2c1OPHv6kTLNJnhwZuQACa/s7fN
	 VjSo/19ICxLOa8IGRzmsZ5iIbyQXV8jVa9OwOI7o9P5t2EgeJVhfXCnmN2P1UTVy+QPXN
	 Pf/KfJjpIIj14tXJqWrNLjMY26tqS4OfqM2Zs2mGdmqpqWAU6YnNgs/pACWOqCQIgTPgo
	 GFL2OtPFIL2BTIT5YNbwoCdkm7h3Q9x0ZSChE5Uf9B/+tccgGpK4zToYJ9/YL8bADH7zS
	 nuFt6vVcsS0DjHJbwlBw395AXOOknmCpV/lOqVlTBIrSOalafuSRZOT+p3WKh6n8rkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795290849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=d1sN2fGHBg+DK42ooMw+OHw6UPh+x8wf0X6rkFNTrGI=;
	b=3F+D0zJQA9TYewq8wkAKRQ02PDxceVVRVSl0tso9wB2yGSoXjUP/Q7Xz/cFAVL/Gfyhp
	 pzYLQvzvZA1j/sttnXmDbv+MELkDECJE0sP4nMPIF1GE+3Ku7JNlaO5a6Df2fe2x5Qir5
	 kq+ppBQEEi5YAovR5V66FcmQTUepAs8+n/AQ8sB4LRODOxIFrVqEO0qUPALQijOr6G8vV
	 PX0FiBVczJ5dYLjlaUysXl4Im+66X2wm+5S4rAhPkJFuV2ahdEtRHMo6mX+Hs1qZ/rdrv
	 EKh7VnBCWsOxXpFS4nEw/lm5UVPa+a6299rAVrGhe2yq5CnHNR+lGckduxp1kdetD3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="kQIr/7mp";
	arc=fail smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B6A606A320
	for <linux-acpi@vger.kernel.org>; Sat, 21 Nov 2026 19:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88B6A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kQIr/7mp
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-86210f31496so1223772a34.2
        for <linux-acpi@vger.kernel.org>; Sat, 21 Nov 2026 11:54:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795290847; cv=none;
        d=google.com; s=arc-20260327;
        b=ajiE7p9JVgBN/8mE80nte5k3lyUbg9pn+axPIXjBIh+MGYtQFcuYsxKNawoneFm7l7
         h8VlTIXKhZ5nJRVVsOZdKU1l+hRg1gF02jThzUSQHGwZ2f3NmUvYXYQMk5q0U84n28jV
         nq5WzgE3jMnIUu8QGP5w2QkZDNuF080pkXvZJNngl1Cwk/OolQoZUm+Edwd7gFM1DnUv
         RBGVyMg89SEYDofhmkC/BXk6PSOw2ltNKV4sQcxZui00lqjtQyWBDF8hjsjKF6Dow2qQ
         Oyt83SltZFeaYUKypL9gf2zZG5OwnQYucOvcqDJmTG+Hpasdtn7LCRM7ctwQ0ms0ON6J
         lFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=d1sN2fGHBg+DK42ooMw+OHw6UPh+x8wf0X6rkFNTrGI=;
        fh=gUrNoDfEA1KepQHl6b3Jz7mWLdCAQUd9GlGxf70BXfE=;
        b=ckia4PfuYudrBJo03L4iBduyTIOIFLqaqHoCLVMXkQC6wDPctdNpmFdVch/JrY8gFO
         wXdS+ixtngP6IgSg+J5OKuqUPChz4QLVLv/bcGh1RArUId0CAngxrm7gU2u12u5Zp7GB
         uhL9KN1dQGGAmcv0yy8ZM75wCgwZWLldt3ecy1uxp3EIrL1P/wnfjw/SJYnf1GNmNnR/
         2iOdgbAjp+V0f7ZXEIyrP+O1z4jx/BzubU/4Yt9J+0DZRW25PTDqmANRRWENGdJiwYjR
         a0iNJshLgV0ljaKmCdzAf/efxRQtTNor0XAXEcpXMqZQob1kfFgNz/HoApb962rO9CH0
         hvnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795290847; x=1795895647; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d1sN2fGHBg+DK42ooMw+OHw6UPh+x8wf0X6rkFNTrGI=;
        b=kQIr/7mpY11TPTIq0vBtab2Ay1pFwi6kjVs9ll5uYaZvyZhL+dHqmuEw6tV6gKvMis
         5EOUkz9vcf8DysswFrpiRsMNDmjWG+pXSYZtp1SPWKq0cD7xv2SsHLZ+06BVSwIgu6uU
         hnUNNZM9PZqpP3fYMxaGQymDy3fVVERDtvSBYZcpSnwucyYJbOtKV87UcpoYp4n2WP7j
         9KakiVizbqn+sJLpGcX8lo/K54laJcatu/sGudkHZJAGBXPcddT9S3DuA28IU8YGzG3H
         yx4HKWmDCgGe+H14SHp0LVIO+LQRKCNB17SbJmjx3J+nafpBRzTOXuPWKoGXXQF0t6Bh
         rrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795290847; x=1795895647;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d1sN2fGHBg+DK42ooMw+OHw6UPh+x8wf0X6rkFNTrGI=;
        b=QzGAf632/26RxS9Y5eSbI/ZdI/5DWlpcqk/yUEhUPEOQrfi4p4IbqbPSjCQC6wxkgc
         xFbfaOedlubtWJ+PaU+VjMPgucMu93+1+9av8pW756uOYf83rN+LLPF7l0PXMQ00r12L
         euLwOvgA85/IDrP3/4qzEV9D0TvaOkUh0s3sRrAibEDw6rkmXKVNMEoR6NgSHjagv3fy
         Lw9hL5XYn3ZCZs8oMBRgPcYwWadG/cromlSKqaV/6vZBnvHDitpahPfYdCOePytNT7sT
         bfzKP9Nt76dy9nH3xSamNytSOsuJHFp8+tkgCrw0o/wsjwRUmvZTgMHBqfVl4RZ9U21s
         6WWQ==
X-Forwarded-Encrypted: i=1; AL+hErFm/NotQUp6hOiVW1rWLs/7Uf8FPyy4YHhLkKyZlQCux15sZBjB75MaiL7dpVk42zFvLtGx3KxWwlnb@vger.kernel.org
X-Gm-Message-State: APuU4Z/C2Mxq4iO0oAbptU4EVxnSY6Iva/r2Fm6iQCOCXGBcoIzmEgtm
	6oKrV/mqGNQiBem/cv8cB/pPHcfts3UpRAddPWUZnR6EDwpinJhweYjSfQ0xpKlFy3uwQQLQHHo
	MToxh2WSivVGs6ZSsAZjXXLHdPt83N2c=
X-Gm-Gg: AZFdTZevUYLDwhcT1OwYg4lDmWDlO2uwhbzT3qSaqpOeNCAa0V1mBqo/r0HFSiamTZj
	jRtECdVtE00WhRxbr3kTH8/LO61g40ASo+6FXeI9r8+EmqNGgWsinsliRBiJpBkbCsibJVby/hG
	84cLv01J2pxCWOsx8zD4TsAcEUxaE/RMbJsxIZh61Kxywybho4eNySMgp1YKMfOwcVI82ylQ30D
	LZJkx+i1n5xnlpwxC0aGIht8ZY20b8ameff+HJsh0zGXhVMx4o/Ta1tCDmmYCEw5oRfyik2YM3y
	kUCH4UO1PW/SqOTSskupc1swlbLPaaiRfx7kYshooWBlqFKlyQmUGs0f4sza5vSv/1fk5r3it/R
	QDE16m3x6OnwWejStWSSdp7HVapto6huCV52n
X-Received: by 2002:a05:6830:412a:b0:862:a48e:24e0 with SMTP id
 46e09a7af769-8631598c215mr7366042a34.17.1795290847284; Sat, 21 Nov 2026
 11:54:07 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260726212812.89266-1-shijujose2008@gmail.com>
 <20260726212812.89266-3-shijujose2008@gmail.com> <20261017055852.GBatMOnEl66YObvU5k@fat_crate.local>
 <CAG4KcR+NOKHNzg6FN-oLLHgUxeitZHKXg9cN7dz24+Ap=RrwSA@mail.gmail.com>
 <20261110071729.GIavLFCfLKzPx8R0i0@fat_crate.local> <CAG4KcR+ikfQEBjCZiNJ1CUz=u3Gtbk_XDroA_GQqYpgO4Lo5Qw@mail.gmail.com>
 <20261121194030.GBawHzrrCNCMpfr7Gx@fat_crate.local>
In-Reply-To: <20261121194030.GBawHzrrCNCMpfr7Gx@fat_crate.local>
From: Shiju Jose <shijujose2008@gmail.com>
Date: Sat, 21 Nov 2026 19:53:54 +0000
X-Gm-Features: Aa3M54rx1WE-eh_N_yvMS_3oQPZ6L5Jrg8YxPuFxTpWtz7t1OppYd2KzpokgdeM
Message-ID: <CAG4KcRKhE1UXwrhscUdSpDJS8R0t7kWp8RXZm8j_9yXYJSQ2KQ@mail.gmail.com>
Subject: Re: [PATCH v23 2/2] ras: mem: Add ACPI RAS2 memory driver
To: Borislav Petkov <bp@alien8.de>
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org, 
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	tony.luck@intel.com, lenb@kernel.org, Yazen.Ghannam@amd.com, 
	mchehab@kernel.org, ashok.raj@oss.qualcomm.com, jic23@kernel.org, 
	linuxarm@huawei.com, rientjes@google.com, jiaqiyan@google.com, 
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com, naoya.horiguchi@nec.com, 
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com, 
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com, 
	gthelen@google.com, wschwartz@amperecomputing.com, wbs@os.amperecomputing.com, 
	nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com, 
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com, 
	wanghuiqiang@huawei.com
Content-Type: multipart/mixed; boundary="00000000000038ad8a0660ceb900"

--00000000000038ad8a0660ceb900
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 7:41=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Tue, Nov 10, 2026 at 11:00:45PM +0000, Shiju Jose wrote:
> > I am sharing the changes in patch#2 here for feedback while testing on
> > other platforms.
>
> This doesn't apply. You can attach the diff so that I can fold it in.
>
> Thx.
Hi Boris,

Please find the attached patch with the changes.

Thanks,
Shiju

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

--00000000000038ad8a0660ceb900
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ras-mem-Replace-ioread8-16-32-64-with-readb-w-l-q-io.patch"
Content-Disposition: attachment; 
	filename="0001-ras-mem-Replace-ioread8-16-32-64-with-readb-w-l-q-io.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mwqtouuq0>
X-Attachment-Id: f_mwqtouuq0

RnJvbSBkNTA0ZDYxYTE3ZDQ2YjBhYTExNDFiNWQxY2Y4MjhmYWNiNjdlZWY2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaGlqdSBKb3NlIDxzaGlqdWpvc2UyMDA4QGdtYWlsLmNvbT4K
RGF0ZTogVHVlLCAxMCBOb3YgMjAyNiAyMjo0ODo1MiArMDAwMApTdWJqZWN0OiBbUEFUQ0ggMS8x
XSByYXM6IG1lbTogUmVwbGFjZSBpb3JlYWQ4LzE2LzMyLzY0IHdpdGggcmVhZGIvdy9sL3EgJgog
aW93cml0ZTgvMTYvMzIvNjQgd2l0aCB3cml0ZWIvdy9sL3EKClg4Ni02NCBidWlsZCBmYWlsZWQg
d2l0aCBpb3JlYWQ2NCBhbmQgaW93cml0ZTY0IGFyZSBub3QgZGVmaW5lZC4KClRvIGZpeCB0aGlz
IGlzc3VlIHJlcGxhY2UgaW9yZWFkOC8xNi8zMi82NCB3aXRoIHJlYWRiL3JlYWR3L3JlYWRsL3Jl
YWRxIGFuZAppb3dyaXRlOC8xNi8zMi82NCB3aXRoIHdyaXRlYi93cml0ZXcvd3JpdGVsL3dyaXRl
cSByZXNwZWN0aXZlbHkuCi0tLQogZHJpdmVycy9yYXMvYWNwaV9yYXMyLmMgfCA1NiArKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI4IGlu
c2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmFzL2Fj
cGlfcmFzMi5jIGIvZHJpdmVycy9yYXMvYWNwaV9yYXMyLmMKaW5kZXggNTFhZGZjZGRmYTk5Li4w
ODQ5ZGQyNDdjYWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcmFzL2FjcGlfcmFzMi5jCisrKyBiL2Ry
aXZlcnMvcmFzL2FjcGlfcmFzMi5jCkBAIC01MSw5ICs1MSw5IEBAIHN0YXRpYyBpbnQgcmFzMl9p
c19wYXRyb2xfc2NydWJfc3VwcG9ydChzdHJ1Y3QgcmFzMl9tZW1fY3R4ICpyYXMyX2N0eCkKIAlz
dHJ1Y3QgYWNwaV9yYXMyX3NobWVtIF9faW9tZW0gKmNvbW1vbiA9ICh2b2lkICopcmFzMl9jdHgt
PmNvbW1fYWRkcjsKIAogCWd1YXJkKG11dGV4KShyYXMyX2N0eC0+cGNjX2xvY2spOwotCWlvd3Jp
dGU4KDAsICZjb21tb24tPnNldF9jYXBzWzBdKTsKKwl3cml0ZWIoMCwgJmNvbW1vbi0+c2V0X2Nh
cHNbMF0pOwogCi0JcmV0dXJuIGlvcmVhZDgoJmNvbW1vbi0+ZmVhdHVyZXNbMF0pICYgUkFTMl9T
VVBQT1JUX0hXX1BBUlRPTF9TQ1JVQjsKKwlyZXR1cm4gcmVhZGIoJmNvbW1vbi0+ZmVhdHVyZXNb
MF0pICYgUkFTMl9TVVBQT1JUX0hXX1BBUlRPTF9TQ1JVQjsKIH0KIAogc3RhdGljIGludCByYXMy
X3VwZGF0ZV9wYXRyb2xfc2NydWJfcGFyYW1zX2NhY2hlKHN0cnVjdCByYXMyX21lbV9jdHggKnJh
czJfY3R4KQpAQCAtNjMsMTcgKzYzLDE3IEBAIHN0YXRpYyBpbnQgcmFzMl91cGRhdGVfcGF0cm9s
X3NjcnViX3BhcmFtc19jYWNoZShzdHJ1Y3QgcmFzMl9tZW1fY3R4ICpyYXMyX2N0eCkKIAl1MzIg
c2NydWJfcGFyYW1zX291dDsKIAlpbnQgcmV0OwogCi0JaW93cml0ZTgoUkFTMl9TVVBQT1JUX0hX
X1BBUlRPTF9TQ1JVQiwgJnBzX3NtLT5jb21tb24uc2V0X2NhcHNbMF0pOwotCWlvd3JpdGUxNihS
QVMyX0dFVF9QQVRST0xfUEFSQU1FVEVSUywgJnBzX3NtLT5wYXJhbXMuY29tbWFuZCk7Ci0JaW93
cml0ZTY0KHJhczJfY3R4LT5tZW1fYmFzZSwgJnBzX3NtLT5wYXJhbXMucmVxX2FkZHJfcmFuZ2Vb
MF0pOwotCWlvd3JpdGU2NChyYXMyX2N0eC0+bWVtX3NpemUsICZwc19zbS0+cGFyYW1zLnJlcV9h
ZGRyX3JhbmdlWzFdKTsKKwl3cml0ZWIoUkFTMl9TVVBQT1JUX0hXX1BBUlRPTF9TQ1JVQiwgJnBz
X3NtLT5jb21tb24uc2V0X2NhcHNbMF0pOworCXdyaXRldyhSQVMyX0dFVF9QQVRST0xfUEFSQU1F
VEVSUywgJnBzX3NtLT5wYXJhbXMuY29tbWFuZCk7CisJd3JpdGVxKHJhczJfY3R4LT5tZW1fYmFz
ZSwgJnBzX3NtLT5wYXJhbXMucmVxX2FkZHJfcmFuZ2VbMF0pOworCXdyaXRlcShyYXMyX2N0eC0+
bWVtX3NpemUsICZwc19zbS0+cGFyYW1zLnJlcV9hZGRyX3JhbmdlWzFdKTsKIAlyZXQgPSByYXMy
X3NlbmRfcGNjX2NtZChyYXMyX2N0eCwgUENDX0NNRF9FWEVDX1JBUzIpOwogCWlmIChyZXQpIHsK
IAkJZGV2X2VycihyYXMyX2N0eC0+ZGV2LCAiRmFpbGVkIHRvIHJlYWQgcGF0cm9sIHNjcnViIHBh
cmFtZXRlcnNcbiIpOwogCQlyZXR1cm4gcmV0OwogCX0KIAotCXNjcnViX3BhcmFtc19vdXQgPSBp
b3JlYWQzMigmcHNfc20tPnBhcmFtcy5zY3J1Yl9wYXJhbXNfb3V0KTsKKwlzY3J1Yl9wYXJhbXNf
b3V0ID0gcmVhZGwoJnBzX3NtLT5wYXJhbXMuc2NydWJfcGFyYW1zX291dCk7CiAJcmFzMl9jdHgt
Pm1pbl9zY3J1Yl9jeWNsZSA9IEZJRUxEX0dFVChSQVMyX1BTX01JTl9TQ19IUlNfT1VUX01BU0ss
CiAJCQkJCSAgICAgIHNjcnViX3BhcmFtc19vdXQpOwogCXJhczJfY3R4LT5tYXhfc2NydWJfY3lj
bGUgPSBGSUVMRF9HRVQoUkFTMl9QU19NQVhfU0NfSFJTX09VVF9NQVNLLApAQCAtOTQsMTAgKzk0
LDEwIEBAIHN0YXRpYyBpbnQgcmFzMl91cGRhdGVfcGF0cm9sX3NjcnViX3BhcmFtc19jYWNoZShz
dHJ1Y3QgcmFzMl9tZW1fY3R4ICpyYXMyX2N0eCkKIAkJcmV0dXJuIDA7CiAJfQogCi0JaWYgIChp
b3JlYWQzMigmcHNfc20tPnBhcmFtcy5mbGFncykgJiBSQVMyX1BTX0ZMQUdfU0NSVUJfUlVOTklO
RykgeworCWlmICAocmVhZGwoJnBzX3NtLT5wYXJhbXMuZmxhZ3MpICYgUkFTMl9QU19GTEFHX1ND
UlVCX1JVTk5JTkcpIHsKIAkJcmFzMl9jdHgtPm9kX3NjcnViID0gdHJ1ZTsKLQkJcmFzMl9jdHgt
PmJhc2UgPSBpb3JlYWQ2NCgmcHNfc20tPnBhcmFtcy5hY3RsX2FkZHJfcmFuZ2VbMF0pOwotCQly
YXMyX2N0eC0+c2l6ZSA9IGlvcmVhZDY0KCZwc19zbS0+cGFyYW1zLmFjdGxfYWRkcl9yYW5nZVsx
XSk7CisJCXJhczJfY3R4LT5iYXNlID0gcmVhZHEoJnBzX3NtLT5wYXJhbXMuYWN0bF9hZGRyX3Jh
bmdlWzBdKTsKKwkJcmFzMl9jdHgtPnNpemUgPSByZWFkcSgmcHNfc20tPnBhcmFtcy5hY3RsX2Fk
ZHJfcmFuZ2VbMV0pOwogCX0gZWxzZSB7CiAJCXJhczJfY3R4LT5vZF9zY3J1YiA9IGZhbHNlOwog
CX0KQEAgLTEyOCw3ICsxMjgsNyBAQCBzdGF0aWMgaW50IHJhczJfZ2V0X2RlbWFuZF9zY3J1Yl9y
dW5uaW5nKHN0cnVjdCByYXMyX21lbV9jdHggKnJhczJfY3R4LCBib29sICpydQogCQlyZXR1cm4g
cmV0OwogCX0KIAotCSpydW5uaW5nID0gaW9yZWFkMzIoJnBzX3NtLT5wYXJhbXMuZmxhZ3MpICYg
UkFTMl9QU19GTEFHX1NDUlVCX1JVTk5JTkc7CisJKnJ1bm5pbmcgPSByZWFkbCgmcHNfc20tPnBh
cmFtcy5mbGFncykgJiBSQVMyX1BTX0ZMQUdfU0NSVUJfUlVOTklORzsKIAlpZiAoISgqcnVubmlu
ZykpCiAJCXJhczJfY3R4LT5vZF9zY3J1YiA9IGZhbHNlOwogCkBAIC0zMzgsMTggKzMzOCwxOCBA
QCBzdGF0aWMgaW50IF9fcmFzMl9od19zY3J1Yl9zZXRfZW5hYmxlZF9iZyhzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHZvaWQgKmRydl9kYXRhLCBibwogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAKLQlp
b3dyaXRlOChSQVMyX1NVUFBPUlRfSFdfUEFSVE9MX1NDUlVCLCAmcHNfc20tPmNvbW1vbi5zZXRf
Y2Fwc1swXSk7CisJd3JpdGViKFJBUzJfU1VQUE9SVF9IV19QQVJUT0xfU0NSVUIsICZwc19zbS0+
Y29tbW9uLnNldF9jYXBzWzBdKTsKIAlpZiAoZW5hYmxlKSB7CiAJCWlmIChyYXMyX2N0eC0+Ymdf
c2NydWIgfHwgcnVubmluZykKIAkJCXJldHVybiAtRUJVU1k7CiAKLQkJaW93cml0ZTY0KDAsICZw
c19zbS0+cGFyYW1zLnJlcV9hZGRyX3JhbmdlWzBdKTsKLQkJaW93cml0ZTY0KDAsICZwc19zbS0+
cGFyYW1zLnJlcV9hZGRyX3JhbmdlWzFdKTsKLQkJc2NydWJfcGFyYW1zX2luID0gaW9yZWFkMzIo
JnBzX3NtLT5wYXJhbXMuc2NydWJfcGFyYW1zX2luKTsKKwkJd3JpdGVxKDAsICZwc19zbS0+cGFy
YW1zLnJlcV9hZGRyX3JhbmdlWzBdKTsKKwkJd3JpdGVxKDAsICZwc19zbS0+cGFyYW1zLnJlcV9h
ZGRyX3JhbmdlWzFdKTsKKwkJc2NydWJfcGFyYW1zX2luID0gcmVhZGwoJnBzX3NtLT5wYXJhbXMu
c2NydWJfcGFyYW1zX2luKTsKIAkJc2NydWJfcGFyYW1zX2luICY9IH5SQVMyX1BTX1NDX0hSU19J
Tl9NQVNLOwogCQlzY3J1Yl9wYXJhbXNfaW4gfD0gRklFTERfUFJFUChSQVMyX1BTX1NDX0hSU19J
Tl9NQVNLLCByYXMyX2N0eC0+c2V0X3NjcnViX2N5Y2xlKTsKLQkJaW93cml0ZTMyKHNjcnViX3Bh
cmFtc19pbiwgJnBzX3NtLT5wYXJhbXMuc2NydWJfcGFyYW1zX2luKTsKLQkJaW93cml0ZTE2KFJB
UzJfU1RBUlRfUEFUUk9MX1NDUlVCQkVSLCAmcHNfc20tPnBhcmFtcy5jb21tYW5kKTsKKwkJd3Jp
dGVsKHNjcnViX3BhcmFtc19pbiwgJnBzX3NtLT5wYXJhbXMuc2NydWJfcGFyYW1zX2luKTsKKwkJ
d3JpdGV3KFJBUzJfU1RBUlRfUEFUUk9MX1NDUlVCQkVSLCAmcHNfc20tPnBhcmFtcy5jb21tYW5k
KTsKIAl9IGVsc2UgewogCQkvKgogCQkgKiBUaGVyZSBpcyBubyBuZWVkIHRvIHNlbmQgdGhlIGNv
bW1hbmQgdG8gc3RvcCBiYWNrZ3JvdW5kIHNjcnViYmluZywKQEAgLTM1OCwxMyArMzU4LDEzIEBA
IHN0YXRpYyBpbnQgX19yYXMyX2h3X3NjcnViX3NldF9lbmFibGVkX2JnKHN0cnVjdCBkZXZpY2Ug
KmRldiwgdm9pZCAqZHJ2X2RhdGEsIGJvCiAJCWlmICghcmFzMl9jdHgtPmJnX3NjcnViKQogCQkJ
cmV0dXJuIC1FUEVSTTsKIAotCQlpb3dyaXRlMTYoUkFTMl9TVE9QX1BBVFJPTF9TQ1JVQkJFUiwg
JnBzX3NtLT5wYXJhbXMuY29tbWFuZCk7CisJCXdyaXRldyhSQVMyX1NUT1BfUEFUUk9MX1NDUlVC
QkVSLCAmcHNfc20tPnBhcmFtcy5jb21tYW5kKTsKIAl9CiAKLQlzY3J1Yl9wYXJhbXNfaW4gPSBp
b3JlYWQzMigmcHNfc20tPnBhcmFtcy5zY3J1Yl9wYXJhbXNfaW4pOworCXNjcnViX3BhcmFtc19p
biA9IHJlYWRsKCZwc19zbS0+cGFyYW1zLnNjcnViX3BhcmFtc19pbik7CiAJc2NydWJfcGFyYW1z
X2luICY9IH5SQVMyX1BTX0VOX0JBQ0tHUk9VTkQ7CiAJc2NydWJfcGFyYW1zX2luIHw9IEZJRUxE
X1BSRVAoUkFTMl9QU19FTl9CQUNLR1JPVU5ELCBlbmFibGUpOwotCWlvd3JpdGUzMihzY3J1Yl9w
YXJhbXNfaW4sICZwc19zbS0+cGFyYW1zLnNjcnViX3BhcmFtc19pbik7CisJd3JpdGVsKHNjcnVi
X3BhcmFtc19pbiwgJnBzX3NtLT5wYXJhbXMuc2NydWJfcGFyYW1zX2luKTsKIAlyZXQgPSByYXMy
X3NlbmRfcGNjX2NtZChyYXMyX2N0eCwgUENDX0NNRF9FWEVDX1JBUzIpOwogCWlmIChyZXQpIHsK
IAkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gJXMgYmFja2dyb3VuZCBzY3J1YmJpbmdcbiIsCkBA
IC00NDksMjIgKzQ0OSwyMiBAQCBzdGF0aWMgaW50IHJhczJfaHdfc2NydWJfc2V0X2VuYWJsZWRf
b2Qoc3RydWN0IGRldmljZSAqZGV2LCB2b2lkICpkcnZfZGF0YSwgYm9vbAogCQlnb3RvIGVuYWJs
ZV9iZ19zY3J1YjsKIAl9CiAKLQlpb3dyaXRlOChSQVMyX1NVUFBPUlRfSFdfUEFSVE9MX1NDUlVC
LCAmcHNfc20tPmNvbW1vbi5zZXRfY2Fwc1swXSk7Ci0Jc2NydWJfcGFyYW1zX2luID0gaW9yZWFk
MzIoJnBzX3NtLT5wYXJhbXMuc2NydWJfcGFyYW1zX2luKTsKKwl3cml0ZWIoUkFTMl9TVVBQT1JU
X0hXX1BBUlRPTF9TQ1JVQiwgJnBzX3NtLT5jb21tb24uc2V0X2NhcHNbMF0pOworCXNjcnViX3Bh
cmFtc19pbiA9IHJlYWRsKCZwc19zbS0+cGFyYW1zLnNjcnViX3BhcmFtc19pbik7CiAJc2NydWJf
cGFyYW1zX2luICY9IH5SQVMyX1BTX1NDX0hSU19JTl9NQVNLOwogCXNjcnViX3BhcmFtc19pbiB8
PSBGSUVMRF9QUkVQKFJBUzJfUFNfU0NfSFJTX0lOX01BU0ssIHJhczJfY3R4LT5zZXRfc2NydWJf
Y3ljbGUpOwogCXNjcnViX3BhcmFtc19pbiAmPSB+UkFTMl9QU19FTl9CQUNLR1JPVU5EOwotCWlv
d3JpdGUzMihzY3J1Yl9wYXJhbXNfaW4sICZwc19zbS0+cGFyYW1zLnNjcnViX3BhcmFtc19pbik7
Ci0JaW93cml0ZTY0KHJhczJfY3R4LT5iYXNlLCAmcHNfc20tPnBhcmFtcy5yZXFfYWRkcl9yYW5n
ZVswXSk7Ci0JaW93cml0ZTY0KHJhczJfY3R4LT5zaXplLCAmcHNfc20tPnBhcmFtcy5yZXFfYWRk
cl9yYW5nZVsxXSk7Ci0JaW93cml0ZTE2KFJBUzJfU1RBUlRfUEFUUk9MX1NDUlVCQkVSLCAmcHNf
c20tPnBhcmFtcy5jb21tYW5kKTsKKwl3cml0ZWwoc2NydWJfcGFyYW1zX2luLCAmcHNfc20tPnBh
cmFtcy5zY3J1Yl9wYXJhbXNfaW4pOworCXdyaXRlcShyYXMyX2N0eC0+YmFzZSwgJnBzX3NtLT5w
YXJhbXMucmVxX2FkZHJfcmFuZ2VbMF0pOworCXdyaXRlcShyYXMyX2N0eC0+c2l6ZSwgJnBzX3Nt
LT5wYXJhbXMucmVxX2FkZHJfcmFuZ2VbMV0pOworCXdyaXRldyhSQVMyX1NUQVJUX1BBVFJPTF9T
Q1JVQkJFUiwgJnBzX3NtLT5wYXJhbXMuY29tbWFuZCk7CiAKIAlyZXQgPSByYXMyX3NlbmRfcGNj
X2NtZChyYXMyX2N0eCwgUENDX0NNRF9FWEVDX1JBUzIpOwogCWlmIChyZXQpIHsKIAkJZGV2X2Vy
cihkZXYsICJGYWlsZWQgdG8gc3RhcnQgZGVtYW5kIHNjcnViYmluZyByYyglZClcbiIsIHJldCk7
CiAJCWlmIChyZXQgIT0gLUVCVVNZKSB7Ci0JCQlpb3dyaXRlNjQoMCwgJnBzX3NtLT5wYXJhbXMu
cmVxX2FkZHJfcmFuZ2VbMF0pOwotCQkJaW93cml0ZTY0KDAsICZwc19zbS0+cGFyYW1zLnJlcV9h
ZGRyX3JhbmdlWzFdKTsKKwkJCXdyaXRlcSgwLCAmcHNfc20tPnBhcmFtcy5yZXFfYWRkcl9yYW5n
ZVswXSk7CisJCQl3cml0ZXEoMCwgJnBzX3NtLT5wYXJhbXMucmVxX2FkZHJfcmFuZ2VbMV0pOwog
CQkJcmFzMl9jdHgtPm9kX3NjcnViID0gZmFsc2U7CiAJCQlyYXMyX2N0eC0+YmFzZSA9IDA7CiAJ
CQlyYXMyX2N0eC0+c2l6ZSA9IDA7Ci0tIAoyLjI1LjEKCg==
--00000000000038ad8a0660ceb900--
