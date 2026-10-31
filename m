Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793448797;
	b=O6smQ7TVtmRRJwxUkxpNxtYmeIjUbg5LWpDCnoYafeO6EJkU/td1byqsWI0FIw4auR4s
	 C9We885w1p30WYJWEe2iLKFbAj3QLhL8QcP1eHtxY4DP7odIglGM7SRhzTIhqxU1A78KD
	 bmFcZ848GW7H8tS1z/o5UnOFh0BjiO4tJSIyiV7EplbBhAJmyK594FDuJHI9f4imIqKzh
	 4JfvG3iXXDcDqHnVMiWTYRBRHuoLyqjjHR/LQtl3+w11FcC3c2xG5T1VY1PEFxgN0ulQY
	 nuuiBL9xseqYkHWIX9PdFHwPnNc7ZzGsmSHi0/aLv82RjiOggDIjTrzn/IPMNafPVfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793448797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=92RxbdIoYdks54JXgIdkuC9nu61dKUU8qHkYk11QqtA=;
	b=u1HKeTBtTChcDvfAWfeYY7RLZeC7irpoaBbBZyBjxOzQL7pm5CIfJdqEa7HNkJNzCI8m
	 lWiZeggUFwkadc32SzrmIZSQLlDRS090jL6+S005Wx4OqJPaTWPsQevzTdW4UO3zVe9F5
	 uhol3Famd3gimtDtIdCbzdXyO8Y/5u0X5vihRweTrY1nDfZk40Ll4xb0Aeopq/ahvrnz3
	 IeOolfyCXS+f4/jbELwObUgisiZLNwoAAuk3NPm3p9viArOf1Kza8xhJKiiTbECHphoeF
	 V3kaGWjRS8cSkKER448HhM/odc07fjrVW+Wnhev3d+hyLuswhph5blvHqwh/Gu9uALw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9fry2D8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F415606A31A
	for <linux-acpi@vger.kernel.org>; Sat, 31 Oct 2026 12:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F415606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9fry2D8
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1931ff67a29so1495249c88.1
        for <linux-acpi@vger.kernel.org>; Sat, 31 Oct 2026 05:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793448795; cv=none;
        d=google.com; s=arc-20260327;
        b=GlKfUmG6GFX3REURhFD2WFH8G/vvE+wtdKo/YdixIkAWpVNFOzWGhXmOvafPCFR5CJ
         olawSmog+peYZ6kIFWg+xi+HkfhJ0cObc0d8W6x0j7YjSmLs0/wcR+3bm0YR2HgMjNOP
         XtyrQC1Vx4PtuYELalk445IwsX8ctEfXoKkOuLXmKu6bIxCrpNZYCMxjR6sWa45Nx21L
         9Ej9MqqIDbBU9EMzLqyIaQNcLzo32nsiCgCLApp5Yn/EL/Fkry3B7GztHUF9Lo/p9gGg
         Iouli2xoiL0THC8bI78sCapRWYVWTMvsFK/v0Xooza09h/aCqDA2NzNkjJGoDbwGEME4
         69dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=92RxbdIoYdks54JXgIdkuC9nu61dKUU8qHkYk11QqtA=;
        fh=O1SkiFpqjHYTtUgggBR08NFASH172BqyHkqpagZYIas=;
        b=US14XjDFaLkj3tc/eBOnNfd4r4kF7g+AWgkwTCr4f8Rs1GebHSfvCs7eac+t/Qp3Kz
         vjJSK+Z2J0l5q5icrvoW681O/r6DoXQfVj6ZFhY7qoaeOohvYUrVzInVLF+2dJoicrbw
         HdMvBAWB9iqHFluQ54rmjVzP8AMixlRRCBmdQWSJp+6/aIjIN8lCRY5nZ2m1qiJ5pAsj
         dhLHbpebxkWlSMdGLeTB0B6N0/90aS/Wzw315CYoKb9yGcddkTYoGVSxMRO1m0RxFUev
         BDeGjXQvhDEDIE7rYxmduB7qTPE5vHxZTLrKqielpezJkFUTa95tnuzCKclDP0JkEXNL
         yYkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793448795; x=1794053595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=92RxbdIoYdks54JXgIdkuC9nu61dKUU8qHkYk11QqtA=;
        b=Z9fry2D8wh2yx0cc7IMuInySHMnBgZbBvurkYrzrVLpzrJAe3y5yXU2AWQE3h/oXn2
         Ug6cpQxxeatxaF2T2Rx5HmyNsQqlx78qpKU1OcaYFQKo4r2egqAgUjH5FqGTgJVPx80a
         9J0ZBmcxfYcm/P3sM7nF4EOe23jNHXB+3If/aFu/i+rhExoDPTMO/o2B5/jbNpFDfZHD
         KpT0PzcQyaq/zKlBVODJx/ycVjE+tkMgLga/eqM/m4CJ1TNeFYYH2g4QCQ//ULX5IwFE
         SyKEoTt/xhnxQrY7nrzSJh/uXYlRAM+JuwEQNTmHF/qkM6HovV4uAd0v7b3UUVF/zDSe
         ZU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793448795; x=1794053595;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=92RxbdIoYdks54JXgIdkuC9nu61dKUU8qHkYk11QqtA=;
        b=V71XS5uF3k+Ak6a3rohe7q06gIOFwuiycUR8Y4inYqq3PyMs70FTNmipeh+HfVA+wS
         nLBLMLFiXVudeuBhVfz3pib3T4SEJBmYlTGGLWllU9KGY32gOW6gW2tLeYkrKg7/6Xg8
         EKuOjJWXdCJbTyluKO9quVlPBLXbKDYSfrkzdr/8iHqnjfSsRBwtKmgwH0cIb6XQ3iBw
         Q8CJ7vUEWf1gmyZAK5tf8TT8fkDr4hmgkYL/c5B5U9Hkj4Sj6aRthSDcY4NqF3lDU9c+
         10OAYPtDh5POmaIy699wWYsSTUQo5QDJZ29MCJC/FyjzwEXPXEkO49mbtNrRFLbiakou
         Xpfg==
