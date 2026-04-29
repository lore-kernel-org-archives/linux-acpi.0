Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46643FBEBB
	for <linux-acpi@vger.kernel.org>; Wed, 29 Apr 2026 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469529; cv=pass; b=Zcl9gIKswnMvih+Y+VHh4Qeqj3k6YB2zI28iPm4MNavDIUk8Wdxw7PZRs9HGe2MNuqIQnAHXkV4oz4IBkX4/OY/fiFnaip8TaN27exNy9NuEr3iBN2MYxS33gDJFqTt3mI0oPtMFXhg0GYBmySDaWwpeYrfv5ePFyE8R3H1Sll4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469529; c=relaxed/simple;
	bh=PoVyAljFqqOe5DSHcezlWSetFDShhEIRDuok6xCAWKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sW+mEsIegmH6/xDwWkV6zxt3RpF/2GYWrjXljfkatrZPdsOJhd060hmfjym5mS5Wtzog6UoqQ9pivccrWcW7e8X5NvQrqyIDdvIN/cb0J/YN54UtEb571m831MPUOlwjIQYLT+1QfFydxQNaPsSSQVOAQ+sd2n0yflOaUdicMqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWfAkbfr; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWfAkbfr"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9382e59c0eso994759166b.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Apr 2026 06:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777469526; cv=none;
        d=google.com; s=arc-20240605;
        b=iJS0mqd9HsCfcBZvEtEhm82gXzSMItiDAZVD/+AlN7LUip2xGsVp2+c4qzlZDSmP5t
         r63D0wf6ECKyMOtqrGYzXgnP9XEU8beDFeky023aPNxDdYMqjDAzITM6AB9jdIImCidS
         /AW9PqnY0sndBl0UESUJvWFlUSvr9KZd+UyrCwzSzDRRymiu8BuHgo4UIWSpfcdpOEM2
         1qF3XE50MJwUo2UiUSm7NuviEw2xBYlZXK6vcXEqRN4LvEoV+9YHaN/vFJI1PbA89tkd
         aNcif2t5MB5If8m46vgigvAWymp5qBGHR7eD0b2o3C4HUHAkydOoVhgM/yMnGQ5I3nFg
         p5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iAiEJK1du5QDMkrZ+cB7tOxnSBWsNFxHiHecnvh+abs=;
        fh=tbTy6LUCRvrLuAyaCvXy2cr6KhsH25Vp4S715pPfmq8=;
        b=ghMeT5UahcIJREPc1cUGnLDyNatnHWBrWTQnPlqaV+fXZ1eLVx+YtNA9v2/kgNBlJG
         A/MREnfxjf/zE84Gj9lKdc6kpappA056KKmqQ60t4mFCw6A35W9qVOJIxdAP26LhCn/+
         EV1BMjJhyY3ng+BOxQoCJZY21tMmETeH1QtyhSKc3Vffvn524tVvRZF3vsgGHKgwPj6Z
         rtI+l96SEbYopr/gVuMp6ATv41NvQ7uUIH+KXht5c3a0AqBnYsexMYxy0K+OufaNoTDy
         FCHi3J5ZhRBA/ErFEFrgluAnERQZ4H/1WuIvcvSkYrf+j7TMRULJTLq3KMcHXfPJNjpu
         MdvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777469526; x=1778074326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAiEJK1du5QDMkrZ+cB7tOxnSBWsNFxHiHecnvh+abs=;
        b=DWfAkbfroIDxjNPXA/zRAOzB20R/5hC89AcSyzBXSzmPb1VrKv7PJ0t66iize/XQTY
         n8pVY+HhjAFMCkvsWmRiJHMOFkIrh/AU+qQzcl2WEsE0lg3y5HdrEvQzj8VwEcBWVmF+
         LfMPdyKpFgesnkBtCxkKt2mQVo5cyftiAS5oOkAgdU9Fe5ZQWR47oYAQ6PRWkZeg9mpF
         40xfqxAF+uuXPaTi6UpiKgrv9tz7oMcWJIxSx5uERiT6YyU2fMk9lEuldVxiGEn5NnoJ
         dzEo71ZChJrvyb+H08rO+MIy3dGA8ryqEgyhvQfnyL7hZVGtU5t44xaq069vT/eTkwmR
         +DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777469526; x=1778074326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iAiEJK1du5QDMkrZ+cB7tOxnSBWsNFxHiHecnvh+abs=;
        b=nIksS7hHe5dfxIdxlS5nc9LQ8ivRAIOHccBWLP7bD78P2/Vpq9hSnwKFZmlAiKuJib
         puZVMQ8753xkBJInHllxyx0sCpxEFBt2JS3byKDvwCtqFSLbk35S8NkV3wPsPHFY7ial
         u996EusxN8W8SxQHwElqIWmrvXzyW+Pel8jEbHoD26Whmgds7OkP9zEcQf4PmqxuURe9
         C0xC43zk7v377CFlSsLAYGL5C4aMJOBis2mL5lTmGBX2jwsQvaa6cmMuF2NskLRp0EC5
         cOPDYEh/141TLKG6z7W3ck9cJarYeADTPbg5iXqcYXjsL4cvhzBofkgQAEZ2nel1Jmk4
         7+Cg==
