Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793448996;
	b=jucVwNl00OEpc1XT+oTLMhUMsUBFf5qwh9LO9hF7XcHXux3lvOf77BVa2AJ6AM7k6BKl
	 Trz/viWjRJ4o6fYXxDndB2rJLZuY1ph4q9+yehkBCmahxhFU6c6zkvABvUUlrbXXerUt+
	 3JdyO7l3wDO6skRK5IN16k+5W51hGmuU/SoFCQNG6sLbjbHBbgAqzEt6L6w6DuMSRz8VO
	 xsAvHq59Dys1mPjnnJLOoDQmb+VgNrfneKS316sd71OTqBIH6QTZ3pbgu+do9cxXi+5nR
	 7TzXzA8zuTj4qUnhvEbWr5ddAZb/1dv/iFtvpWm2WNxWLfda2+abbz+MbzvDnVEiWog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793448996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=DoH9E1vvOY+ET2DD3YGUjhLHHj/QLL7DcDot0+tLbpY=;
	b=2KI/SDVrty/nnkIDP3C1x2HyidJ1aoHGkVmRV93eWQ0KvsaJcEyoqCHdzOasm1ywCaHz
	 +d8Hc8NTTbmWTKH5Oo0SnC8rbf7ZBbtop6VGRM8sm6I6c91G9Jm0VAcWDMxtFTaFDJK1L
	 KPQtB5cKve+murpZ2bcEjPXTTwZnNULWhduaYFuyA9ZCQXyMtyowcZ2g5Sv8hERpicIXd
	 5ooaMMZEn89vg21M1CJYi8Llln2uMlF3ApxokHV02Lmy+IF4WZdxmlsEQ1J5hKfcMw58F
	 ECy1xFbBeTbCeWZzNevDnMQLasI2phOL/rfHZXxIdKh23w5JVSX6Suo7v5Km9TmHsfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l3xVpNPm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCBA606A31A
	for <linux-acpi@vger.kernel.org>; Sat, 31 Oct 2026 12:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CCBA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l3xVpNPm
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a2af4c8d00so1014766c88.0
        for <linux-acpi@vger.kernel.org>; Sat, 31 Oct 2026 05:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793448995; cv=none;
        d=google.com; s=arc-20260327;
        b=dDis3SeNuRhXU0AWm4hXFLileP6sZnUsAM9e811W1LqIK4WcQ+iI1LklLN3jap2je0
         Q50zehimPXj3sdhjnWOwU7nqeDz2s9UA6QL2jLMi5fmtFvV+MIsgWLBWJ0PtxOrvF2GI
         zKOktsTvhFjV25nZi1t/jGH1CaUPnOAzEa3al5CNhxJMqn7vhvQZGdieQLemKFwolO+d
         KNanzqyWiP/vxVs2AhXGO7p39QNLgN5KVX4VywiWRKdSJlyTRHOajLMe8VfhKoSm4/Pz
         9kDGRqCCdplYrQIt2IrClH4ZFFuQaOoHhYWG/u0v1caCVaak9C1WoKqXJOeQglO+irzw
         sYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DoH9E1vvOY+ET2DD3YGUjhLHHj/QLL7DcDot0+tLbpY=;
        fh=O1SkiFpqjHYTtUgggBR08NFASH172BqyHkqpagZYIas=;
        b=X5nMBb2j4/fvQJ5gP2U1idsb91+V6JqBc7Bp78Pvx05N/TJixUyqcxOi3GLpXSbb3I
         bXkZGBrcYicNPRSv1m6+BKa/7XrCY5ySHxk4TSVDh1x1H1s1YuUp9G9I6qIPtMJLKTay
         ypoBimDb2TZidkxC2PQM+dap+Wm2yV+KvLZlaZdwH/AsciFvtoKsaTjHkFUo6k9Tdc1s
         ZEXmrNAhB3zf28mdY9k2ItLdsd9zhcWBK/gYmjmY1FsDmfVDnBxUNDzGxMEodawqs/Lr
         zt3U/I3G5QSN50KYZHIXRSNfNBTvPgcjE1zFdLX/PZEf+kQwQ+4SbMDn1J230YeDOhnP
         eU5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793448995; x=1794053795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DoH9E1vvOY+ET2DD3YGUjhLHHj/QLL7DcDot0+tLbpY=;
        b=l3xVpNPmNMWRSl9KafuM4h1YbTn55Ai22RYCmQPJwKQDU9qlbwQZWNQX9MUm0wZfHq
         4wgtmq9gSy6f2SWqA11sDP2gYPpGY2G4CaZomG7RPh/ykx9nepQPcVss8SuI/Lq2jyrL
         SAV6tnxnAIvuJMBgfF64bXvPWDk+ERZmuaUwvBfjCVAT9D93ehVFUjP6eLs+tvpnvK0+
         HqT+7Gkvb0d9ChutkZf+/mfiH0xwP01QwX7RcZJXTxHmR08JCwxG83k7cBJssLceggs4
         CwCZvy1PqavIFNSJ8s6658GjYz6gcsOgoDaxI+W0FThaUlpW5FweYWINQ8FsU9sf5LLa
         5d5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793448995; x=1794053795;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DoH9E1vvOY+ET2DD3YGUjhLHHj/QLL7DcDot0+tLbpY=;
        b=1X1uUkQBy0SmqXON8IPsWBAJ/4yA3RLoQ0zLkVZHr3pwqhHVcblpUDuJJUx66FMJqN
         uBKC9LemZDqctb9z8zRTFAFhMx6zOxWP5G8oPuvoB/eqKVMWAGWaAyBuIkGYAAkSVPdS
         h0Zs1t3D28Iy8IDEnfABQneC/X4Lga0K7F/DvoncEe3GgA97tm1oEWRN6RQYIRGi6WPu
         h0w9OkAW3T4zK4Mx/H4kss9OaOybYImzyYB6gPoDDrdLdjZynWTWBrTBCkZMvJKDCzJ0
         fJdHXAcgVYI0vQ5DjjF1orEqJJasTThYEry/HeuuSKyDJtUkC5KfLbDWirpc/OROyPIj
         R8sw==
