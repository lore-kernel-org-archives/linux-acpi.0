Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B035D30AAA6
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300684; cv=pass; b=OAByyNZNo5JM3ucgQ7XPxs58kfVAm5W4maV3MtjnFVvmxrlYzD2wc1PjbtvFQ7sOKTiabqnVGAvSWZRXPXCusc2seb/Fd7soow2Aw2fIrFDmlnECoVxvMf4kh0iR/vfP+htuvx07X2KfwLe/flEAUdR9arTnCV6xKWVehX1Mi0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300684; c=relaxed/simple;
	bh=IpMITlM/YJjsjXI1rBblKzHHECWwdLqWg+U6zw/CvS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhvWSF5NCZXsbvMTF6g8jUB/R77FafbzkeZrknI7B+q98Z9wMNXymKjmlUrsLqxFBay3a1BZ3YWk1f6FOr+S2HYKT+BeifFFKKiqPOyzIszJnk4zLS7jAoo3uvY4i4NsbiVypc3qIySBv1JJrFVZmfZ3w714chl0a0euxMcztYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVkm3JoK; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVkm3JoK"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79ea87af213so157070517b3.0
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 07:38:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777300680; cv=none;
        d=google.com; s=arc-20240605;
        b=PIy3jhZVNW9/CdJIVPK0TORbNm10WBZehDajfY2oRFPDdCkwixeyUDfNQM7Z11iyIU
         5nsjA5zUh7GDSEljc8S8m+U33jCnMiquK361sbXiIOj8SfayteZt5j8ahX15Lk4Otjt/
         AdPoPNGVbdn4paxurTOANT+YK5/tYp5wpLlogIsA3F1N+mlcVvAdhpigpm4hy209jMj8
         J6BaVVMgz5Ww+Fe+cTPTNwBR8SBJIiabWnNULL43cXktraFJ18EfPeyMVpr5s7Wj7r5j
         mGo78CixvV1Mfkl/SV11V4HdSJtEJ+DqMsLvEJZDdOwTaF8aoAD8rTu00pZWCqlOMmNr
         i4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pE9E5EL2wZ+QbidUv5BkbqsakJcHAToa5Kw6NJRNuqA=;
        fh=/K1gJD77wfcX8xFekl9MPUYRFrhsgb5FUk6MuWbLXWc=;
        b=YUrvVTeqawJoEpdmShcYheN2QOSle2DOgzfd4GJqrjT8/BW3IR+YQve+/XyC2qbvf+
         C6or+H1G9dH0p8MuYSXd3o6SGo/5E0w/IRrR0kECp2P+jGvXmeVUgeX/r9qcO5CSFDEN
         YRloKsOmqZWilUacXSRZZ/vze42EP1SDnsbjb0OuzOqCPWvIKgnH5jPD3eYCjwA6hQ2/
         Are8QrGF1W1HnAFi+NwwwKCiQ9FSMbK8Q6hJwtXRqlXdxw3mE6Sj+cOo7pHMn+CHERtE
         woqXQ7FEvxhOcyymwdveYLhuEobnwXqVsldg7IQgWMjVNgyTV716EtF+ROmKBQhnWB0i
         tFtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777300680; x=1777905480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pE9E5EL2wZ+QbidUv5BkbqsakJcHAToa5Kw6NJRNuqA=;
        b=fVkm3JoKOI5ZdrrIBhF6Iw8hn5/gNBsZIIjdGaVhJUkBN0wAbZqoVwShzMwAfiK/uj
         0o6v5izruy+xrzWayfb14/BtYCF50KjvjPKIA1f7/IQHJv/csm9yCsFs3J9DuzDCAnWE
         7hy/o2Yj7MRwQyhyDVmKq7KgYzzTNYDbs1B/icgpvam+0dnosbwkQH/qy/nBDAWkacrR
         jhsBEJMlAO1JF86vOzoQ58RXoUC+nMdynoJX4gpHPZZ2DPhnH99gwYcd7f3foUXg57S+
         5cp74exscHkw/BY/b3++SfCNN1Ta6nVSQqeo4bqU5fKT5Fn8GmEIjAYGfNhQQ/Di4M6N
         oNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777300680; x=1777905480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pE9E5EL2wZ+QbidUv5BkbqsakJcHAToa5Kw6NJRNuqA=;
        b=mIEczYe84zdhNlkR6i7Sa1983eASWjP8TY40s79zyat7yaY1IEt0Dd2WJUmmyrqgvC
         Up6a1EFDsIOBGI0H2DNdnufl/WCGfN06HWOEYVNmUN5uoy6ZNOjPPke1l+rQPrxr/lx7
         6dzenjnpOV6n3zf1jhqlu88yChaxedcvDWVZ+JVC3COrqa7f4vOCtwE9AStS29bP72vg
         OWp1ZEGVkoILQe997XwgkSZomYCB0wJM/SP/k5VzSgeMopFP0whLrJ2lBTE+fbjy33HT
         4BUy7lfZ28oStlLHmFjXufOGfQ+XR4G7x+UFVgLgD3jpDI13jQdpSw0f5BtIfcGaWjpQ
         p4fg==
