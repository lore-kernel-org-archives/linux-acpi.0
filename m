Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE533C1D62
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507091; cv=none; b=rn7/lvWIvMrYM7mWO6d71xMV4MnfsWjXvWt+K7NjSaJMikm+TyXRWvwce3hHOp/1UYWfePTu8dLM23k034kFPap7nkn8yAEFEJWHMsQcQl4VBnTD8gzit5xRBu5S35/W2jSZxkMNgNPvYptH5G90TK937zqfdaUGtdp2b2uB0IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507091; c=relaxed/simple;
	bh=oIVl5yyHOkMyIiFF5gmsaRw5ciJSHoF8XouXPm/HEMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/tfCBtvBQtncklu7NBZSwwoPWjcutX8LEGgqmzE6v26gtl/8N6Bg+FOK1twfdD1dIgkvpXGLg8fB6un+1cy5EOCR4Cs0G8Rx3Zm5TOw86677WTgJUtjRzhktJf1ECy1vwmvOZJW5aQ1uiWawxZLW3foplJsqIEqzTo3vIAhRTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgYxoHx6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgYxoHx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1651F00ADB
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785507089;
	bh=3JvgrBY/v0Fqn3lj+FFekrTPJNyYtfXsLxJttJF3czs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BgYxoHx6T3dVZjSSWGmyAc3CXqR2OE9px93Ar60YItANMTGBw9RysfVuSSdcQFvvJ
	 cYcWqkHPkaIC7wpOFKHQ9YAbjv/WFkOh/JXI4yLiLEowhr+eecZgfyfPAPzuVY2aT4
	 kCbDN4q1BlE6LSqSgZBhfFwMNh9Wrs6Xqm6GIOPU4Ljjatat84vgdtqRH3BuBVB9cj
	 ZnNBXUXrjyIZmojqpXVZCKnheokrr7N7YORjFCyGYTEqqUfnb8x20dlSR5wdpZT78h
	 M34g3HRuREFQ1V8ORg1sX9o/qr1fiAAUP0Emgi93sIXNABAe8plo7wHg14bvf5xKnj
	 sJMWG7pRANz3Q==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aec201b582so978405e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 07:11:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrSZbxWGolTE28CDhpuJQLm6RV3lETRLW0hI/0YCkt+p3YOJ1wx6cPSSMarDccC3Phhv4CxuPlG5Ofg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Yio6b+1Lzm/zmdVWInRH8zYGhS68VKqcKoP8z+nM4j1tMGBg
	JHcAsQ6adX+kft3EHtZwDwZEES3JrawRDkZmlZxu298WOicgu8m6LIyioUnKHMX7j9AS5jwRSG9
	jtfSvsc0U32ZeE6kppy6qk6nVM37522o=
X-Received: by 2002:a05:6512:114b:b0:5b2:8c97:b50d with SMTP id
 2adb3069b0e04-5b2e1fc973amr512873e87.4.1785507088233; Fri, 31 Jul 2026
 07:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3353bdf3-4f33-44b1-809b-b0378bee5816@gmail.com>
 <CAJZ5v0h1kqDEBYk0k05rv6f2SJ7g+TN4FhBDJYZSVUctu-0FdA@mail.gmail.com>
 <daf0bb9b-246d-437d-87ca-16706113b201@gmail.com> <CAJZ5v0jByxtQ2tmNm_ZyyBnDMBNjuqQwD_367NRyGNzF7wQtRw@mail.gmail.com>
 <7792f017-42b0-4a09-9941-5259138e21b1@gmail.com> <CAJZ5v0jCFFNuG7WtCE2CG+hP=YNsYMdXH_945QgkgAUcr4Lryg@mail.gmail.com>
 <37daa35f-06aa-49d0-bf0a-1b5ac9f44c89@gmail.com> <CAJZ5v0jyy0+hqU3=gmBrgMzLBVhdUQwDj8d0_jGCqZwqyWT=_g@mail.gmail.com>
 <588c2e18-e6fb-4fc1-95d5-7a5dd0f556fe@gmail.com> <CAJZ5v0gXtKEaNDdSRqd57zg9GbFN-VDHrU5-=EEQPdSa9Zk-xw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gXtKEaNDdSRqd57zg9GbFN-VDHrU5-=EEQPdSa9Zk-xw@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 31 Jul 2026 16:11:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g4ctzLpEro2Mu7EbSo8RNmYUCM6+J2p_ExCXseQAx13Q@mail.gmail.com>
X-Gm-Features: AUfX_myW664gMqMcEBeuvJipnLG3Y1mOsLY3bnlaz8mTfvD7gvrst-uGLHH7cjQ
Message-ID: <CAJZ5v0g4ctzLpEro2Mu7EbSo8RNmYUCM6+J2p_ExCXseQAx13Q@mail.gmail.com>
Subject: Re: [REGRESSION] usb controller fails to initialize on intel s1200btl
To: Julian Silver <mendaxca@gmail.com>
Cc: rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, 
	linux-usb@vger.kernel.org, regressions@lists.linux.dev, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
Content-Type: multipart/mixed; boundary="000000000000bd2bf00657e8c3e6"

