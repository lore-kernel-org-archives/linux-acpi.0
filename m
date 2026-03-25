Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC9623F40D
	for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2026 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774445579; cv=none; b=PBNalwMqXQZhSGu8T8MHkzmKnmorjVF1EroSeYp7SpRGjCCd3kaayT8Xyb9AGX8ltPY2LBWcIoWJzE1kcC945wn0tyIIL7kCoe33/NEIYFvpRzY58T8yHRD0oER4GrscCarbWSHzRXna/R/NJ9SB3AAkWESEyJwy5u0wp8yLq1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774445579; c=relaxed/simple;
	bh=NN8UioJcRHKdN89Z8PpqB5u1g//q5a9FN+5Ve6sKkms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQ7uoBqILSqbmfvqDqvdNvt8aD7NdjMwx2qB/0BprazSZOf5cWOqBOa8Dzll2azXOQqqleZjYbXHlYP3oT8S176xRmryKwxVNj2TQyD+eebEpS+UTxyLDvLhOcoib7IYs5vdJBliR3yAYn2VnBtAxYJUb0MdgZdhaFxn8wPTLDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXTELgVg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXTELgVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E3DC4CEF7
	for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2026 13:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774445579;
	bh=NN8UioJcRHKdN89Z8PpqB5u1g//q5a9FN+5Ve6sKkms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NXTELgVg6M6so3U0TFY8RNa/J2q21gle7ougpx5HWKW4GuBVHsvVYzWfWVLaLa5cN
	 6FKu079gSXMMbZQw3s/NG9ckcpfkbnQ5qQRAaKiL7CPScfp/sCkdzgPSYXNd6vrchy
	 1/upqRH88TGxIfTotVlPnPs+xq2cXGjsjdWwXnLVKNnhxYCjZxcbOyuxlwYYU1oObM
	 S3z9ILu5vnmjvzBWIYEGm7supXztfvCE6StRB4vLgWd0zgIo96K0/zAtz+aSj/9Tgq
	 Nxq88ZM+/as9XNc8aHdWcQOxdX17T0Eqa2rCpSKxlg3d3v6akSowiaA3x7xQfAZ1yx
	 jHqr/RFk5r/uQ==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-46726528f1cso4412352b6e.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2026 06:32:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHDtUhmm7PVRmg7zgh1/7I02VuJLoYmE/TiOtK9cxJ6UtSILY2u5BTPq+UlHDkudf0/29Avo8SRTar@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5x32WncfcYrwV4KLpEGLBagY416FzoHpEqnjumUc9EGb3R1Tu
	KJcAvh4TJmbSm/waak/ajS46Zh4MjphZllIXzWp+S/8nRqHgH5KUi0DbeMd5xmr1r5bvxG9Ed8e
	bAHeklWdvQDV7Xf0TQVSwvjNOTOon7EM=
X-Received: by 2002:a05:6808:5187:b0:466:f3a2:dc34 with SMTP id
 5614622812f47-46a5c79da6amr1489587b6e.36.1774445578102; Wed, 25 Mar 2026
 06:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324113300.1002569-1-ben.horgan@arm.com> <20260324-nostalgic-adamant-coucal-7afd8b@sudeepholla>
 <CAJZ5v0gn5NTdSj=i5iRpK03kT0V-UshADp=VaaEAO=wzLsjjUA@mail.gmail.com> <20260325-laughing-coot-of-piety-e2bdff@sudeepholla>
In-Reply-To: <20260325-laughing-coot-of-piety-e2bdff@sudeepholla>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Mar 2026 14:32:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jcf0tQ-Ghdi=FZE7gsKXEVjjbfJ7_csnm3_+DG0FzPBg@mail.gmail.com>
X-Gm-Features: AQROBzAdgeGg7wDflxTDlwovz2zOFiIUgQkCUeTXgIIuFPhJEsod9f-TVAWKSqA
Message-ID: <CAJZ5v0jcf0tQ-Ghdi=FZE7gsKXEVjjbfJ7_csnm3_+DG0FzPBg@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI / PPTT: Remove duplicate structure, acpi_pptt_cache_v1_full
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ben Horgan <ben.horgan@arm.com>, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jeremy Linton <jeremy.linton@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 12:53=E2=80=AFPM Sudeep Holla <sudeep.holla@kernel.=
org> wrote:
>
> On Wed, Mar 25, 2026 at 12:45:27PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Mar 24, 2026 at 9:43=E2=80=AFPM Sudeep Holla <sudeep.holla@kern=
el.org> wrote:
> > >
> > > On Tue, Mar 24, 2026 at 11:33:00AM +0000, Ben Horgan wrote:
> > > > acpi_pptt_cache_v1_full was initially added as a stop gap until the
> > > > equivalent structure imported from ACPICA, acpi_pptt_v1 in actbl2.h=
,
> > > > contained all the fields of the Cache Type Structure. Since, commit=
 :
> > > > 091c4af3562d ("ACPICA: ACPI 6.4: PPTT: include all fields in subtab=
le
> > > > type1"), acpi_pptt_v1 contains all these fields making
> > > > acpi_pptt_cache_v1_full redundant.
> > > >
> > > > Remove acpi_pptt_cache_v1_full.
> > > >
> > > > No functional change intended.
> > > >
> > >
> > > Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
> >
> > Am I supposed to pick this up?
>
> Yes please, IIUC we route only drivers/acpi/arm/* via arm64 tree in gener=
al.

Done, thanks!
