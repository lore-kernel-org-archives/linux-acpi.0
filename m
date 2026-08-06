Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B5435EF2
	for <linux-acpi@vger.kernel.org>; Thu,  6 Aug 2026 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786010108; cv=pass; b=BK8HgnXNpPNfKiwiWTrnuwsafwuSHQMvjO7aA1LjIlghkbjY35J7NiGpbayQdQWtWcQPVg+DkiS/qZrXvF1Dkd60PyTL8u0l0ubF/12Ac7oBczHAnJqn8UZCqbcFIdOHncacriy2aSloLe9NeUlnRuZycr/6hblq4oX00DpD4sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786010108; c=relaxed/simple;
	bh=KTqd0lpP09EibOiKqFQAK/d7YclsTCvhaaQ0Bd3pIog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=my3uE9bziN3Kk48i44Z9szL++MXlecP3vnIHFOnjh5y7yDQnpfLOdV+rsom1UktA6IDGtQyESQIJlAXwPF+bp8DmuZXmQNfXalgL+ur8KMoSjo1uiv7sONicEVQCJ3Cyfn9b3v4muu4iS2c5WsWbfJt9UErD1mtyVVRGa3raSwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwqO0iw6; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwqO0iw6"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-667923d86a7so1434323d50.0
        for <linux-acpi@vger.kernel.org>; Thu, 06 Aug 2026 02:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786010106; cv=none;
        d=google.com; s=arc-20260327;
        b=MoAI9yV5agnQnPHK6aWj47NwNlfnWZ+hXgovNpqeESEB7xQALAzjnN/OPDxemKhnX7
         eIcWaZTUu0Xi0KkSkxGrPg8mCnZ71m3QdT8pqLCPqf7B2RmCuuA35E9FRNCdQMoGV9jl
         6ijWTwOAbN1rGDACEsKG7hKreFH4uY0yvCTATffs6fr3o7WY3UTuIZfvYKa3WtoWcQNP
         TAhrFbeyvAdxiJ1TFcOMp34YhEIeYp0OmnmQ9JiqOeXkUpAPlHSq32YxxDlpiaw+P37q
         qDLREwZtkgPQqWPhMfkf9q6XiJf9HIyOraNr192s9qA3V3oB73stFdpRhut7l4iau04H
         GwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KTqd0lpP09EibOiKqFQAK/d7YclsTCvhaaQ0Bd3pIog=;
        fh=XvA062WV5+Uye1em+ghdwVJcTPQ8fe19+qtvrBKLRqQ=;
        b=g/pD34S5wBqTiEhDx9jswi29oJy0bDT6sZflmA/9dhVftr9CcMAGAwSR/q1Faq0oAA
         ds0Hf5BxRW6n2mVaCv7aWUXDmTkHnaw/lM63FQwUUoLS3W+CfrzoulHuAqJFFJawXJCZ
         NYbersfFaS9jDGX/YcKkrR3I4w3M00EY3x9JVGtbnbbYV89rnlWms0uVg3fXmKN995b9
         uQFUaoljzOsiEp0s6aIPxTRoSF3Zc063U0zGABGrlvt30GZc6bS9Q3MUD+tQfHGPj5Ef
         SlbS9u/+a6kuipYOjCYwYFwqRpkbxwupKnw5EeEII4dDM+8T4Dwo/iKh+6YfUPgfrAqR
         cW9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786010106; x=1786614906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KTqd0lpP09EibOiKqFQAK/d7YclsTCvhaaQ0Bd3pIog=;
        b=PwqO0iw6b6mUSTq5Ob4Oag4vKZjUltAV+05UqIPYGIoayxRy3bBZTX092lRhOTZeU5
         g3UuEUuQCt5svZOqwDzijyiX1uBax+xyVWNcH9MiVEavm++DMOalhuzO6lDtnmTFoZJ8
         3rHHmG9NBR+JKXe65CpuRnr2HSC7y/hCsQ7aXAWmARvv5Q+p6wGqiODqBfnaLMYsJWlB
         dfyx9cawQSukH7r0B02+J3gm0bhB56NN+swW3NdpNZ+15qyJVutLboQ8wsd29EyH1Cfq
         RJBUql8CeIU7D/+APZRRbNHRUTf7y59WO+JQIkMpFxD1hjX2SB6Xxa6sf9Lpt0Gi7WNm
         L5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786010106; x=1786614906;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KTqd0lpP09EibOiKqFQAK/d7YclsTCvhaaQ0Bd3pIog=;
        b=ZO4eFKp7iVWcYpddviQRnS5wHMMd7b3W+SKIi4vYrXO92GSGpRItbC0S+4B8reSPIb
         JCsQyJ27P3jN0h5pQnvNtUwdw0ENnibrjXUoiPiXjQuyhWx942nWYKI79yScHoitBZPO
         wgMK4bPOFNZT2OHBrT1ICfGLlubsx3xHxv07EIh1ix7LDYEnCoJHGAgAuvhv3WtG+qua
         MuWEf5pjxK9fr9ATEa9ENN44Xc4EnDOSZhX4QK3w116OQm0YdapLNB+9KDJ8OjISQlws
         vUjnhDjiqGczAATRDrDPlTTi2BBqzekq02synMLeKtFT0gmpgobdebm51AWLxHTG9jfn
         Kkrg==