X-Gm-Message-State: AFq9FYJcHKWxA7YzurdadBu6lIJJWKzDbTpRgBaq68Jm+/NzBcVlMcC6
	+bVGoIQ/k2Ke7xMQ+TaChNP9CUriUm4kw1b8I/nuzYCfblt6zU7w4UX6yd97VGYv9bYrwSkmFj5
	KfHtefsA+xs1Ajt4taxKtoXnX5LCxHko=
X-Gm-Gg: AYBFou0wBlxyNTvkz/G3cmgGwCBCGsXMN2NN2HNhiNYIlyUxKnsFEY19vsesLIco71/
	EkgswnwNtmMIJcRFoOzxSx7JpO0YSIz5UmpfOAQ58GXyereva5U+Vu92Ja1LPRNRTmaE+lSQjLL
	5FJs1rhisUv0Tzoi5De9zi4ISk12uJ6faOMBa6fTqlr56T/k4JLBW2pBr/S7UfdOddOcXAFWKMj
	x7mbvMg+JjLKMDNc3CNHngRAjZtGLMQ8yooJ9uZ272nKVcA95hRO4wyPexXsihOWH3BtRmvz/CO
	qAKQa9v8t9lRJV8Rt8ZvPQdaSrJte6VnntHst+Df36pGJTsXZmd9J43jQ01ZyERMruLIBTdkN/r
	53QbdLMeoRwkEebF69EgkGGbNIu3Vje7Q4nmra3iY3fgTihUas8Lvk+sJ0TL3glHuchydm347cL
	eHYyxPJaEMpbvBCSZ5
X-Received: by 2002:a05:7022:ea5c:b0:1af:d88f:fc51 with SMTP id
 a92af1059eb24-1afd88ffd37mr870703c88.30.1793448995539; Sat, 31 Oct 2026
 05:16:35 -0700 (PDT)
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
 <CABD5TJyqC846A1=dL2F540X2rs-t2Xv=uT2SzLLtCnczCYHqeA@mail.gmail.com>
 <CABD5TJxfTaNfLvPEjyGwrTb9Jn-bqq0mjXjUn7Vv7dCeLD_6pQ@mail.gmail.com> <CABD5TJzXM+XCM0fhkRCaKdr9wQcgCTvH0RhhUpfaR1X2=z9VBw@mail.gmail.com>
