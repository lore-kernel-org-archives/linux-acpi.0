Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586916;
	b=EkjmyAN1qYjeN4EJCMSwcPRYRjHn5GpKB+raYGaDlNDhA+7lEPxg75ZLNJZkAl7fNEK6
	 r1fvAKuJBdOj6rDRN/tTq5OCdohPdogdeJCmqqnFOBnulIJ5jZqX/lbiXeJbZS907DLkr
	 8fV8UVGeOaNaEsoDbFmzlKWxEVcRWZcD1R1AzMne+WYc8bAgyDiQ/hHv4uRooBmDMWU3u
	 YEIKAwu6RSvrHrpFe2M+qVOE67SaIa8H+bUXjhqw6niNCuftwmAl5+tUxuzGpf1xJXzPz
	 lYls0CerdHmRGBk0FfUadJXEEuxHxJ02xqt7bHd7l45El4ZwtmtUw4dquD2XArNi93Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586916;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+VKfSuQjy++Fjxy2YGdpBhBllGH+kD5pPYBWRy71ETU=;
	b=ySIXNlfofBGoRY+wOze/P7mCKan/QLxxFNrrXV4wJLRExkBw2WWjzVA0vjEAnZSEHWy2
	 /GsNjBYG6PS84L9sB3NWWWXk86I9jPMOXrW2cb3HNKOdipVdZZENmM3drbbQL5YoobsBB
	 t34R4AUlAiimOTnrCscfRmqfnHq/PKEG2IJaGQScgCcDkFBA0dFVJRtnSj3UoealSoW0A
	 q3UGsIqH/l1eCf3OKcndKsGOPB3eLuwIU6q8TMJA4DgGfg1+LVEP37RuUh3cpDyxwbR2h
	 6GtOJ8baEL3QNIz71Yj5k6x6szjSjlMlPRPwybWX7vb115rd4tEdDMW4cGgTC+7qJAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQQTNcBv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855FE606A339
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQQTNcBv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643AB1F000C9
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794586916;
	bh=+VKfSuQjy++Fjxy2YGdpBhBllGH+kD5pPYBWRy71ETU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JQQTNcBvIP11OFjoRGL3VjLTra+mcG38pMOAUB3P85nKQLtjDUSpORrh5C3IqfCw3
	 6UvRZddukcA+Qph0OvWk7DzyQDZoFQTdVcvfcNtAlOLbBIFtLn4xiNCYEumKI89+hq
	 JhM181zObk1qIrHLqYmHJdDQcPYhKVEx5D/nEN+Xzrsz6M6KHMeU3VeeOlzPGScuph
	 4cPV+tMLioCgGVTxiIloluwiP3ugEd2G2aR85pBMzc+bzzyVR9eQ44g3anTXaTfBZX
	 5iD8EPC7N+fdC0E6t8trzgHThqCITOHd0VtdVsxG1wv0V9wwZVfpnhgRftPbXCirlf
	 rq1Z8dVaPnXAw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c0a520df2eso1673008e87.0
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 08:21:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEx5C7NlvR3LYAdpf72QYT2DtfbbSOzQbxZ5Z7qVEnMJFDC4wjE3GwmhpPBi5Les8I011QiCEgm10xn@vger.kernel.org
X-Gm-Message-State: APuU4Z/hQG6Od/iWV54lTOoTbSVnxqnHqtScz5IFu6qbOl+hG3iiI7po
	mIA43QRtkqS4DHyjN5vRA9Htk39qJYNjGJeQrh92ALp67QlnsK++hC2r3sdCC545hysacz4tih9
	ewAbVCDPAW4K8wgsGNzuZFok034+wR1E=
X-Received: by 2002:ac2:568e:0:b0:5c1:57d3:9f06 with SMTP id
 2adb3069b0e04-5c1709a1294mr1483206e87.31.1794586914722; Fri, 13 Nov 2026
 08:21:54 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <DC796DD7AB1437C8+20261112090954.1388267-1-raoxu@uniontech.com> <avb-JJur-yeedbFa@kekkonen.localdomain>
In-Reply-To: <avb-JJur-yeedbFa@kekkonen.localdomain>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 17:21:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hZfO01hw14Pf5nKwReJML8yvDuapSng9c=1M57pdxtJg@mail.gmail.com>
X-Gm-Features: AclHuK_bpQyvVno3ZCcHdbx4mFwW-KoXYWd7_RaiAp90jJbXEmy3bYe0rpPvORg
Message-ID: <CAJZ5v0hZfO01hw14Pf5nKwReJML8yvDuapSng9c=1M57pdxtJg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: property: Fix leaked buffers after skipped properties
To: Sakari Ailus <sakari.ailus@linux.intel.com>, raoxu <raoxu@uniontech.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 1:10=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rao,
>
> Thanks for the patch.
>
> On Thu, Nov 12, 2026 at 05:09:54PM +0800, raoxu wrote:
> > From: Xu Rao <raoxu@uniontech.com>
> >
> > acpi_data_add_buffer_props() compacts successfully parsed buffer
> > properties into an output package, but stores their separately allocate=
d
> > evaluation buffers in props->bufs using the original input index.
> > acpi_free_device_properties() only frees entries below the output
> > package's successful-property count.
> >
> > If a property is skipped because of an invalid format, invalid types or
> > a failed object evaluation, later successful entries can be stored past
> > the range visited during cleanup. For example, a failed first entry and
> > a successful second entry leave the allocation in bufs[1] while cleanup
> > only visits bufs[0]. The evaluation buffer is then leaked when the
> > properties are destroyed. Lists with no skipped entries do not exhibit
> > this mismatch.
> >
> > Store each evaluation buffer at the current output count before
> > incrementing it. This keeps the ownership array compact and aligned wit=
h
> > the cleanup bound without changing property order or buffer contents.
> >
> > Fixes: 103e10c69c61 ("ACPI: property: Add support for parsing buffer pr=
operty UUID")
> > Signed-off-by: Xu Rao <raoxu@uniontech.com>
> > Cc: stable@vger.kernel.org
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Applied as 7.5 material, thanks!

> > ---
> >  drivers/acpi/property.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 8ee5a1f0eb48..fb6b214f2335 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -523,7 +523,7 @@ static void acpi_data_add_buffer_props(acpi_handle =
handle,
> >               obj->buffer.length =3D buf_obj->buffer.length;
> >               obj->buffer.pointer =3D buf_obj->buffer.pointer;
> >
> > -             props->bufs[i] =3D buf.pointer;
> > +             props->bufs[*count] =3D buf.pointer;
> >               package++;
> >               (*count)++;
> >       }
>
> --
> Kind regards,
>
> Sakari Ailus
