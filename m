Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B81342173
	for <linux-acpi@vger.kernel.org>; Tue, 11 Aug 2026 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470536; cv=pass; b=ua8sVNwM9KbN5Jria31K7jtFBsOP5T66CiOh/Z2nQx5qgHkh4Yrn7TrFATUnFpqxBov1Pl+bpty1hXUrLlJXCgIc1KQg/2vh0FwgogMU/vD3fi/cewHHBRvlnSlHWhBQIRwTOfeLarw3zPcjGZNLRdtioVDVgGvN8+v2TL8gRnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470536; c=relaxed/simple;
	bh=BqNWTUXM9e7/BO1hpy4zRkha0uXwUbaVuncC+YsZIj4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RUK95Wgx//sKXRganehvCV3UjkRFhaY2jSCKy1n3C9XG9ZCGSuJY9t7kLEE82rFloSkL41RsbP7RgTOLKsC0WM2jrfNfA4IHXxhOvHGPu4U+6BfcwYwCmj0jyuHwZb9beiWK0PYKJlwQ8mclehlDhGTdsuViJogp64c0k9NQZvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hb8jBgQr; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hb8jBgQr"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cfff5f88dbso2649885ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 11 Aug 2026 10:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786470531; cv=none;
        d=google.com; s=arc-20260327;
        b=SvPGTKJCtapj/R68qI9mvcHAESe+ndkt5zZIxv7XNpUBKEqdo0CcsfL8iGHZBqmKx+
         UBPRfYS+VINrbiALiTDAS+18KyOoSx+gqgBq4l5mH7EsMJ9Npkph3Zmy3uQcupCHXEbM
         qZWxBgIn/AinR/VzhOA9ftN2+v24RM8eIiVoeIWgln2RjyQjFr+/xx8pCdK/xvgJaI/X
         kWpFgSqNZemqD3j+lOfpWX8qnvmz1w8m9loZP7oQBvIGHnVO+JyquMHqtFqOzGDUJAmq
         nQwiH8pgQlRJVcijLPv1gn8J+htWd5wC4oKhPcEXOqVsReGDfAzs7YKY0d4aezmsOw4d
         jC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=hPI8No3Szk6tFgUBx21wYqQGiHOl+gcefC1B92Hy5ng=;
        fh=zerdORLIW5f1g5D4qUvzuAGEQryHaHZWUKLdTpNFR44=;
        b=DAKxu6FlWQNdCaqJtPSObLSeZKtG0uB/4wEnOxMS4kdXDjDuW8kASGjUV2nUEq0nSv
         6TyPsjI4abowPvA41aukunWsw+a4cTFd3idaHUdkAWppwqscE0QrX/W9CKTKsNhYjsE7
         Q3Oprwfzy6+fLX0MmRA2Wv7fFQwdD98L+Qvhgfn+4wt7HkBEdxSwNM5NY1H3H3Z55qI+
         5ViVAYq2llN1M7RdEeLWiGkfVaxlDdjw1hmFdVN+ztqOPqHWkAe57cqvcSSVCBoqqryR
         aJe/oV9ugPfdU3UcsJHjcJc8iOxzCUMVhJ7rlug5xM7z/G6kWlX6b4F6VskuT/kg3w9x
         Hyfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786470531; x=1787075331; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hPI8No3Szk6tFgUBx21wYqQGiHOl+gcefC1B92Hy5ng=;
        b=hb8jBgQrzPRF2Yonpav9TSee9eSKGOlUiZ/C14crbOlilsbjoHKd7GoKr2y8yR7TZr
         1tCWWRgQdqJeaEzXbMK2EKUM8MaVUX37DzOzYZZYjoigAzkSO/ycGt7GqBS623vqUs0Q
         kHfbBBOZ0BFahPPbNYKblwvDgFNHdrSdz/LuRhauyLW/veKN6i+1t8FvMF9t6MrKbSjg
         4AMoL+n2zt+WpxJK8TFmGGGGl7EgJhJ+s5AMyY3jscCE0HmbfbixWR1AsqOoAmqtzT75
         XKDFqL0ZkiSsdfsBC9uKJmL7ajlMLu/CvdkWW02Ur+smSoKSCExhqjDo+V8oJhZ/XCXs
         +4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786470531; x=1787075331;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hPI8No3Szk6tFgUBx21wYqQGiHOl+gcefC1B92Hy5ng=;
        b=KXgnimyczP8KZ7AmCW5xkfUIob6QCsNbLcirKQ5M61dDAexW0Cj+ChbdFlswKunz9O
         ed08JR2UbcKMKdlGcm8QNGacdFqaUqUyVgh1lfYRnQRNFzWPz8QlcyD2v3c0XdNk/K5G
         is50OhREQgoUd4x5+lDURFufGYUmnZ7FKF5fbx5A80G+SRtuQIwwo5tXILTBTXBTTPzT
         cXUIDaglDJmrhnoXhP5fY/DyjUwPaDtEs59C+y4mVV/nprOJWmzjQ+utMZXY3Yfyd/kG
         JukbUzvOpm+9WgCv37CN6U/SFXTll0tzgVwx5tiSPsPV1CHQmOAMIWt0fqyJoXJ3lwXk
         8OpQ==
