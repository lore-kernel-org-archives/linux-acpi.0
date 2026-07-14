Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC2525B0B2
	for <linux-acpi@vger.kernel.org>; Tue, 14 Jul 2026 03:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784000693; cv=pass; b=QKBS7HgXaPGdfMruzNpFtgdZmhS/W0NNFD+goVOSu5zfvS4E5jv9Qsbd7l0M9aPvj4Uol4Vj6SCRZxYyHm2Jm6p9SK5FPTYefOoANzGLma7OknSomo19cV0RlwyfbFd98HE5GKxeMfe4bh9b8sPr64/R82eQ34i49AQyoBSArcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784000693; c=relaxed/simple;
	bh=S30/b2ZV0yovuoFAAkr8nIHsa1mh8oFG4t5ofhM6ksY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhWKhDYsaFHFWfdDy+gaTpPORwVlwAHkXxIhR0JPl1GDLyHl3xlPFP7DeJ18G6nOaiXD2a10raruIamksZBpI4P8jVMu/6NK/pf8DXoQA8hjDvAgOqkQ5SLc0w1164QY3asqlXuZr6UHGchNgedrqTv3OSYxQ+D3/cplkbmUj9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnahSndV; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnahSndV"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39b51882d71so4708401fa.2
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2026 20:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784000690; cv=none;
        d=google.com; s=arc-20260327;
        b=WOzdWrcVgf7ZM4T+D3NK+ef5yjtWCuRV4LvQCQ01ZU4JaoUueBrJqjElXI+D+rk8Ta
         3RjmBslF914Bo8qm++u3UMa2GFCJHC8RUvvZffzFpi0q9m2NiRRHn55dQKxlkpjZ/mtV
         MkCzx95wccIvJl1KLCvXs834GBuBXbJSz73em2ABt5w9ay1ZB/VHZQVEAAyNwW5SPlq6
         txYqgfkuKol8+4KP3tXzsOiESqOoJHh7VCsiIBn3RIijDOXn4Q7iXLDCRkJCXla4iJHQ
         FeET+CJ7yUPP/LUjq44qPvLNZw/HWD14P4yzu3nrF8+LehcFh7EGZMozW+xp892I+/8S
         IRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DdxhKCtHHL4au/QT2rW+2BixUXKkoNizAUMNiL/0+zI=;
        fh=TUxNlwufk/2TB3wwEgFaoGZSteSK/AuzgtUPxQZnXUM=;
        b=YvTcYt5tG+po8zq0B2LMRglUD3fbr98Konv6PJyrrbRZ4fZgaFTwzzZ3jAxwKcl7BL
         2iKc/MTAxnw1AU+li/tRytrn1PkGcTZkg9t8OJKDGCpmc/kS4RPqvYT8IDEFzmxeAUW8
         Z0ErMsybxgmZHfCGPyYekfY1/t1ldDEov0Nn3D3G/1aDs7HeQuToeIMwtzUgpbJC3slI
         Ed3IWHyjI/KvV/aCSUkkLzZtHUq+EkHk2Mkjrsz0Hkyf1mp8yZg4LsA643IfjTbrc/Bm
         gQ/N5at40oy2IqsEPdu+HCvVvVgueXkqpkFrT4E9S7XbgFlvRZ2gG8NNFFvGnCJOdnLi
         Cfqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784000690; x=1784605490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DdxhKCtHHL4au/QT2rW+2BixUXKkoNizAUMNiL/0+zI=;
        b=bnahSndVj0vcIgJDjCgAU/CEJfl8EwMJtS5ncNej523BTbP0ZkHV2PkuuXv+l8zdri
         POSkRjrTUEzlCn9Aa28nBhvDRc6xtPezkDqefARmfSQJiIbbChsAF30ToRH75OKQbQ88
         cXmhIRI9VvQ+Vf/pzYK3OFNVDqypZK/uOQU8ekMRABiOdFItP+8RBD0ldm7O4AzMqeP7
         k2RM4NlhwGXrzW8qzIroPqCDJ67e53+1IWa6zP5YimR2BhnsaSotRTX3cFCTYP3MwJ7c
         ofUOsW+xch4fZikIp9H6bvhYbjtHvkVTL6Wy2eRFTRtIrJOSp7Ws2ds4EN87uoIxLBNF
         7KtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784000690; x=1784605490;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DdxhKCtHHL4au/QT2rW+2BixUXKkoNizAUMNiL/0+zI=;
        b=s5q6quS8o5tJKKki/aL6iZE+JeMZCfw7rrTkdks7H4yAgYmSyTYVrpRMX1UMk7bB0f
         T6K0OHQUJDNoZtftXl2o+hpCN0k7IcGLZadRPx0nPKFOnp1rWVMn/WroXEjZFrr5D0sa
         CWajlWUQjRmps88ulhlsmxXorkJzRGpIEDGVqFVxU4gHU46G78jWL15s3DZnB0FwblqV
         20sd8MPIUVyK3UY60jxgBVgVQ7iVagsgYw2t56KYBPO9BD4vCWDuA3qlz+fEHNB0wQXF
         eLi2B+SSsLjn7g4HCDNUTF+8CmIBq2IL5nX5CvW0Bqf4FP5BWKe6KK1e3FVWpEjSIqTD
         /B+w==