--000000000000bd2bf00657e8c3e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 3:41=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Fri, Jul 31, 2026 at 3:06=E2=80=AFPM Julian Silver <mendaxca@gmail.com=
> wrote:
> >
> > On 2026-07-31 19:58:32, Rafael J. Wysocki (Intel) wrote:
> > > Please boot with "intel_idle.states_off=3D16" in the kernel command l=
ine
> > > and see if the problem is still there.  If this doesn't help, please
> > > also try "intel_idle.states_off=3D24".
> >
> > "intel_idle.states_off=3D16" does not help.  "intel_idle.states_off=3D2=
4" works.
> > Note that the test is performed on vanilla kernel v7.2-rc5(without the =
patch).
>
> Yes, that's what I meant, thanks!
>
> The kernel command line switch that works causes idle states 3 and 4
> (C3 and C6) to be disabled by default.  These CPU idle states allow
> the processor to enter package idle states (PC2 or deeper), so what
> (most likely) happens is that the package idle states on this platform
> somehow interfere with EHCI probing (causing the latter time out).  It
> is basically a platform issue that was previously hidden.
>
> Note that you can re-enable idle states disabled by default by doing (as =
root)
>
> # echo 0 | tee /sys/devices/system/cpu/cpu*/cpuidle/state[3-4]/disable
>
> Before the commit in question EHCI was probed before the intel_idle
> initialization and so package idle states were not used at that time
> and before, but that was only due to the initialization ordering based
> on driver name (so fragile anyway).
>
> I'm not sure how to address this cleanly because moving the intel_idle
> initialization back to the device_initcall() level won't guarantee the
> working initialization ordering (for instance, if ehci-pci is a
> module), but let me send you one more debug patch.

The attached patch (on top of the current mainline) should prevent
cpuidle governors from requesting idle states deeper than C1E when
intel_idle is used until all of the device_initcall()s are done.
Please see if this helps.

--000000000000bd2bf00657e8c3e6
Content-Type: text/x-patch; charset="US-ASCII"; name="intel-idle-pm-qos.patch"
Content-Disposition: attachment; filename="intel-idle-pm-qos.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ms90p7260>
X-Attachment-Id: f_ms90p7260

LS0tCiBkcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jIHwgICAxMyArKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQoKLS0tIGEvZHJpdmVycy9pZGxlL2ludGVsX2lk
bGUuYworKysgYi9kcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jCkBAIC01Myw2ICs1Myw3IEBACiAj
aW5jbHVkZSA8bGludXgvbm90aWZpZXIuaD4KICNpbmNsdWRlIDxsaW51eC9jcHUuaD4KICNpbmNs
dWRlIDxsaW51eC9tb2R1bGVwYXJhbS5oPgorI2luY2x1ZGUgPGxpbnV4L3BtX3Fvcy5oPgogI2lu
Y2x1ZGUgPGxpbnV4L3N5c2ZzLmg+CiAjaW5jbHVkZSA8YXNtL2NwdWlkL2FwaS5oPgogI2luY2x1
ZGUgPGFzbS9jcHVfZGV2aWNlX2lkLmg+CkBAIC0yODIyLDEyICsyODIzLDE3IEBAIGVycm9yOgog
CXByX2luZm8oIkZhaWxlZCB0byBhZGp1c3QgQy1zdGF0ZXMgd2l0aCBkYXRhIGZyb20gJ2ludGVs
X2lkbGUudGFibGUnXG4iKTsKIH0KIAorI2RlZmluZSBJTlRFTF9JRExFX0lOSVRfUU9TCTIwCitz
dGF0aWMgc3RydWN0IHBtX3Fvc19yZXF1ZXN0IHFvc19yZXEgX19pbml0ZGF0YTsKKwogc3RhdGlj
IGludCBfX2luaXQgaW50ZWxfaWRsZV9pbml0KHZvaWQpCiB7CiAJY29uc3Qgc3RydWN0IHg4Nl9j
cHVfaWQgKmlkOwogCXVuc2lnbmVkIGludCBlYXgsIGVieCwgZWN4OwogCWludCByZXR2YWw7CiAK
KwljcHVfbGF0ZW5jeV9xb3NfYWRkX3JlcXVlc3QoJnFvc19yZXEsIElOVEVMX0lETEVfSU5JVF9R
T1MpOworCiAJLyogRG8gbm90IGxvYWQgaW50ZWxfaWRsZSBhdCBhbGwgZm9yIG5vdyBpZiBpZGxl
PSBpcyBwYXNzZWQgKi8KIAlpZiAoYm9vdF9vcHRpb25faWRsZV9vdmVycmlkZSAhPSBJRExFX05P
X09WRVJSSURFKQogCQlyZXR1cm4gLUVOT0RFVjsKQEAgLTI5MjIsNiArMjkyOCwxMyBAQCBpbml0
X2RyaXZlcl9mYWlsOgogfQogc3Vic3lzX2luaXRjYWxsX3N5bmMoaW50ZWxfaWRsZV9pbml0KTsK
IAorc3RhdGljIGludCBfX2luaXQgaW50ZWxfaWRsZV9pbml0X2NvbXBsZXRlKHZvaWQpCit7CisJ
Y3B1X2xhdGVuY3lfcW9zX3JlbW92ZV9yZXF1ZXN0KCZxb3NfcmVxKTsKKwlyZXR1cm4gMDsKK30K
K2RldmljZV9pbml0Y2FsbF9zeW5jKGludGVsX2lkbGVfaW5pdF9jb21wbGV0ZSk7CisKIC8qCiAg
KiBXZSBhcmUgbm90IHJlYWxseSBtb2R1bGFyLCBidXQgd2UgdXNlZCB0byBzdXBwb3J0IHRoYXQu
ICBNZWFuaW5nIHdlIGFsc28KICAqIHN1cHBvcnQgImludGVsX2lkbGUubWF4X2NzdGF0ZT0uLi4i
IGF0IGJvb3QgYW5kIGFsc28gYSByZWFkLW9ubHkgZXhwb3J0IG9mCg==
--000000000000bd2bf00657e8c3e6--