X-Gm-Message-State: AOJu0YyQayl9i0cElZVPXfM2o+6P3AJrZCNlJ5IOC6/qxwTPcbcOwyiC
	JQtQ6TBhGVFmGbSltYWpkSYUAN83G4viSm+jYFCRYZwe5awFthIWqBzB6khhHyVVBkbQubpHOOQ
	bCEJfdNkpubSkt4iDbFGpOuEK348I48zoBpH8EUaF/A==
X-Gm-Gg: AR+sD13PThcb/slFFS5YDDf5uJa70w2cpNlkqWJBAQEx9Mc2pkeVynOvRPNjoxY/aqp
	CvI7IlZUZN+rEsXza7hCbSZYEd6wf4lZvWTsUd1G0RtGg+wbgDgBpyPME5NziB7H7sR/CkPtc0r
	tHiypFkz+aMmB9wp6NhXs6fmYYOzQPFypTNS7e3O23sImGfzh/6cVBGp0//gJnEeuTZjz2z2sj9
	3o0GzrxMvtBnKTXjjap5fSWap3T9NGgc/shQujTdHJjrrilS/6SxmLHoI951RTYtgBIEWw5W0lC
	v8GA7sv0ZHMgcDTtXC3mqrLeNNSCrENa2UzKxzGgpitcKFQqlFRCL2Xv7VMTG8akxBRgEwFTgi3
	5fU8=
X-Received: by 2002:a05:6a20:cc8e:b0:3c3:b57b:627d with SMTP id
 adf61e73a8af0-3cc2b84c686mr7112064637.12.1786470530983; Tue, 11 Aug 2026
 10:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Del Sol <daviddelsol1998@gmail.com>
Date: Tue, 11 Aug 2026 12:48:38 -0500
X-Gm-Features: AUfX_mylvDwh_yZECELkBWrNgiJwCpIE2OQm3NZplNe3TDy81bzh6BRLcSQZXAg
Message-ID: <CADaJo4UrmNbPPxnnt0tjpdTuxK5wQdhS-0W=rAdLAC_++Vp47w@mail.gmail.com>
Subject: [PATCH] ACPI: OSI: Enable _OSI("Windows 2022") on HP OmniBook X Flip 16-ar0xxx
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org, 
	mario.limonciello@amd.com
Content-Type: multipart/mixed; boundary="000000000000673c9b0658c91588"

--000000000000673c9b0658c91588
Content-Type: multipart/alternative; boundary="000000000000673c9b0658c91586"

--000000000000673c9b0658c91586
Content-Type: text/plain; charset="UTF-8"

Hi all,

This fixes slow battery charging on the 2025 HP OmniBook X Flip (AMD Ryzen
AI 5 340, DMI board 8DA8): with a 65 W charger plugged in, the battery
charges at only ~0.2 W on Linux instead of the ~30 W Windows gets.

The EC firmware only enables normal charging when the OS claims
_OSI("Windows 2022"), and the DSDT/SSDT only check up to that string.
Linux's default claimed OSI strings stop short of it, so the fast-charging
branch never runs. Adding acpi_osi=! acpi_osi="Windows 2022" to the kernel
cmdline restores 31-33 W - verified across multiple charge cycles on
kernels 7.1.6 and 6.18.42-LTS.