X-Forwarded-Encrypted: i=1; AHgh+RpAQT3ltSgHZW0agHsmN/vvJg8cboOU+kcOEHM6DktVh4vorT9wBmA328E44uRep7pTp6FbkGdcRyfO@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw9MK0+BO+ds+IhWFuWU32bp2a7dAxDJKYgffGtwIsUTnm/4CJ
	v1q+biM13Ii/MAl072Z+DbjUbZl+3EHdCGaO+CbityssLq6+a9XFXEQc1a7GPzkf3Zh9kBrsGNO
	JQ1P2kPh98+aUkSGtUeqibGz4kCx3UcY=
X-Gm-Gg: AfdE7ckIUcTIJ7aqmr+U+joe5OCdFV7/y3HQ36TgFtuAV1ATw1WPl69jnl8TiOm21Pf
	pZFB0jrPMMVl/DEfTOIb2QLcy3leDh/J+MSmfD7b36YaRl8Qi22UdCnRLqY8B6ywe0Pa555X+sf
	52WGvVQyRCzrdcelpr6bLjcdLV8dDFrTgc0O8rN9t3JoeTJaCRDgj3oyug/5ZfQaIHZtrU3FsnV
	QYO3+9aUTM2VqNXvRPp9jDK7S3v011E8cz7JhqVzJH3QJ5bdrkhWEWydmXWD2TN9X/AhjlUa5o=
X-Received: by 2002:a2e:808f:0:b0:39c:6eaa:da85 with SMTP id
 38308e7fff4ca-39caa879118mr17381451fa.26.1784000690199; Mon, 13 Jul 2026
 20:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711062249.503264-1-vishnuocv@gmail.com> <142193d8-3860-4d9d-acc8-5b6a0569321a@liuxiaozhen.dev>
 <960dff77-b5da-59c5-bc61-c1a72b2748e7@linux.intel.com>
In-Reply-To: <960dff77-b5da-59c5-bc61-c1a72b2748e7@linux.intel.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Tue, 14 Jul 2026 12:44:11 +0900
X-Gm-Features: AVVi8CfseroMYu_hx33yWa7fWM0oTluqsrJ9rmiyd9uFtx93ZC1kIaSVoVP4_fI
Message-ID: <CABxCQKttBSR2LvghVwMSTVBwYFieCVXc=O64+Ya=xOAB=fdBgw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Fix USB-C Security probe
 failure on unsupported platforms
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Oliver Lin <oliver@liuxiaozhen.dev>, platform-driver-x86@vger.kernel.org, 
	linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, vsankar@lenovo.com, 
	Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oliver,

Thanks for the quick follow=E2=80=91up.
Sorry for the wrong email address.

Thanks a lot for the testing.
The other errors you encounter seem to be coming from the think-lmi driver.
I will note this down and discuss it with Mark internally.

Ilpo,
Thanks for the quick follow up.
Sure, I=E2=80=99ll send a v2 of the patch with Oliver=E2=80=99s corrected e=
mail
address and include his Tested-by tag from the follow-up message. I=E2=80=
=99ll
get that out shortly.

Thank you.

Vishnu


On Mon, Jul 13, 2026 at 8:17=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Sun, 12 Jul 2026, Oliver Lin wrote:
>
> > Hello Vishnu,
> >
> > It looks like my email address was recorded incorrectly. My address is:
> >
> >      oliver@liuxiaozhen.dev
> >
> > I'm currently testing this patch and will report back once the testing
> > is complete.
>
> Hi Vishnu,
>
> To make things easier for me (and me less likely to forget while
> applying), could you please send v2 with corrected email + the tested by
> from the other email.
>
> --
>  i.



--=20

Regards,

      Vishnu Sankar