X-Forwarded-Encrypted: i=1; AFNElJ+U0NHS3VqZgy82YPkb4iynMB7c/Pfetd4p2tmcEinqdaYeV4TNp4c8tFasOY9GjR3jlPKWH+w8fQJa@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt2DduS/Q6yDNxwxCctj032jv+h03FNYb6Rse09u7+jaVs0LJN
	AGgj6tFyuqqGKDImox4n1wysVgpc+ltK7nLyW363muEDvVT2NOUzjJ8M+KMF4EWtP8e0vq3KvNz
	UejJ0ZkU+uP0x6hDKE0Qtw8d6Myv4idQ=
X-Gm-Gg: AeBDieshgCt/vC6D4FGJAlW2NzHs5qZQSbdd2MGhpKNu9BbnHL0ZiLSGHiYZlSRpJWG
	TlMsOIF4b7tZykwGU8PzLl8k6W+WXkkWMTKemcyN7YDLNj1wu0jggsSBE3i6ylJLPesJhyjFfTd
	TF4erEFuYCg7yNfm7Og5rsDFpAfX5ByhVKaHJXaE/FmTChJsQxzp3CVw3+WBhZOtMqkhY0fWJ5k
	+ho3ctfAyYC1MbXWjjO+VscdhvjjfnlJYxmRFhWF11A5hD2TTgZm+eLVjQiFqtIICTJRevZSB8p
	0CMhK9geBNO1eTC/WkQx
X-Received: by 2002:a05:690e:144c:b0:651:cdd9:b395 with SMTP id
 956f58d0204a3-65311884b24mr30640258d50.2.1777300680441; Mon, 27 Apr 2026
 07:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424220110.25929-1-m32285159@gmail.com> <ae8QBnSs9fYvkv_i@ashevche-desk.local>
