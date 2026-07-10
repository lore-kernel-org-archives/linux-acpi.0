Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0663BF67E
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 07:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783666998; cv=pass; b=OGeTw8i/N1+G4AOFNaBn5vShg5ORyDcxIb18naBF9mU+MRmiL6pNBvZ98IugAMC+HfrcAsE8188Z3l2zjeUlt/MVxGugG2M3YUv1Yjb+ktvpD4+vJQ3XSIIUzYSWVNYR5yZuyLtczSr4Xze+vJK50BOLJ/G5xn6Wk7uRrCtCXLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783666998; c=relaxed/simple;
	bh=jeYBpsVZRu4opwsHOZ92QeIQLJ1kAcNu2rw6khHCYZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+amAvggxkQWNRRGsWoqzrt7QfYaQSH92lkrV2AfusAbXN/3E+2Gw1/Z7+eYMGdXaOHf5T54yHvY1095pvw/V08D+ug36aOfhOqGd5gB/eIsrxjGfWSFf+XT9wcyUz6OkxGSrqdu/JeKXtAQsGuBIgJ5TgLqFNm+LtmGsDlGNn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hD9W9EcE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6QHNCrQ; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hD9W9EcE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6QHNCrQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783666994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0R936VrXsHB3d70aM67rjnLtxGIXy7cm58R9eKWt5eA=;
	b=hD9W9EcE1Q98C8KPDDd6x0cEpq4TFEDTQwWwm5vhnFzRSbaRf/p9jHEvhldnPPgsBlGsKo
	NrTDw1u8AcsNgKvhb2moXKOckFslNTU2OhEii6RJHZxqCUA/d1pFmzS+TgMvAv1vSvbywb
	QDvGnPOWHpQk287DhBS3s2PnC/79EXY=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-WLd85eqpN5WCy2llMg0rEQ-1; Fri, 10 Jul 2026 03:03:12 -0400