X-Gm-Message-State: AFq9FYL6bOehiaB7PrLqUYSviFDzb0uK8vACBrbrxlBzZW4E9AfPFU8M
	MXVyv91hPuo2A6U8sr24xfEfU+uJiOM/BzNw6Cpltdw+7ioKNqfEXr0mszgacpoTBKOKcULTyut
	hLzJeMrsG63wyDC3nzkYOsdyubkPAulI=
X-Gm-Gg: AYBFou0ElRZ5yJq8TFhhwfiRFiuXEw+GdJ1ecXlcoLXosJtvOxi1TKjMf9gTqQaquC9
	nmPQLq+tMId+uZRf+wWrt5OXgM9UbQvvldqd53UU5pH0+1c82CBfNI2I8WZUHYB4KUgTjYqXK+9
	7DVgoj3GiPYY7f/cjfG3f1BTXuQPtDIRK9x6kzTsWG9aeRYIF0yMxNb/fVhWQBh6e+Q/F6NRT6R
	fpgpL6yhHej3F3hNVaEZOyFFL8CMVNa9DM1FO6AubGiOw6wtxp89AG3pxO6TBtKaxXonN0mBkCX
	K9eJeOns5xKl8SLomqZ9em8xV+Xb2TFtxTUkxGQwzSWNNQbRAdzxT9FN7BKA8MvGoZssBLjbc/l
	PDcMua6Fvv9T3h/oLGVjDGjig1maoqxPQtpzl4RLQ8QezcHy4MkKnVqQaOf6Qpq0SB+3/RHM=
X-Received: by 2002:a05:7022:f50a:b0:149:50cb:2175 with SMTP id
 a92af1059eb24-1ac5cb1881bmr6786689c88.33.1793448795055; Sat, 31 Oct 2026
 05:13:15 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CABD5TJy-sp0knXTpaBhJ4+zvc42jaDFggX7jKpqUvz6tTVhoTA@mail.gmail.com>
 <CABD5TJyqC846A1=dL2F540X2rs-t2Xv=uT2SzLLtCnczCYHqeA@mail.gmail.com> <CABD5TJxfTaNfLvPEjyGwrTb9Jn-bqq0mjXjUn7Vv7dCeLD_6pQ@mail.gmail.com>