In-Reply-To: <ae8QBnSs9fYvkv_i@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 27 Apr 2026 09:37:48 -0500
X-Gm-Features: AVHnY4JEhgDHbGS6A1MrF2H5sisjzGWPO37TTDy-97dNHFmROxLZSzj2wbdPVI0
Message-ID: <CAKqfh0G8KLoCFGxz8J-herfKYUXfd4U4v8kwgQp3ghq35TNcpQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: pmic: Replace mutex_lock/unlock() with guard()/scoped_guard()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, andy@kernel.org, westeri@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 2:28=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> > -     mutex_lock(&opregion->lock);
> > +     scoped_guard(&opregion->lock) {
>
> >
>
> Now this blank line become redundant.

LGTM.

>
> > -     if (pmic_thermal_is_temp(address))
> > -             result =3D pmic_thermal_temp(opregion, reg, function, val=
ue64);
> > -     else if (pmic_thermal_is_aux(address))
> > -             result =3D pmic_thermal_aux(opregion, reg, function, valu=
e64);
> > -     else if (pmic_thermal_is_pen(address))
> > -             result =3D pmic_thermal_pen(opregion, reg, bit,
> > +             if (pmic_thermal_is_temp(address))
> > +                     result =3D pmic_thermal_temp(opregion, reg, funct=
ion, value64);
> > +             else if (pmic_thermal_is_aux(address))
> > +                     result =3D pmic_thermal_aux(opregion, reg, functi=
on, value64);
> > +             else if (pmic_thermal_is_pen(address))
> > +                     result =3D pmic_thermal_pen(opregion, reg, bit,
> >                                               function, value64);
>
> Despite being long, I would still use a single line for the last one:
>
>                         result =3D pmic_thermal_pen(opregion, reg, bit, f=
unction, value64);

Sounds good. I guess it'll be up to the maintainer to decide on this.

>
> > -     else
> > -             result =3D -EINVAL;
> > -
> > -     mutex_unlock(&opregion->lock);
>
> > -     if (result < 0) {
> > -             if (result =3D=3D -EINVAL)
> > -                     return AE_BAD_PARAMETER;
> >               else
> > -                     return AE_ERROR;
> > +                     return AE_BAD_PARAMETER;
> > +
> >       }
>
> TBH, I would leave current logic, as it will keep the scope and the seman=
tics
> of the each branch consistent.
>
>                 else
>                         result =3D -EINVAL;
>

I can also go back and fix this, seems rather simple.

>
> > +     if (result < 0)
> > +             return AE_ERROR;
>
> Also (some) compiler(s) might not see well the result being initialised a=
ll the
> time when we are here.
>
> >       return AE_OK;
> >  }

Acked, I'll see about getting this fixed.

>
> >       if (d->exec_mipi_pmic_seq_element) {
> > -             ret =3D d->exec_mipi_pmic_seq_element(intel_pmic_opregion=
->regmap,
> > -                                                 i2c_address, reg_addr=
ess,
> > -                                                 value, mask);
> > -     } else if (d->pmic_i2c_address) {
> > +             return d->exec_mipi_pmic_seq_element(intel_pmic_opregion-=
>regmap,
> > +                                                  i2c_address, reg_add=
ress,
> > +                                                  value, mask);
> > +     }
>
> {} are not needed for a single statement cases. But I see it occupies 3 L=
oC,
> perhaps it's fine to have them still. Up to maintainers.

I'm aware that {} isn't needed for single statements, but as you've
noticed, it occupies 3 LoC, and keeping the {} seems like the more
logical solution.
>
> > +     if (d->pmic_i2c_address) {
> >               if (i2c_address =3D=3D d->pmic_i2c_address) {
> > -                     ret =3D regmap_update_bits(intel_pmic_opregion->r=
egmap,
> > -                                              reg_address, mask, value=
);
> > -             } else {
> > -                     pr_err("%s: Unexpected i2c-addr: 0x%02x (reg-addr=
 0x%x value 0x%x mask 0x%x)\n",
> > -                            __func__, i2c_address, reg_address, value,=
 mask);
> > -                     ret =3D -ENXIO;
> > +                     return regmap_update_bits(intel_pmic_opregion->re=
gmap,
> > +                                               reg_address, mask, valu=
e);
> >               }
>
> Ditto.

Same here, feels more logical to just keep them.

> > -     } else {
> > -             pr_warn("%s: Not implemented\n", __func__);
> > -             pr_warn("%s: i2c-addr: 0x%x reg-addr 0x%x value 0x%x mask=
 0x%x\n",
> > -                     __func__, i2c_address, reg_address, value, mask);
> > -             ret =3D -EOPNOTSUPP;
> > -     }
> >
> > -     mutex_unlock(&intel_pmic_opregion->lock);
> > +             pr_err("%s: Unexpected i2c-addr: 0x%02x (reg-addr 0x%x va=
lue 0x%x mask 0x%x)\n",
> > +                    __func__, i2c_address, reg_address, value, mask);
> > +             return -ENXIO;
>
> In this case it's probably better to swap conditional to have error case =
first.
> This is standard pattern elsewhere in the kernel.
>
>                 if (i2c_address !=3D d->pmic_i2c_address) {
>                         pr_err("%s: Unexpected i2c-addr: 0x%02x (reg-addr=
 0x%x value 0x%x mask 0x%x)\n",
>                                __func__, i2c_address, reg_address, value,=
 mask);
>                         return -ENXIO;
>                 }
>
>                 return regmap_update_bits(intel_pmic_opregion->regmap,
>                                           reg_address, mask, value);

Oops, I must've swapped these when I did my final audit before sending
this patch. I'll go back and fix that for sure.
>
> Or leave the inner part untouched as it's not the main part of the patch
> anyway. This makes the patch cleaner (however it remains 'ret' to be defi=
ned).

I might also do this, keep the ret variable. It's probably a lot safer
to just keep some of this logic the same and send a second patch that
updates this stuff.

> Up to you and maintainers.

Of course, if the maintainers want something else then I can also add
those things to my v3.

best regards,
maxwell

> > +     }
> >
> > -     return ret;
> > +     pr_warn("%s: Not implemented\n", __func__);
> > +     pr_warn("%s: i2c-addr: 0x%x reg-addr 0x%x value 0x%x mask 0x%x\n"=
,
> > +             __func__, i2c_address, reg_address, value, mask);
> > +     return -EOPNOTSUPP;
> >  }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