X-Forwarded-Encrypted: i=1; AHgh+RpaTyyS3w6iYSCZvpu/kIS1c8/h4kk80L+6D0XxlphtJrT/KjbVSc3fL+s+3OYOma656D8Vq1i1LiJc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6fY9I3b7gtX/CI4lEGEfzp7hHCX9vKTmKk7C9i2XZYJLtEz62
	wL69Bq9F9eu4HNP8KPumukw7N2JdWru39aaIfWZGgwCMM4fH0c4odWaO0fdii+WH3NS1Fa/3GTX
	8DaoaE7JUbAHFr2PbdQ9EvohyZjDarKw=
X-Gm-Gg: AR+sD13RYECCrj2ETeLx1XkTCX/QghIi4ktaZTMriRo5uwlNMQKsMjHlSjwJ+GKvYgq
	9xl3ulKI5peHni8jFrf0I48blC4Ev9KNHN2tU8zz0c2c+P+83owyAqXqtovy9dADi6Dn/sITXke
	cfD/5/a2o3zZBc1XQ3QhWC+2+mmTozmL5CCAIKXgJHDX8/ExCQU/yGaYdqDNinstP0Vdv4x+h1I
	NJY38aZpUDRgfzIRLS8JRZkNwqaVQjQrF3qCH7GcHFuA6zv243k0UPZFYzog1osuRy9jNBpsSvu
	h8UDgOjI8l+s8X4/6YlBJtRDOuB9OXqlrA8RHKvaKAOcjffp0tc3N5FqWcUdPAHJaxAsr1KtJaO
	x9fFfmoCmH+0=
X-Received: by 2002:a05:690e:b8d:b0:667:c8ae:f683 with SMTP id
 956f58d0204a3-66abad23602mr1541113d50.4.1786010105998; Thu, 06 Aug 2026
 02:55:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com>
 <f42cc94c-ff60-4999-b473-c2fc5b1b4199@intel.com> <CAJZ5v0j1Tucb0yzS8=3U_X1E4ziztjgOsiYrc_QfUUKZfScCPA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j1Tucb0yzS8=3U_X1E4ziztjgOsiYrc_QfUUKZfScCPA@mail.gmail.com>
From: Julien <julien82453@gmail.com>
Date: Thu, 6 Aug 2026 11:54:54 +0200
X-Gm-Features: AUfX_mxsuSxYb4bRTLw_auynOoK9idt7FQzZIelPKJrVZG-Vnf3CPDnTHMYa3ew
Message-ID: <CAJOGg3zhEFner5pze-eX+6jh5D8nJppyWkNN5bWtg7MZ7cW9_Q@mail.gmail.com>
Subject: Re: [REGRESSION] no TPM device after "tpm_crb: Convert ACPI driver to
 a platform one"
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, regressions@lists.linux.dev, 
	jarkko@kernel.org, linux-integrity@vger.kernel.org, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Please try the attached patch and let me know how it goes.
>
> It applies on top of the current mainline, but it may be adjusted to
> older kernels, so please let me know if you need that.

Thanks. The patch seems to be working. /dev/tpm0 and /dev/tpmrm0 are
back and a command like tpm2_get_random 16 succeeds.

> I think that these messages have been present in the kernel logs for
> quite some time, but previously they were not connected to any
> functional issues.

You are right that the messages were already present before. I see
them in the commit before "tpm_crb: Convert ACPI driver to a platform
one".

Here is what the logs say now:
acpi MSFT0101:00: Adjusting resource [mem 0xfed4000-0xfed40fff] to
[mem 0xfed40040-0xfed4103f]
tpm_crb_acpi MSFT0101:00: [Firmware Bug]: Bad ACPI memory layout

The second message was already there before too.

I'm sorry for sending multiple times the same email. I'm still learning.

On Wed, Aug 5, 2026 at 6:01=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Tue, Aug 4, 2026 at 9:08=E2=80=AFPM Wysocki, Rafael J
> <rafael.j.wysocki@intel.com> wrote:
> >
> > Hi,
> >
> > On 8/2/2026 2:54 PM, Julien wrote:
> > > Hello,
> > >
> > > Please keep in mind this is my first time reporting a Linux kernel
> > > regression.
> > >
> > > Since commit 48fe2cddc85c ("tpm_crb: Convert ACPI driver to a platfor=
m
> > > one"), my TPM device is no longer available. Both /dev/tpm0 and
> > > /dev/tpmrm0 are missing.
> > >
> > > Log messages:
> > > platform MSFT0101:00: failed to claim resource 1: [mem
> > > 0xfed40000-0xfed40fff]
> > > acpi MSFT0101:00: platform device creation failed: -16
> > >
> > So there's no platform device for the driver to bind to.
> >
> > I think that these messages have been present in the kernel logs for
> > quite some time, but previously they were not connected to any
> > functional issues.
> >
> >
> > > I added some debug logging:
> > > ACPI resourcet[0] =3D [mem 0xfed40040-0xfed4103f flags 0x200]
> > > ACPI resourcet[1] =3D [mem 0xfed40000-0xfed40fff flags 0x200]
> > >
> > > I think the failure happens in kernel/resource.c: __insert_resource()
> > > because of the two memory regions overlapping.
> > >
> > This is quite plausible, but if that's the case, it should be fixable.
> >
> > Let me figure out something.
>
> Please try the attached patch and let me know how it goes.
>
> It applies on top of the current mainline, but it may be adjusted to
> older kernels, so please let me know if you need that.