In-Reply-To: <CABD5TJxfTaNfLvPEjyGwrTb9Jn-bqq0mjXjUn7Vv7dCeLD_6pQ@mail.gmail.com>
From: Anup Keshwani <keshwani.anup@gmail.com>
Date: Sat, 31 Oct 2026 17:43:03 +0530
X-Gm-Features: AclHuK85zhkFXPh1CfiySAdqs0FwOZF4O4AGOyDP7lNgetzPcM9OWC97WmNYNNk
Message-ID: <CABD5TJzXM+XCM0fhkRCaKdr9wQcgCTvH0RhhUpfaR1X2=z9VBw@mail.gmail.com>
Subject: Re: Subject: [PATCH] ACPI: video: Add backlight=native quirk for Dell
 OptiPlex AIO 7410 35W
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, johannes.goede@oss.qualcomm.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Maintainers,

I noticed that the following patch
https://patchwork.kernel.org/project/linux-acpi/patch/20261010124830.116750=
-1-chitranshmandhaniya@gmail.com/
was recently accepted. I actually submitted the identical fix a few
months ago here:
https://patchwork.kernel.org/project/linux-acpi/patch/CABD5TJy-sp0knXTpaBhJ=
4+zvc42jaDFggX7jKpqUvz6tTVhoTA@mail.gmail.com/

I just wanted to point this out so that we can ensure the history
reflects the original implementation, or perhaps I could be added as a
co-developer or 'reported by contributor'.

Thanks,
Anup

On Tue, Aug 4, 2026 at 11:21=E2=80=AFPM Anup Keshwani <keshwani.anup@gmail.=
com> wrote:
>
> Hi Rafael, len, and Hans,
>
> Resending this reminder to Hans' updated kernel.org address (apologies
> for the bounce).
> Just a gentle ping on this backlight quirk patch when you have a moment.
>
> Please let me know if any changes are needed.
>
> Thanks,
> Anup
>
> On Tue, Aug 4, 2026 at 11:10=E2=80=AFPM Anup Keshwani <keshwani.anup@gmai=
l.com> wrote:
> >
> > Hi Rafael, Len, and Hans,
> >
> > Just a gentle ping on this backlight quirk patch when you have a moment=
.
> >
> > Please let me know if any changes are needed.
> >
> > Thanks,
> > Anup
> >
> > On Tue, Jun 16, 2026 at 12:29=E2=80=AFAM Anup Keshwani <keshwani.anup@g=
mail.com> wrote:
> > >
> > > From b289e63d7f44500517dc94b7028b707616fd1dd1 Mon Sep 17 00:00:00 200=
1
> > > From: Anup Keshwani <anup.keshwani@dell.com>
> > > Date: Tue, 16 Jun 2026 02:57:11 +0530
> > > Subject: [PATCH] ACPI: video: Add backlight=3Dnative quirk for Dell O=
ptiPlex AIO
> > >  7410 35W
> > >
> > > Dell All In One (AIO) models released after 2017 may use a backlight
> > > controller board connected to a UART.
> > >
> > > In DSDT this uart port will be defined as:
> > >
> > > Name (_HID, "DELL0501")
> > > Name (_CID, EisaId ("PNP0501")
> > >
> > > Signed-off-by: Anup Keshwani <anup.keshwani@dell.com>
> > > ---
> > >  drivers/acpi/video_detect.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.=
c
> > > index 458efa4fe..10e3c1657 100644
> > > --- a/drivers/acpi/video_detect.c
> > > +++ b/drivers/acpi/video_detect.c
> > > @@ -886,6 +886,14 @@ static const struct dmi_system_id
> > > video_detect_dmi_table[] =3D {
> > >   DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7770 AIO"),
> > >   },
> > >   },
> > > + {
> > > + .callback =3D video_detect_force_native,
> > > + /* Dell OptiPlex AIO 7410 35W */
> > > + .matches =3D {
> > > + DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > + DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex AIO 7410 35W"),
> > > + },
> > > + },
> > >
> > >   /*
> > >   * Models which have nvidia-ec-wmi support, but should not use it.
> > > --
> > > 2.43.0