X-MC-Unique: WLd85eqpN5WCy2llMg0rEQ-1
X-Mimecast-MFC-AGG-ID: WLd85eqpN5WCy2llMg0rEQ_1783666992
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-485ebc5706cso2517092b6e.0
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 00:03:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783666992; cv=none;
        d=google.com; s=arc-20260327;
        b=rw30790lIY22Ku9CPBpyW+X/KepNNjLK4WU7UosTBuuSqGP7urrX4HPJpwmunO5Czr
         X/pxgz7KB3SQ3jp19YvJKIt4t3zjgkL06V1CcKEEj7kaxesanr7fTVFPWHqGGPwdJ4No
         Whfh+n1c6JHoFSwhoTI1ZbYw9X6Z9RIgSzbpIeMdxl+x5MmCfOLisAG4zy8tyMSRlTPD
         73s7KTqOto5HfUKnu5nu9YR55SUZo4SEzU1yXjMYXy0Uwg4OUrxxGhsFLcY5X6hWQNW9
         eSfppUhF4SRLiXllTqY2ndACPmHf8f0BTuDQqdIxtN2JPxG5ekKgYHCTrnL/8T7k8L8L
         N6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0R936VrXsHB3d70aM67rjnLtxGIXy7cm58R9eKWt5eA=;
        fh=eI+cwCaaPCEdWr3HjkmNieFhYatcj+yohogCgAW5PRU=;
        b=GFlU5Y7d7AR7DO6rg2osR5kYoea1D4/Dn7I4/sQ769eG8dhR9VL/5+P/8uU+SzsWYW
         EU6SsqVjPwXpcSWHWmtzo82+wlYWbBFFewvhk48A4kjZ62+lR7zLRPcXOSa1uoQPL6se
         j1vb3zN5e+QuJu7Lnttdj51yvkBRdTyPNW+Nv3S1btOrNNyxZkARVXwMfieWR47XFFIm
         uG/4mw+uqUHd6/G//rQhZBaAdHH7WYDP9gJqh2GCeH20AaX1TggS0NMl26kLD/3eRzaz
         NouGUAGQjYPm17pKsdzHnrStZ207vWlb0aRy2oK2RgUJDmGyzNLIJKYzfIVd5SLu7C/2
         WtLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783666992; x=1784271792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0R936VrXsHB3d70aM67rjnLtxGIXy7cm58R9eKWt5eA=;
        b=Q6QHNCrQP0KjKO0S5HOidElRLq9NJbzMCTgx1L0iRNh+uVx7bKpFgueCWFIDHSGHLQ
         fjpgH2RyzGuVqgEwAXI4IfwzmbQsDpbhD6stbuekTTyTt6z6LXE0xL5RfekX754Uxn9F
         DEpBAyEjNOQzl1qtUKHxYJbrQFxN2DU3996A+V/dzYKztgdVShFIZ9DuHcMuLDYaELzQ
         0V9/Lq2tNiWiw9b2WbDdu8ZCoWJ9WL4uKVMGeJkz6J+1HbJBIRd3KEIevqS4F5oGgsbm
         sVIz1uzjMzjCeK8vZU53salV5nVN1C6AiXYjviFqNTKIutIoYCQC4EfczezweiZ6AQNr
         DKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783666992; x=1784271792;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0R936VrXsHB3d70aM67rjnLtxGIXy7cm58R9eKWt5eA=;
        b=BqeCs1Y/9uE7fNH2FNC/B1wq9foCq2t1jkRPm+LjuUYs43QoIvhHcG+QqMrq42c8+/
         4IfGcc7QDgFF1lQTn+IThx7myJksIN96clcnv0KXQSSkh6z0e+GondvyZmU96kqv0hgO
         ReZpIrlmWwXy5NbsbSsl65fhMuG+mrG1Rv22D2CS8Nzu+RBONamA75STLk/KvXVjKYtQ
         KoKs2vQzJRQQgAVCd5lsgpVn65iXWQIr+43fIQqBtjSVU9uR/UCX1CcSQL3MFVDuG592
         I0TS0a95EUNDuuUmT1NvWmzs6pD2rbBP4uQVobIVKuGytvZtRS0zet7CWbEY+/xd6Mbs
         /2gg==
X-Forwarded-Encrypted: i=1; AFNElJ/WkmptpMW79JfuKbAy389llhWXU040wwCx5SWfxXfWgPZ8jEtu3e9AdEuCAxu/EvWiqD9HndFO43GX@vger.kernel.org
X-Gm-Message-State: AOJu0YzHCDdVImwDYVU/zL4Rt6FXBzC+6rLd+CtMEXKv1U+qljviSxm4
	caOHDVT3tOKHLJOZyJU6PNxBur1JWWVQTW6EQ7G4SkPFdf7mzkrbMZIPjnyyZlAwDisQQUV7Tbq
	J9RjOvWY8szPS86d0dMHxprx5oGBMwxccRGlVByK3INn0aw6RbbcPAsg2jvixScSFPC15SiHycd
	jQ7hSy0FfBBTtSfJjONxNYToa0J7LDlSrztm/6UQ==
X-Gm-Gg: AfdE7ckAAEsfxtljPThnZKR9w7/D/pIWThbabYKNDK09bYOhp9toVNRWWh0gLZEZEvm
	UyfLmw8qhyuCumACQda8KYKFknDE34kmWMnEGmjXyjLN8EhYXTB9Ai9hHeZqYZCMr4Nnp1tUHqg
	fkLqbbckqwWr8jJ8yqs1C7Fu8Tk4pikNMU3/y3N6eN3QjukjNzwZtWHu2EfQdfbQpzrtRr
X-Received: by 2002:a05:6808:192a:b0:496:10af:ee45 with SMTP id 5614622812f47-4a40f0bcce5mr2088364b6e.31.1783666991914;
        Fri, 10 Jul 2026 00:03:11 -0700 (PDT)