I checked with HP first: they declined in writing (warranty case
#5163282638, supervisor email 2026-08-10), saying the firmware is
"specifically manufactured and optimized for the Windows operating system"
and not supported for other OSes. A kernel-side quirk is therefore the
only fix path.

The patch claims _OSI("Windows 2022") via acpi_osi_setup() with a DMI
match scoped to board 8DA8 (same mechanism as dmi_enable_osi_linux), so
no other platform is affected. Full evidence - DSDT/SSDT strings, EC RAM
dumps, measurement logs - is on the bugzilla report below; happy to add
sibling boards as owners confirm.

Thanks for looking,
David

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221866

--000000000000673c9b0658c91586
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<br><br>This fixes slow battery charging on the 202=
5 HP OmniBook X Flip (AMD Ryzen<br>AI 5 340, DMI board 8DA8): with a 65 W c=
harger plugged in, the battery<br>charges at only ~0.2 W on Linux instead o=
f the ~30 W Windows gets.<br><br>The EC firmware only enables normal chargi=
ng when the OS claims<br>_OSI(&quot;Windows 2022&quot;), and the DSDT/SSDT =
only check up to that string.<br>Linux&#39;s default claimed OSI strings st=
op short of it, so the fast-charging<br>branch never runs. Adding acpi_osi=
=3D! acpi_osi=3D&quot;Windows 2022&quot; to the kernel<br>cmdline restores =
31-33 W - verified across multiple charge cycles on<br>kernels 7.1.6 and 6.=
18.42-LTS.<br><br>I checked with HP first: they declined in writing (warran=
ty case<br>#5163282638, supervisor email 2026-08-10), saying the firmware i=
s<br>&quot;specifically manufactured and optimized for the Windows operatin=
g system&quot;<br>and not supported for other OSes. A kernel-side quirk is =
therefore the<br>only fix path.<br><br>The patch claims _OSI(&quot;Windows =
2022&quot;) via acpi_osi_setup() with a DMI<br>match scoped to board 8DA8 (=
same mechanism as dmi_enable_osi_linux), so<br>no other platform is affecte=
d. Full evidence - DSDT/SSDT strings, EC RAM<br>dumps, measurement logs - i=
s on the bugzilla report below; happy to add<br>sibling boards as owners co=
nfirm.<br><br>Thanks for looking,<br>David<br><br>Link: <a href=3D"https://=
bugzilla.kernel.org/show_bug.cgi?id=3D221866">https://bugzilla.kernel.org/s=
how_bug.cgi?id=3D221866</a></div>

--000000000000673c9b0658c91586--
--000000000000673c9b0658c91588
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ACPI-OSI-Enable-_OSI-Windows-2022-on-HP-OmniBook-X-Flip.patch"
Content-Disposition: attachment; 
	filename="0001-ACPI-OSI-Enable-_OSI-Windows-2022-on-HP-OmniBook-X-Flip.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_msoy28gd0>
X-Attachment-Id: f_msoy28gd0

QUNQSTogT1NJOiBFbmFibGUgX09TSSgiV2luZG93cyAyMDIyIikgb24gSFAgT21uaUJvb2sgWCBG
bGlwIDE2LWFyMHh4eAoKVGhlIEhQIE9tbmlCb29rIFggRmxpcCAoMjAyNSwgQU1EIFJ5emVuIEFJ
IDUgMzQwLCBib2FyZCA4REE4KSB0aHJvdHRsZXMKYmF0dGVyeSBjaGFyZ2luZyB0byB+MC4yIFcg
b24gTGludXggYmVjYXVzZSB0aGUgRUMgZmlybXdhcmUgb25seSBlbmFibGVzCm5vcm1hbCBjaGFy
Z2luZyAoMzAgVywgbWF0Y2hpbmcgV2luZG93cykgd2hlbiB0aGUgT1MgY2xhaW1zCl9PU0koIldp
bmRvd3MgMjAyMiIpLiBUaGUgRFNEVC9TU0RUIGNvbnRhaW4gZmlybXdhcmUgT1NJIGNoZWNrcyBv
bmx5IHVwCnRvICJXaW5kb3dzIDIwMjIiLCBhbmQgTGludXgncyBkZWZhdWx0IGNsYWltZWQgT1NJ
IHN0cmluZ3Mgc3RvcCBiZWZvcmUKdGhhdCwgc28gdGhlIEVDJ3MgZmFzdC1jaGFyZ2luZyBicmFu
Y2ggbmV2ZXIgYWN0aXZhdGVzLgoKQ2xhaW1pbmcgdGhlIHN0cmluZyBpcyB2ZXJpZmllZCB0byBy
ZXN0b3JlIDMxLTMzIFcgY2hhcmdpbmcgb24ga2VybmVscwo3LjEuNiBhbmQgNi4xOC40Mi1MVFMg
YWNyb3NzIG11bHRpcGxlIGNoYXJnZSBjeWNsZXMuIEhQIGhhcyBkZWNsaW5lZCBpbgp3cml0aW5n
ICh3YXJyYW50eSBjYXNlICM1MTYzMjgyNjM4KSB0byBwcm92aWRlIGEgQklPUy9FQyB1cGRhdGUs
IHNvIGEKa2VybmVsLXNpZGUgcXVpcmsgaXMgdGhlIG9ubHkgZml4IHBhdGguIFNjb3BlIHRoZSBx
dWlyayB0byB0aGlzIGJvYXJkCm9ubHkgKERNSSAxMDNDXzUzMzVNOCBIUCBPbW5pQm9vayBYLCBi
b2FyZCA4REE4KTsgc2libGluZyBib2FyZHMgY2FuIGJlCmFkZGVkIGFzIHRoZXkgYXJlIGNvbmZp
cm1lZC4KCkxpbms6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9
MjIxODY2ClNpZ25lZC1vZmYtYnk6IERhdmlkIERlbCBTb2wgPGRhdmlkZGVsc29sMTk5OEBnbWFp
bC5jb20+CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL29zaS5jIGIvZHJpdmVycy9hY3BpL29z
aS5jCmluZGV4IGZmZGY1MDQuLjhlMmIzZDQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYWNwaS9vc2ku
YworKysgYi9kcml2ZXJzL2FjcGkvb3NpLmMKQEAgLTQ2NCw2ICs0NjQsMjEgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBkbWlfc3lzdGVtX2lkIGFjcGlfb3NpX2RtaV90YWJsZVtdIF9faW5pdGNvbnN0
ID0gewogCQl9LAogCX0sCiAKKwkvKgorCSAqIFRoZSBIUCBPbW5pQm9vayBYIEZsaXAgKEFNRCkg
dGhyb3R0bGVzIGJhdHRlcnkgY2hhcmdpbmcgdG8gfjAuMiBXCisJICogdW5sZXNzIF9PU0koIldp
bmRvd3MgMjAyMiIpIGlzIGNsYWltZWQ6IHRoZSBFQyBmaXJtd2FyZSBvbmx5CisJICogZW5hYmxl
cyBub3JtYWwgY2hhcmdpbmcgb24gdGhhdCBmaXJtd2FyZSBwYXRoLiBWZXJpZmllZCB0byByZXN0
b3JlCisJICogMzEtMzMgVyBjaGFyZ2luZyAoV2luZG93cyBwYXJpdHkpLgorCSAqLworCXsKKwku
Y2FsbGJhY2sgPSBkbWlfZW5hYmxlX29zaV93aW4yMiwKKwkuaWRlbnQgPSAiSFAgT21uaUJvb2sg
WCBGbGlwIDE2LWFyMHh4eCIsCisJLm1hdGNoZXMgPSB7CisJCSAgICAgRE1JX01BVENIKERNSV9T
WVNfVkVORE9SLCAiSFAiKSwKKwkJICAgICBETUlfTUFUQ0goRE1JX0JPQVJEX05BTUUsICI4REE4
IiksCisJCX0sCisJfSwKKwogCS8qCiAJICogQklPUyBpbnZvY2F0aW9uIG9mIF9PU0koTGludXgp
IGlzIGFsbW9zdCBhbHdheXMgYSBCSU9TIGJ1Zy4KIAkgKiBMaW51eCBpZ25vcmVzIGl0LCBleGNl
cHQgZm9yIHRoZSBtYWNoaW5lcyBlbnVtZXJhdGVkIGJlbG93Lgo=
--000000000000673c9b0658c91588--
