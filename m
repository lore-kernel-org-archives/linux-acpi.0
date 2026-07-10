Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261573EF0D0
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671881; cv=pass; b=Td58UWcqmB60WuuGR4eHTBm+4OWFsTqQrNvNnqlpVROVoTLU2CvzEVt+YrwZW5tWzpnxFB+iez2KFP5dMRjoVo0NQ+Dd2MwO5cwUZ7B/XWvPe0U3DK+pUi2+ikzkh62bLV/4LUUw0FWhCdlI02A1mbPZi5hpAUGPvT5xJM1YC3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671881; c=relaxed/simple;
	bh=HFRxqkTILC1gTa2YZXlrdLlbvcZEhSZmE8LdUsNk7Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khx+8jJBu9j2nGjanIDEvOBtsjB2pMRl4EEgvq+8+VDAGtpOUjUXbmnHuFbPOEk9ykuEklfoSJ+b8dUHU8brkWZ5FbWU/o6n+Y57Foy4f3nZD53MMROoetWH604Z8HoXaHLxxvuHQ0rKt6YKl8SIBpOu0CYoosYo5dgT8iRTWA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKesCdPA; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKesCdPA"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeae350e0aso768113e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 01:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783671878; cv=none;
        d=google.com; s=arc-20260327;
        b=o3Z8J3g1gmseDlYFk06FJ+rFqsrpZr440ji2WZX5XSq5f9YZkyMB7r3rwzdb24hGEd
         jDQYs2MDIxT/YqypbFPUexak+zkFvNdKlxSt6Z9GnSbCxqFnB8HV9tzZkMwJjgdRLirL
         YTY1xe3+yoblvhNirKthUa00Sr1QZEQw57sABCcpZKSVFe5+yQJ6yox31/FqUB8zAJX+
         8D8IdtOiwRG2PKPEytkrUEtHDfSNJGEzYxTC67HMD6ufC4jFOASbCm5/WGZ80TcPUQLp
         +/e+HJhkFGDjTQerHa+FqrALypXoGu0ly9rCAYpxuIGP+D5v9OFHpfWHSdGPPlmSJO2A
         +ucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xgYmC/leQRqXDMOV+U09FDj6ipD6P/O6AkutlI1vKbo=;
        fh=WURvFtK24b6OBXQPzvcb8UTHxC0N7XXrffzMicH6vp4=;
        b=LIBxgz93Zei4wWQSyU55QYhsPKdQbPLR2/IFEdbJrvNx1qKRcNsPr7PXXQmfeSwOZZ
         p0dvCWBbmGygFerSN3A8zc0Bfyj0i8h7ACs1A8fGM6VD+0Gl+jsaAfxHSO171tj3PhR8
         5kDG3VxKOZ4DuNlB2RpGYBzjHwxz19nroYpGoWgSL4oNQqY5YJaMjzTONLvJd3SCUmOe
         9pYD0soDKucdqCmurpNeQevRPzYqHjbQVt6e9SdMikFBNLin6Jm9Z9sxLOUdxUXRk2y+
         JBeUSiQDVYzHoCkaym8dfAELgc/05lQMkzY1nYrzKhlbKkp2mNcVpO6HSd0PEDT6qjmh
         ocMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783671878; x=1784276678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xgYmC/leQRqXDMOV+U09FDj6ipD6P/O6AkutlI1vKbo=;
        b=EKesCdPAaMSxBGa+Xno06lngrxbiLCTdATP428lvNntbiY755dAR6BHmFvSYvgwUkr
         uoFg/ys7wUCRTUDg/I3mHpjI3Z8XSqiuvtsDwhI7nh+U47GfldTg+NMDp3hESwMTyA0+
         YhExn4R2R+HzuH7DXG6L6hdXeC8HwDXoSgI5sdMtiQH1CYeR2oLfUWjmpJp0MBe2cBPk
         G94W7hLekDfsABMqCfr24vdzorD1BjB2sGXqUUw7ICGA5WQxIWd6dXpATZGEzTKqN5/8
         /Z4MCeTClPzZAoDQDE09tyPsXr2C2nr97vEK/+HA0G9eMFRzke2LdUtsuCh7bWPOv7Ix
         A4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783671878; x=1784276678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xgYmC/leQRqXDMOV+U09FDj6ipD6P/O6AkutlI1vKbo=;
        b=EiBfjPYn1ErUnF/s4rQLNev/KRIgEIvZP9SkFQcW8UkssF2gbsV9Ksc6ZBsLo0vCt4
         fTiA5obHShhftGVH/E9ww2Rk4dYa/pC5Zs2pDTVbK1dO+B59sRsPF5r1PqkSg2qEjUMF
         W/4xvUSjrRhSjo5uqNLic2klAHhthTWkuG1/y/4TZ4Jz7H9B5waHeYbbfOf0Q/gC3/OW
         Kmwbqu7ZHwaJiF8A08ht6wMiJmwS4ITzmG/jg7votLgG7/C31+8yLlzs6t0YzdFdMZS0
         uuO3I9h++hg6/h8MXcZKfl8eIZvUAMexB/uQ7AnlQEYErjdJpPR8WdceoNKrV5INohe0
         g4PA==
