Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A07370D7B
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 04:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784607393; cv=pass; b=b03Y9epJQ5fH0qd63uskWtty82bagSRxBRKACzzD8h0znPaAJ1tnWxZ3PkM+kA99NT3ASk1HXMi6YrvXKMizS2Us1KorBqGoyMTBvjGoOn5eQxOFg/zADXIchFodlTqg/BJLU8XSTj4nAgEinG9u2mSt8jtm9z6sRfEn1e71gNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784607393; c=relaxed/simple;
	bh=j75ov8FablcKZ/Lns6RuqNxjEq0qrKGRJPQHwnoRO5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imtolFyuHSn+eKb1vbpj35z6ZM/NRBaRKhqkuPZ7xpiNKjWgArP5+seX4lqPMQnIHPLE7s9z6snYPQbrT5AqZEHZaE3o7yiEgHkHyJEchNpezpw4ArPO3mVPLXEZygO8YwUwrj8hlcKWJCtXQbDuCY7lHQSBjIQqX98bfk+teYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJZahAxS; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJZahAxS"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b2a3166398so858264e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 21:16:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784607380; cv=none;
        d=google.com; s=arc-20260327;
        b=YGBycObhw48tg3VlfUd+rUUNVTSSyALa3PvCbntZvF67Z/Iz40uSmqrWSVdZjYFW2Q
         0k9pU7lSX4SWCPbM//g7f7mL+YNUWVfOoRzypBo9FEL9yGCltjXqtf1e8jrTOb8EJn5o
         4tlSYYtF68EEEdyc6KvOoF/onAAgvUfooAXLHO1JDyoiXOfT/22ZSlrweDAhG3jygI4c
         Ta8M7xb467nA5Ocd+09ODx4Ws3L9OlUGS4SgHwfoKRD+R5gxWDFM7LVKNrBCgtRtUnt8
         WOGvpCid1U6LDM4XKTGerQ1vGuECHJEIQI9lkM5KKbuKsUPnRaT1ro/PvGAGUUQ6yd3b
         JX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fgz5nyP5euNay+X/9QjjW7EW5yXJ17PBq+pdkqOJDcs=;
        fh=rLZdJ4sGaCvGfhiGnsRwIBDfaVvRIkTQyOApePOEaiQ=;
        b=bXAnSqtHNxbYk/yLvmrL2iyOVcHZuJ8re2dM8mFEMPw/FnGEnxkzE2m4i274ifC6mH
         fqqJ2NjMSkhuh8BoCpWCJtltvHG6/yX00s1rw8S7e2ojDWV7dnDX7qWYz0mskV/6GMKE
         a5zJaRcl2YR4sq9oajN8ItMx4hECEUZfRLYZ2+BdQd/hARxr6ylPpS4R5tdivyhTufsZ
         qWO55cD721sHEE05Zika6Rhf9rAd1xooQ9kiScFlq2VJ0FWt/boIh8qnPWujHwLGev9M
         UJt2eZso1HKnNpcqxNNWtRltsFiOYKOQt42alld1A23CDr1KBxSA56c+GqLF6CiriVB8
         NZ4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784607380; x=1785212180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fgz5nyP5euNay+X/9QjjW7EW5yXJ17PBq+pdkqOJDcs=;
        b=YJZahAxSkVn1o+noR+4Bz6roV7bNbxvRH/0GLqxUXL2JZg8jbEBmjGvEeLI/o0SJOx
         cly2WrvEzDCsqFenCoy8wkydWx+KcD+KFmkk8pn5SIXBWXGRz7AKFjuIAP3vW9LsSHtk
         JBbsjURRP1+kETLL/rHGN3TRTL+Bak47cuL9bHnaysEUBHn5JS5PaMW0nGG5AVpyHz1b
         l6+1F9ELol1rjUWqOTlo91skk2H9w38MQS3uV0hoBXvOzFhW2XRnx7pzDMp3dX9l+4D2
         uTiugKy1QL1GXHXX+CJ0OHROi/xU7E3HDbd04y4AavqJaMNBsO60xhAhLGImsUeIJUeV
         Ep/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784607380; x=1785212180;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fgz5nyP5euNay+X/9QjjW7EW5yXJ17PBq+pdkqOJDcs=;
        b=oSt97AlPUbcx69IhBBp+BMeZgxehSUoyx3gb0WH3BM2hRqPJjcX59DEmiAtloakFWZ
         XtVu0iSC/GT0re1W1vOv8TvHBRfNcpR3Yxd/MvSh8BKK8X5XY4r/4QdbzGtUI+4oKyOE
         RdAjNv3dI2g2GIUgdDuF/npRvZpVrnuy2VJZ5a+FFnYjmi2o8NNahX1VaT7FK+5irgfj
         81ZIhP8UTdUuWc1vZZ7oNKFJ8a8v1uxWFBKkLIj54IGhFtXUJuF/lSUFJqmqThEZyKF1
         9ZgiC0gD1qlzyIXQf+tSw1sXfvaOhusfM+eQiyRL8i30vMYVriSGLQVhArOERIE1at4T
         0uwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq7YIcyJQ6bmCBM4Cv8/q6NNTiQpZZxiHuhRW6e2tmUd+1/Fyny9q+omSSlvOt04WEMpVgr1g6uKjGW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlsqp+Q23RPwhQMDUejW2nBUbxUgcPDc6LCfqSiKTbdMCmhPuG
	22VfuFSqc9v+aNkiYyWEibCi+G6eRdLIoEEKwucJHTft+LbUb8iIZP59gICO4lEDpkiLx8DCTlT
	XC31tYybhXcfsfzYXpoys6X+vkMbJM2c=