X-Received: by 2002:a05:6808:192a:b0:496:10af:ee45 with SMTP id
 5614622812f47-4a40f0bcce5mr2088343b6e.31.1783666991441; Fri, 10 Jul 2026
 00:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708070732.578046-1-hpa@redhat.com> <CAJZ5v0i5YG9v4kiYoD_-n_33FjX506uZgstJo+=BSA0KPZ_6mw@mail.gmail.com>
In-Reply-To: <CAJZ5v0i5YG9v4kiYoD_-n_33FjX506uZgstJo+=BSA0KPZ_6mw@mail.gmail.com>
From: Kate Hsuan <hpa@redhat.com>
Date: Fri, 10 Jul 2026 15:02:58 +0800
X-Gm-Features: AVVi8CfKq4wb6Wdk5j_IR9K_vwqUqGSHjPs33NQ-diqdQ5B88JoKRfj5EGxBOBQ
Message-ID: <CAEth8oGjXrhy5dNiNnAB_s8NdFHjATthEkCRy9fniKMkxamJTw@mail.gmail.com>
Subject: Re: [PATCH] acpi: battery: Sanitise model_number by dropping
 unprintable characters
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

Thank you for the review.

On Thu, Jul 9, 2026 at 9:38=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Wed, Jul 8, 2026 at 9:07=E2=80=AFAM Kate Hsuan <hpa@redhat.com> wrote:
> >
> > The battery Embedded Controller (EC) may return the model name with
> > trailing unprintable or non-ASCII characters. For example, on some syst=
ems:
> >
> > $ cat /sys/class/power_supply/BAT0/model_name
> > LNV-5B10W51864=EF=BF=BD=EF=BF=BD
>
> If they are just trailing and not in the middle of the string, you
> could just find the first one and overwrite it with a NUL character.
>
> Rewriting the entire string is overkill in that case.

You are right. I'll find the first unprintable character and replace
it with a NUL and break the loop.

>
> > Strip these unprintable characters to ensure the model_name attribute
> > contains a valid string. If left intact, these malformed strings preven=
t
> > udev rules and hwdb from matching the attribute correctly.
> >
> > Link: https://gitlab.freedesktop.org/upower/upower/-/work_items/345
> >
> > Signed-off-by: Kate Hsuan <hpa@redhat.com>
> > ---
> >  drivers/acpi/battery.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> > index f5e0eb299610..dea0c3cc5160 100644
> > --- a/drivers/acpi/battery.c
> > +++ b/drivers/acpi/battery.c
> > @@ -10,6 +10,7 @@
> >
> >  #define pr_fmt(fmt) "ACPI: battery: " fmt
> >
> > +#include <linux/ctype.h>
> >  #include <linux/delay.h>
> >  #include <linux/dmi.h>
> >  #include <linux/jiffies.h>
> > @@ -194,6 +195,21 @@ static int acpi_battery_handle_discharging(struct =
acpi_battery *battery)
> >         return POWER_SUPPLY_STATUS_DISCHARGING;
> >  }
> >
> > +static void acpi_battery_remove_special_chars(char *str)
> > +{
> > +       char *out =3D str;
> > +       unsigned int i =3D 0;
> > +
>
> And I would use a for () loop below anyway.
Okay


>
> > +       while (*str && i < MAX_STRING_LENGTH) {
> > +               unsigned char c =3D *str++;
> > +
> > +               if (isascii(c) && isprint(c))
> > +                       *out++ =3D c;
> > +               i++;
> > +       }
> > +       *out =3D '\0';
> > +}
> > +
> >  static int acpi_battery_get_property(struct power_supply *psy,
> >                                      enum power_supply_property psp,
> >                                      union power_supply_propval *val)
> > @@ -524,6 +540,9 @@ static int extract_battery_info(const int use_bix,
> >             battery->capacity_now > battery->full_charge_capacity)
> >                 battery->capacity_now =3D battery->full_charge_capacity=
;
> >
> > +       if (!result)
> > +               acpi_battery_remove_special_chars(battery->model_number=
);
> > +
> >         return result;
> >  }
> >
>


--=20
BR,
Kate