X-Forwarded-Encrypted: i=1; AFNElJ91fbgGBl7Fj+E49XSH/SkYUjkJ5NyX6dUVkGZegyuHPadPQttKorNmxTtRZAmBNPWZhymnAXb96cU/@vger.kernel.org
X-Gm-Message-State: AOJu0YwM7GwSXzfSBA+zebBUqF6FlG39Z+OzTbCRik1ajrzFV8tQud0E
	6pNiN9JAemuLxNnYclOz07hmpz6xWTW7cxv+JP0srhnTL8QYi6kTN/oj286hJ8tecrbNaS6maDx
	QhNd5ZbxVfQvCR7xfkGKPbpvZ/XZVY3S74pUS
X-Gm-Gg: AeBDietRINO9LQtY6OlDToZvcLJDRS7wfp4HE9c48WxmOAtNDADARj+4k03YEbkhl0u
	0Adyven+NuVqZvecJNc1NNS5ZVGupLzuyu8wuUqJidUhmNwCckYl1vwfMpaTACK2IHeyIaSKsEm
	a82SmKf6w0AQ4jILA2ycL9McS0GE3oS2kSo6keeYsVtttV72nuceZ2uVgpPBWuS5mSlRYo5p4MZ
	K0MYK/1yHH51kLEfmktcKuq8myAHFXCqc1fQJ3tglp2G+5pDNbAHjpVwhpsEH9XVee3ff+h6/zn
	89oWFSLADmoWPsXAe26BldoXf1lEjaTj4Zey7hsNak3TqfLBZ6R4u1E6QgmUy8i+1W+p9XsDAUc
	WpvnjjqbUsSv0ZANnn57wMJ9qFJxj
X-Received: by 2002:a17:907:15d4:b0:ba3:8a04:7688 with SMTP id
 a640c23a62f3a-bb803e5ca7bmr326046066b.36.1777469525090; Wed, 29 Apr 2026
 06:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429012432.120830-1-m32285159@gmail.com> <afHVeVavSJ2NZ480@ashevche-desk.local>
 <CAKqfh0HWpH_cgwqVw8YAg7BTDMZwhWVpLkh8RCwypcz_P1Bn9Q@mail.gmail.com>
In-Reply-To: <CAKqfh0HWpH_cgwqVw8YAg7BTDMZwhWVpLkh8RCwypcz_P1Bn9Q@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 29 Apr 2026 16:31:28 +0300
X-Gm-Features: AVHnY4Kkt9PmlcrQvqVCNOf9jSL3wDq6upS8TF5Ad8yZ5yK4t09DWwLweGGYwGQ
Message-ID: <CAHp75VfH2Me6=2HWNmsmwDY8jrKZaUzbN4WmO37bQ+CqpRM94A@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI: pmic: Replace mutex_lock/unlock() with guard()/scoped_guard()
To: Maxwell Doose <m32285159@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, rafael@kernel.org, lenb@kernel.org, 
	andy@kernel.org, westeri@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 4:14=E2=80=AFPM Maxwell Doose <m32285159@gmail.com>=
 wrote:
> On Wed, Apr 29, 2026 at 4:55=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Apr 28, 2026 at 08:24:32PM -0500, Maxwell Doose wrote:

...

> > It should be
> >
> >         int ret; // also left untouched, drop that from commit message =
as well

> >         if (d->exec_mipi_pmic_seq_element) {

I realised that the body below should be...

> >                 // the below if-else-if just should be left untouched.
> >                 if (i2c_address =3D=3D d->pmic_i2c_address) {
> >                         ...
> >                 } else {
> >                         ...
> >                 }
> >
> >                 return ret;
> >         }
> >
> >         if (d->pmic_i2c_address) {

...part of this conditional. But I hope you got the idea.

> >         }
> >
> >         ...warnings...
> >         return -EOPNOTSUPP;
>
> Alright, thanks for clarifying this. I'll make sure this gets in for the =
v4.

--=20
With Best Regards,
Andy Shevchenko
