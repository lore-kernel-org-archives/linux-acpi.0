Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795859780;
	b=ThFfGZHipgdQG4c5yhNWdJMwIOPoYW/LnJRdf28oKtUdtrWc1yHvdMLkVhvDum9Ml02w
	 Jg0pcVJdEppTZ2qUN/vbXGNGXoGHGZRW9KUvQwZM6mY0GYW0DXqCbXOEgazByc3kh1o51
	 pFQEvCOM2+q6b1K86PaK7KOo/yrgfg6aEWfKsOI0rCc0S0oAJoQ9cKtiWADkHCs73Gg++
	 BVr27UirLTcIgjKPOy4pZ5fsSqmGluprJdfQ5KoOzwYBXBpE06dm/oRywQTwTLwFjvJ6W
	 edoY9Rzkt+bSiQiJq9FdXRySr/ajcxla02+ZCasRJnCq/o1S4TCin3u6G+tzhMfywUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795859780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=W6VYQXUuMNet9TO/oFD0qhwG1QVrLrv0K6QiopT3mtY=;
	b=flGaxOmcFl27upg0icKty+43kyxTA42YlmQ9MVtjSNyyGdJAj9bu3+HyXa9t7YUynrs3
	 QmMk8MdOIiCN+XD673ojIuFvDYohwBjjOrtCoyZxqQr6LR5YQ9kmRfaU3LkqoJTXKuK5A
	 gnF072kXzlLwK4Vj2TbOHRyfCAJS5HjV2adpIvtUES7SbUpfiqT0qFFzu2gX7/3Tyvzux
	 H6zfxxS8ctQb+jiUqOs5KhT23sfIaKTf3p9d851yTqohRutQAnWvlYruuOhTQU7d+fsXI
	 bA8PorR51Cfr1NNEAbKW1rRPq/+HKy0YCXUPcMlnd851u+K7LjsrA0x0eSUgStLLfSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="J+KcM/FO";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.138