In-Reply-To: <CABD5TJzXM+XCM0fhkRCaKdr9wQcgCTvH0RhhUpfaR1X2=z9VBw@mail.gmail.com>
From: Anup Keshwani <keshwani.anup@gmail.com>
Date: Sat, 31 Oct 2026 17:46:23 +0530
X-Gm-Features: AclHuK-BZ9ANLyVjPpfyrqH4yaBlGhNbuKeVDyGHNBpXBFEvP4qz1GRx0Jp1Zhs
Message-ID: <CABD5TJyT4VBrmGkx64_VGc9n4hSDw0ZHLpvLFdXKGHaKywXXFg@mail.gmail.com>
Subject: Re: Subject: [PATCH] ACPI: video: Add backlight=native quirk for Dell
 OptiPlex AIO 7410 35W
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, johannes.goede@oss.qualcomm.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I also realized that johannes.goede@oss.qualcomm.com isn't updated in
the get_maintainer.pl script. Perhaps that could be updated.

Thanks,
Anup

On Sat, Oct 31, 2026 at 5:43=E2=80=AFPM Anup Keshwani <keshwani.anup@gmail.=
com> wrote:
>
> Dear Maintainers,
>
> I noticed that the following patch
> https://patchwork.kernel.org/project/linux-acpi/patch/20261010124830.1167=
50-1-chitranshmandhaniya@gmail.com/
> was recently accepted. I actually submitted the identical fix a few
> months ago here:
> https://patchwork.kernel.org/project/linux-acpi/patch/CABD5TJy-sp0knXTpaB=
hJ4+zvc42jaDFggX7jKpqUvz6tTVhoTA@mail.gmail.com/
>
> I just wanted to point this out so that we can ensure the history
> reflects the original implementation, or perhaps I could be added as a
> co-developer or 'reported by contributor'.
>
> Thanks,
> Anup
>
> On Tue, Aug 4, 2026 at 11:21=E2=80=AFPM Anup Keshwani <keshwani.anup@gmai=
l.com> wrote:
> >
> > Hi Rafael, len, and Hans,
> >
> > Resending this reminder to Hans' updated kernel.org address (apologies
> > for the bounce).
> > Just a gentle ping on this backlight quirk patch when you have a moment=
.
> >
> > Please let me know if any changes are needed.
> >
> > Thanks,
> > Anup
> >
> > On Tue, Aug 4, 2026 at 11:10=E2=80=AFPM Anup Keshwani <keshwani.anup@gm=
ail.com> wrote:
> > >
> > > Hi Rafael, Len, and Hans,
> > >
> > > Just a gentle ping on this backlight quirk patch when you have a mome=
nt.
> > >
> > > Please let me know if any changes are needed.
> > >
> > > Thanks,
> > > Anup
> > >
> > > On Tue, Jun 16, 2026 at 12:29=E2=80=AFAM Anup Keshwani <keshwani.anup=
@gmail.com> wrote:
> > > >
> > > > From b289e63d7f44500517dc94b7028b707616fd1dd1 Mon Sep 17 00:00:00 2=
001
> > > > From: Anup Keshwani <anup.keshwani@dell.com>
> > > > Date: Tue, 16 Jun 2026 02:57:11 +0530
> > > > Subject: [PATCH] ACPI: video: Add backlight=3Dnative quirk for Dell=
 OptiPlex AIO
> > > >  7410 35W
> > > >
> > > > Dell All In One (AIO) models released after 2017 may use a backligh=
t
> > > > controller board connected to a UART.
> > > >
> > > > In DSDT this uart port will be defined as:
> > > >
> > > > Name (_HID, "DELL0501")
> > > > Name (_CID, EisaId ("PNP0501")
> > > >
> > > > Signed-off-by: Anup Keshwani <anup.keshwani@dell.com>
> > > > ---
> > > >  drivers/acpi/video_detect.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detec=
t.c
> > > > index 458efa4fe..10e3c1657 100644
> > > > --- a/drivers/acpi/video_detect.c
> > > > +++ b/drivers/acpi/video_detect.c
> > > > @@ -886,6 +886,14 @@ static const struct dmi_system_id
> > > > video_detect_dmi_table[] =3D {
> > > >   DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7770 AIO"),
> > > >   },
> > > >   },
> > > > + {
> > > > + .callback =3D video_detect_force_native,
> > > > + /* Dell OptiPlex AIO 7410 35W */
> > > > + .matches =3D {
> > > > + DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > > + DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex AIO 7410 35W"),
> > > > + },
> > > > + },
> > > >
> > > >   /*
> > > >   * Models which have nvidia-ec-wmi support, but should not use it.
> > > > --
> > > > 2.43.0