X-Forwarded-Encrypted: i=1; AHgh+RooH18Pk+0dW/BA1MPko3GNP6+7QDyJYJ84w1pyJplHGiptQmSDGSGnOTmevsAurDYBXVLVvIWT0zUO@vger.kernel.org
X-Gm-Message-State: AOJu0YzMavO7fp3HRzShsHTRDLKdwN+atgW/sYSmHzJOwY8dW+wO1/BW
	T/W3lVTgoyxUxua3zOQ54M0QJ/7VMvywmrK73K53350IcFaezg2J4Qv9X986EdJWVkEA5vs4/MC
	lRGvI3/v0N1uH0AWu1Q90a10A+2uRITk=
X-Gm-Gg: AfdE7cmww+sI/XxKz0PIqmg+chU2blCtSnvYj8ioa/0Sb/tLJc87rsTEioolBValKYW
	385BePBgkqAFZRLB8KxO9kZFOgVXzncA4OF1Lljux+3H1naksp35dict/VKcqHz0yAoGZU8VmYb
	PWGkAcJPC/qkvwOWTzpQwdij1wgWssvX5Ym/mirbz3u8bpxCnpQruDz9wG0RG1c+2Uwr6RDbRrX
	GBhZzdbFkRVhiMfl1H+4y7hAEZWjaH/ZxW5CQ2YDXJPuq94Dt+9cZc8+h8Mskzc3Us7H0az9VTt
	GKAB
X-Received: by 2002:a05:6512:4507:b0:5ae:b764:3ba5 with SMTP id
 2adb3069b0e04-5b01147fbadmr2335281e87.64.1783671877994; Fri, 10 Jul 2026
 01:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709021504.465792-1-vishnuocv@gmail.com> <239c8162-e1e6-4b49-8292-35547c5a525c@liuxiaozhen.dev>
In-Reply-To: <239c8162-e1e6-4b49-8292-35547c5a525c@liuxiaozhen.dev>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Fri, 10 Jul 2026 17:24:00 +0900
X-Gm-Features: AVVi8CdJHOTuRUbVyX9EDCsmYkHyncA5b_--6_5gEe0H34M3a0_AcbJco12MIH4
Message-ID: <CABxCQKtAYt7heT8a+GknA_4n+znA3+-=eRzuuky1RTLO+KNK0A@mail.gmail.com>
Subject: Re: [PATCH v4] platform/x86: thinkpad_acpi: Add USB-C Security (USCS) support
To: oliver@liuxiaozhen.dev
Cc: platform-driver-x86@vger.kernel.org, mark.pearson@lenovo.com, 
	linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, 
	vsankar@lenovo.com, mpearson-lenovo@squebb.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oliver,

Thank you for testing and reporting this.

On systems where the USCS ACPI method does not exist, acpi_evalf()
returns AE_NOT_FOUND which maps to -EIO rather than -ENODEV. This
causes tpacpi_usbc_security_init() to propagate the error and
thinkpad_acpi fails to probe entirely.

Apologies for missing this =E2=80=94 I only tested on a system that has the
USCS method present.

I believe the fix is to check for USCS method presence before
attempting to call it, using acpi_has_method() which is already used
elsewhere in the driver for the same purpose:

  static int tpacpi_usbc_security_init(struct ibm_init_struct *iibm)
  {
      int err;

      if (!acpi_has_method(hkey_handle, "USCS"))
          return -ENODEV;

      err =3D usbc_security_query(&tp_features.usbc_security_enabled);
      if (err =3D=3D -ENODEV)
          return -ENODEV;
      if (err)
          return err;

      tp_features.usbc_security_supported =3D true;
      return 0;
  }

I am expecting this change to fix the issue (not yet tested).

Ilpo,
since this is already in your tree, please let me know if you would
like me to send a fixup patch or if you prefer to handle it directly
or if you prefer a v5 with this addressed.

Sorry for the inconvenience caused.

Thanks and regards,

Vishnu

On Fri, Jul 10, 2026 at 4:52=E2=80=AFPM Oliver Lin <oliver@liuxiaozhen.dev>=
 wrote:
>
> Hi Vishnu,
>
> I tested v4 on a Lenovo ThinkPad P15 Gen 1.
>
> System:
>    - Lenovo ThinkPad P15 Gen 1
>    - BIOS: N30ET47W (1.30)
>    - Kernel: 7.2.0-rc2 + this patch
>
> I checked the BIOS setup and could not find any USB-C Security (USCS)
> option.
>
> During boot, I get:
>
>
> ```
>
>    thinkpad_acpi: acpi_evalf(USCS, dd, ...) failed: AE_NOT_FOUND
>    thinkpad_acpi: required events 0x00720000 not enabled!
>    thinkpad_acpi: probe with driver thinkpad_acpi failed with error -5
>    thinkpad_acpi: unable to register main platform driver
>
> ```
>
>
> As a result, thinkpad_acpi fails to probe and
> /sys/devices/platform/thinkpad_acpi/ is not created.
>
> It looks like systems without the USCS ACPI method may fail to load
> thinkpad_acpi with this patch applied.
>
> Please let me know if you would like me to provide the full dmesg log or
>
> test a revised version.
>
>
> If needed, I can also test on a ThinkPad P50s.
>
>
> Thanks,
> Oliver Lin



--=20

Regards,

      Vishnu Sankar