Received: from mail-yx2-f10.google.com (mail-yx2-f10.google.com [74.125.224.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8D606A31C
	for <linux-acpi@vger.kernel.org>; Sat, 28 Nov 2026 09:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09A8D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J+KcM/FO
Received: by mail-yx2-f10.google.com with SMTP id 00721157ae682-8b2fa622fddso21039297b3.0
        for <linux-acpi@vger.kernel.org>; Sat, 28 Nov 2026 01:56:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795859779; cv=none;
        d=google.com; s=arc-20260327;
        b=KjcoVVoxBOLRxHmRHnmt+Wze2CXY/3cXgNRAEbb8t4pMV/T/tVgewoUewrucNG7xgz
         0hXj6Aml7EBRgfCeanMIN4u1+NWyAl/xGbysjz9qQu5fub3N3GrynA4f1ByL6qgkipfo
         whxlwxOp1ej30+uYFp7iXGu0l+eBm4shzLoX6u6O2thKpcC9SnHvVtal8tYb6BRXoIO/
         lCWQZPmqT/TTjonfIav9+1UEnPq0RytzCcgbHy10I8Ga5oQGFBe9TBUdO6kmstv0ArSW
         DESzKUZge0s+boRZ5bDqorvL+CUBw/2IHSNHHNw8emzwNalfiGJTYfGIGLt70KYHCfBr
         4SqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=W6VYQXUuMNet9TO/oFD0qhwG1QVrLrv0K6QiopT3mtY=;
        fh=6HWioG9/nCsiDskh/DJRvUurRG1gA6jg1BPaGRs9BP4=;
        b=VZUEaB/sybG4s9cF3LZb9I8ewrbnYuEPZug5nb60VqhOdG05xwFn8YvXzi5U8QR3hA
         Ac5O7SkZvYBZQ+YAuagsZ3hlrw25PsZRHEH2eI6Nkz2wXaMZrdduzw4FrqJgY4uLfH0i
         nFWav1FDpd14mRvcBVWoABULnUXmV3BkMu3q2GK5JihwJ6uYWORI2xYuT1lTF+DT+N+B
         qd9wFmtI4l2jtiVG/yTwjg9j/rWW6rpjlpaaQWlKJVKNbOaNd8vlx3xWrV0whxb5cU5/
         ef+n2EucqZ5+QiqbBOjf0688gUGxs4ssUVaGQ6M2DL8dfaEaor6639Ox2wVIJ167x2mw
         NX+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795859779; x=1796464579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W6VYQXUuMNet9TO/oFD0qhwG1QVrLrv0K6QiopT3mtY=;
        b=J+KcM/FOvt/EvQvnED2+wg2AQuydAPHsZ/vmGYExQWTqok8Yv7TUqoSXMdW2ZiYlkI
         kjHhF99H3BiEWEFdHvwsjyuz+eulcyO8opooFO1xf7tiCnl4hQB1QZUFEWpQDfaNEUhj
         jWIvoHVgepc8HMwNQTex/ctdktWqZpfKXL//3cgaVacEBICmU9O2Z1DUkXoXZC7o5Tpb
         eeDNXVuB7FAIpzmywT0xNuCIOKAG30LecXxZZX0A5/fL2D8bzUr78tn0OhjmXKJnB3cS
         RBSsdjITxnw6an43nNPM3vNuJnC3Vnm8ML4+VYv51M8d8jssE2fRtCNTfJh/5JF8yPc9
         9tkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795859779; x=1796464579;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W6VYQXUuMNet9TO/oFD0qhwG1QVrLrv0K6QiopT3mtY=;
        b=kVOCPD9FG92jAVLBemnqhKANm7p8MTLLeE3Q6pUThWBKRQ87k0VPLqqXljDzJ+iy1B
         2JPDw/Iwe1rlvn8MJusypJTmq2JjxH96/X+iVSE44jozGJma9XniznP+2Zq5r95+d23/
         kG+OcHNG8BhPywjF2q4rJqLSv5z2pqoyjlR6EzfWbD3FxaLQ++/3d0tMmqLREqxYUV/u
         /WGTPiSB24UP5/nAsf/8z08rkq4JYv4cdkAup0og0fMygRXlRcwpgclkrjNhQuS0XXZQ
         nzzTQFKpknVKTm4FXi0tS9G0yFHQJTIS/NEYvgxnFWjuelD7/KFgFb9WwVbuUbMgHybY
         SEEQ==
X-Gm-Message-State: APuU4Z84E7AqYDyBqBlsw1FlWG7OG1HXQCJroxyIIdu/+FlOnrA2hMc8
	Ku67ilN5nQf0twf4akMHG2yZFjRvlTTnEqZQnZYqQdUhGsmIhyo1GSUxpj7Y6cBbqtia/h6ck15
	DlCL9HzhuL67wIYJ1pakOqvJijIuxFZ8xwjYvogrhfg7vaa0=
X-Gm-Gg: AZFdTZeYARDHqR5JVKzgKwBvZuoL/QHWkIFQIY24RSw0UaosahXqzcIEJ5W0t8g7FAL
	7wOGHtHZSKjX6scTBG+n0GDh4ZE+9ATNpiBdhDwk1/YBJWOzzpw9y78cHaFrjRjEpE41gzdKdVc
	FT1BAzOqveXkqfg+FqXMK4pm0dyJPs8br0qnYyJYjT3F0YkggM3v67/Y+3etk59D1IcAnp9hDCd
	IOZoDSmsRiv6XBLvJJWTop4v7f3WJeDTmggtxVOgIj0Dz2j1gJdqKKgCQsdW1kOP+3nAecE5Xfe
	8oUywteM1//8+H5dFHXlc5CsTrxSGqdxiksH9URTFezbuh1grobZb4ZIsFHs5ppodQRJTx78uFj
	o6oTVE1HaYR/N+8iz7X/iCfgqb504vI9iQXdO
X-Received: by 2002:a05:690e:1188:b0:679:97d1:4378 with SMTP id
 956f58d0204a3-67df9f5f19fmr10281087d50.51.1795859778966; Sat, 28 Nov 2026
 01:56:18 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: abu naser nayeem <abunasernayeemm@gmail.com>
Date: Sat, 28 Nov 2026 15:56:06 +0600
X-Gm-Features: Aa3M54qf4xorV5b39SFPbrzuV0i62xVRkgY-twqAg2FRzbLULxEppfS74zV0F_4
Message-ID: <CAPm+oWq4iuc2PZYq3Pc2Tuv72_Nnn36pZEUG2ojTV9_C_bdWSg@mail.gmail.com>
Subject: [ACPI] HP ENVY x360 14-fa0xxx: HPQOEM thermal zone findings and
 request for review
To: linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, rui.zhang@intel.com, lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello ACPI maintainers,

My name is Md Abu Naser Nayeem (GitHub: MrEchoFi). I independently
investigated abnormal ACPI thermal behavior on an HP ENVY x360 2-in-1
Laptop 14-fa0xxx (system board 8C69).

The initial discovery came from my Grafana monitoring setup on Omarchy
Linux, followed by kernel-log analysis, ACPI table extraction and
disassembly, and Linux source-code investigation.

My findings include:

1. TSZ0 =E2=80=94 Critical threshold

The HP DSDT defines:

Method (_CRT, 0, Serialized)
{
    Return (0x1388)
}

This represents 5000 dK (500 K / approximately 226.85=C2=B0C).

The inspected Linux ACPI thermal helper accepts trip-point values
between 2180 and 4480 dK. The returned value is therefore rejected and
replaced with THERMAL_TEMP_INVALID (-274000).

The corresponding firmware warning was reproduced on:

Linux 7.2.8-9-omarchy

Linux 7.2.11-arch1-1

2. TZ01 =E2=80=94 Temperature method

SSDT26 (OEM table ID 8C69) defines an empty _TMP method in thermal
zone TZ01. Linux reports approximately -273.2=C2=B0C for this zone.

I am treating this as a separate finding requiring further runtime
investigation.

Related upstream history

I reviewed Bugzilla reports 218652 and 218586, including commit
8a4ff545, "ACPI: thermal: Register thermal zones without valid trip
points."

I understand that the existing upstream fix permits thermal-zone
registration despite invalid trip points. My tested kernels register
all three HP thermal zones, so I am not reporting the same
missing-thermal-zone regression.

My questions

Is the TSZ0 _CRT value of 5000 dK expected to be rejected under the
existing ACPI thermal validation policy?

Is there any reason Linux should handle this HP-specific firmware
definition differently?

Would the TZ01 empty _TMP method warrant a separate ACPI investigation?

Should these findings be tracked as an OEM firmware issue and referred
to HP, or is there a distinct Linux-side concern worth reporting?

I have prepared a preliminary investigation report containing the ACPI
excerpts, kernel logs, hardware information and source-code analysis.

I have not yet reproduced the behavior on a vanilla upstream mainline
kernel. I am explicitly not claiming a confirmed Linux kernel defect
or proposing a patch at this stage.

Thank you for reviewing my findings and advising on the appropriate next st=
eps.

Best regards,

Md Abu Naser Nayeem
GitHub: https://github.com/MrEchoFi
Email: abunasernayeemm@gmail.com