X-Gm-Gg: AR+sD128IM+unkObpeO1Yh61VCPu1WVjGOi2a0YG9qLe3c/6kg0n7t2OEin+qd5Vxle
	GaP2emw0XqwOrBkInyvIpRsBES4/gBRXBtikxILZepUcpZdYrCcXHaM+7XOJV1fWRiysK9nq2Xr
	iA5ZOaTRHbKBcltcyfZlmV4RUGqvmifKhRgBRanycCGuzkU2YdYAnftXvVUgyk64p1aXUbe3xko
	5apJbi4+Rfh+wR0FwmMA8L+lgl+1VQDgNkClRjpTqTHg1Ufxfy3oRhj+g==
X-Received: by 2002:a05:6512:2388:b0:5b2:9599:b5c7 with SMTP id
 2adb3069b0e04-5b29599b7e9mr2457086e87.41.1784607379665; Mon, 20 Jul 2026
 21:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715010205.514132-1-vishnuocv@gmail.com> <178456545819.1362.9472740011574577381.b4-ty@b4>
In-Reply-To: <178456545819.1362.9472740011574577381.b4-ty@b4>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Tue, 21 Jul 2026 13:15:42 +0900
X-Gm-Features: AUfX_mzL7VZoNxPc38XciwYIMVYpJM0rTJkbk5DUX1wYGjWdBz1QhC-p6fEbu5s
Message-ID: <CABxCQKtRAoL9wjD8VYeKr5fC3h7n3rr833YbcitY2G5x7eq93g@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: Fix USB-C Security probe
 failure on unsupported platforms
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: hansg@kernel.org, oliver@liuxiaozhen.dev, 
	platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, mpearson-lenovo@squebb.ca, 
	vsankar@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

Thank you so much.

On Tue, Jul 21, 2026 at 1:37=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 15 Jul 2026 10:02:05 +0900, Vishnu Sankar wrote:
>
> > On systems where the USCS ACPI method is absent, acpi_evalf() returns
> > AE_NOT_FOUND which maps to -EIO. This caused tpacpi_usbc_security_init(=
)
> > to propagate the error and thinkpad_acpi failed to probe entirely on
> > unsupported platforms.
> >
> > Fix this by checking for USCS method presence with acpi_has_method() be=
fore
> > attempting to call it, returning -ENODEV immediately if absent.
> > This follows the same pattern used by other subdrivers in thinkpad_acpi=
.c.
> >
> > [...]
>
> Thank you for your contribution, it has been applied to my local
> review-ilpo-next branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo-next branch only once I've pushed my
> local branch there, which might take a while.
>
> FYI [if applicable to your patch], as per Linus' policy change, also
> fixes are mostly routed through for-next unless the fix is for a
> commit introduced in the most recent cycle or is clearly a regression
> fix.
>
> The list of commits applied:
> [1/1] platform/x86: thinkpad_acpi: Fix USB-C Security probe failure on un=
supported platforms
>       commit: 10bae492e814eeb1013ab9bc08f655d14fca46e4
>
> --
>  i.
>


--=20

Regards,

      Vishnu Sankar
