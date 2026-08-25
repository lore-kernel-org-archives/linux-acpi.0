Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114D13FE34D
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661193; cv=none; b=LIUK25iZaBkwW7xtwWyFv1r0Q5yuXTRcZpcw860m79vC/Eq2Te9RvsF48eksJF0Ukd2jJJO1j0Uu1cAj+pcTmkhcMdjNN1WHPXDi40JO+0c0I4XBucUfnUV5GnvXEBSBsygUW7t3sN/gVsLMBF5n4bUvUl01RB3s8bLJTxJyReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661193; c=relaxed/simple;
	bh=4GPpK4rgbqMngzdy2m160jQnU8pj8Ok8Bp3jNDaEMnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdHEo9GaLBBamB5siL2kPY4QRBzIQogpK1ogTdeA5BpKCoGT/86p7YTNFk/R4x//clrnLlPj9K/EiLGSo72lA1jxirno0vqRZortX4cY0c9xnSBmr05GgLbKubMs8ZFxDPcfYlXC7NslVMB63izXclSjnPN6tlPZtYY+W7cy7d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLImhWAZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLImhWAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83111F00A3F
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 12:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787661189;
	bh=/4/soMTIHV4EUYsgKjjKZ9t3pL03gsVrPPYA1p7SBBk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GLImhWAZXsPI6wRsegev/PQL+icqT36CO615YP+gFEz5c/vIOGX+B8/qSbd5mTX75
	 mVGxZ4mGuLYN5yrza0Ob5abUPKg6OgCd9+WQR4MzE3GPTk/1WoFfDnlgyAA5YLSQXB
	 4HacTTV7ShWkRx7xPE8z+VBP8t4s30rXwrymkC0745dTQFVH6pawmzW64BGqB1UkKL
	 6fW5y7YyaqEHJj4+v6sf+ECAlfqJSJsCYI5i9ekGaik0UrBa3RPBLB/cpk/qXvWg86
	 X0yFVmZf3yeyE47pHar9KT4l82K/WJjkWWtbIOY958/MkfWZVv2hm3u0VgzPfR1n/q
	 tFjoroUoWO3hA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a1f75277f3so1369091fa.0
        for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 05:33:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpBHGtLhVRb/O6V2NbKlEUuRBDZSu/kihm4Rkm611L4hBgHEvRScaI9L557XX28KpR8gP70TOzL+UVo@vger.kernel.org
X-Gm-Message-State: AFuF++lb0k9f2y3OAzwhcgzm+FipU5+ZIwiPwYSwRRhvEfMIN/qZrzhX
	ZJ3r4hMwwOeh8KAc6Qz50vKVZNJNHHuoIQvN2gUVEHkFkaLidF9Li3KOkT9UnF5URN1e50iQS2e
	iYAxj7F4N65C7nwvWq8Hf3FGsgQRicwo=
X-Received: by 2002:a05:651c:2221:b0:3a1:b658:feac with SMTP id
 38308e7fff4ca-3a1ef603c6fmr14377021fa.13.1787661188010; Tue, 25 Aug 2026
 05:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824211338.3583976-1-sakari.ailus@linux.intel.com>
 <20260824211338.3583976-5-sakari.ailus@linux.intel.com> <CAJZ5v0h41GA+O3u40eaKUy5uBDGGzg_KOuRJi5GEEa1z_dh63Q@mail.gmail.com>
 <ao2Ezwepo6hBCOpg@kekkonen.localdomain>
In-Reply-To: <ao2Ezwepo6hBCOpg@kekkonen.localdomain>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 25 Aug 2026 14:32:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j66eOt4TP9JwHb-NOk6KunhanaYiQtwRSLPRRLcGRD-g@mail.gmail.com>
X-Gm-Features: AcwNN1W0CASgl-w2dYsPrUfVYmcBs4l8Z1XMorO2eBiy3jmDiogIj-d9WwB4UcA
Message-ID: <CAJZ5v0j66eOt4TP9JwHb-NOk6KunhanaYiQtwRSLPRRLcGRD-g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] platform/x86: int3472: Release ACPI objects using __free()
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, linux-media@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, 
	Daniel Scally <dan.scally@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 2:04=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> Thank you for the review.
>
> On Tue, Aug 25, 2026 at 01:54:28PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Mon, Aug 24, 2026 at 11:13=E2=80=AFPM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Use __free() to release ACPI objects received from
> > > acpi_evaluate_dsm_typed() without explicit ACPI_FREE().
> >
> > Well, the benefit of doing so is not entirely clear to me.
> >
> > At least there is more overhead in the new code, or am I mistaken?
>
> It becomes possible to simplify error handling mid-function. See the 5th
> patch -- perhaps squashing this with that would make this more visible?

Possibly, but this may also be achieved by processing the object
coming from the ACPICA code in a separate function.  For example

obj =3D acpi_evaluate_dsm_typed(args);
ret =3D do_stuff_with_obj(obj);
ACPI_FREE(obj);
return ret;

and the error handling in do_stuff_with_obj() can be just like in the
case when __free() is used in the caller.

Of course, you may argue that acpi_evaluate_dsm_typed() can be used as
a proper constructor, so this is all fine, but IMV it is a special
case and I'm not quite comfortable with defining a _FREE that looks
general enough for this particular special case.
