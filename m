Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793289934;
	b=fh0q95GQClU+25b3YlCbkG6sQrA3o2yVIcAwlwdLFM/2L0rtNnFsvpiEpZ+ZjfJzupwH
	 kfHCp/167nULSepTGxNvNMb8a2tpR01GyS+MEv5r6aaCIXD8NJRNECL6PqUjrJJiyzHii
	 vbjDfKc2hBgy+cpKOKUW4PANMp1DYpDzPlIkd/KAfjkIr5XxxIi9v+kOXg/XZn14k0JpQ
	 2eWnuB3xe2OILybTUVTsKl+m4vbt+2XEDwXLiL1aSURo2WptpKvpaLRX7eaEAzvjTuRKb
	 4OLw77iW8J7OVR1vfaURCTCNL3VCrloh6O0Kz8jdvJU6cOGrhj2fBId5SI7OYdAyUYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0JXYX5EZ25gVw84vUFaQsahBWpllYocPrdhCQ3cIQzo=;
	b=MroJxd0Xbz02ffvlS0+mPTS9E9aUyKUevzvWOedHz/NURl3/na7h50REEIfi4Fsnrq3/
	 xmff9aVd/MoY3alnAy3IvKtdX27/1KlEXloicMVXOKxXI6Y84GlTah37NcHT3Kyt324U3
	 S+Gv8YXSRhiwUkySxFANNqyMxPnaan4eytJiycigXqRBemxiNouy9k5aomD+Cl0j2hn72
	 zktAN7eb4Wns3NyRY+Y8FU49II2ahYAsX292qpeesYtiDWyuQIQzvgbP6Fbas0y0IURZC
	 DPIQwNI7gNaGREBA6zLmMfOlaAOH7K6mXycybxt9xNAhHQgGnf6em2BMXo4fbBXW7Eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zQ2xobcJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A2606A31D
	for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 16:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 843A2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zQ2xobcJ
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ea63087d6eso2254915ad.3
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 09:05:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793289934; cv=none;
        d=google.com; s=arc-20260327;
        b=WP5r6t1XsZcteoGtRzKyys0NcIfs5LbyHXq1/DbeVNKcBNHXV1GdjKJ48pEwrqSVrG
         7uIYaju6+8XkK5e7x25mwTNCJceZk3qBJFZA706PSQf9PYE5NP7TeV1AvfGWDKdID9It
         9IPdL+4oFiTk1Im59V2m1GgU5aMM/dNnu7qriMkEcfQVv5ZjCHJdgCuWitWUR1fBeuWe
         SVkT5NIn0ZvJWooSNgfWyEn+yXJu+uj6IcssGHpRnBMg9dpIiLu6xaIQ85sRJhN/rZjV
         k6lyoV0I6Umf7mWt74gC4uYHhQqy0+4NJi3GosPYYGMEjI3zRyDarKT4PV6rN9oadckZ
         OFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0JXYX5EZ25gVw84vUFaQsahBWpllYocPrdhCQ3cIQzo=;
        fh=K7UwCHVTihZdLYM/Ij6A2wfM9tKsvPiaB8bYiYqqioY=;
        b=jdol6hEVJqFUDs5raDspIh0617+n5Xoq2bGMTNiGaqOZMdDSl1eXmP1Vka5kbqLrB6
         Xo/qEVv0QnfmAnzR/wxh4DsEqYjADPHvgGtw/O++0plZy4bugj6fbzGGTfrybxVSUQGS
         BTdEjdhslJGjumrMRMl0VWFGJbmpWl6XPIRM2pnVdDNRtn89RW2q6gCBGGqZSXUUmutn
         LIC99RdNGWNA13M2FKpd0aXGEDTNlgkqxVyuuCM8lK0Qv8bYw38l9MzZR8D78rULqiQu
         0+jAoLpW6H8MOh1iDKwfBxktY4tihtMYJOdsgWpFwgAjvDY91Kxxc0fwehF3n+GOyQZf
         r5Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793289934; x=1793894734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0JXYX5EZ25gVw84vUFaQsahBWpllYocPrdhCQ3cIQzo=;
        b=zQ2xobcJc2WCeB4yrnqPsFba6JAqAxmbplihqRAZVzOx3p6GYApbNdp6xWFacITZc+
         uwpUIiLzmiOyKFfoT//wUpMH1wleyUVBDH+pvUP6p7Es9PfbA9zl6fl7XItOMNqk6IQh
         2rExyyBIl60B2AnEp0071wn7v+hFF5fai30eee/ahUfCPbbGLLYdXTOFLdsiN+JWRXYa
         jJ6nIuukOfywIlaXJ3BU2IUS/z6uIGwDtqUocn1ncWqiGpajme+zq0JGiFwsd6XhTUnY
         uuNE8Xh1I1hrvJ2qTH20vUb5F7KQ8fwfgegS6y3RIq9eAkYuzVhm5sGnoPAY4PY6FMfU
         KVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793289934; x=1793894734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0JXYX5EZ25gVw84vUFaQsahBWpllYocPrdhCQ3cIQzo=;
        b=ZPQ7mlBH0E1XbAh9CI5gfkXUs+YFPABw6CzrinoNU5ATC6VWiglOnt/6XgehxEgrfu
         ygcGm6TUlewgnSblQ00CVTfWepnzFXp4cD40luvfiFQ5HkUMzAFChihwLz62q8Yyzs8U
         Im8m9gbKMbpU4WyKRglB+ShaIpn8nu6lwsNhB+PrO9e2lLBvgNzZ5X073zzQ0RZJUPRh
         HVdsQBTK10mw4LEIUop9pgQbW9gO0qFqYh267Yki9F210HOp0fAavwHlB2tSYWBGm53p
         HAhFsnI56dtv1eWWS6iXD1qKVLGO4staekgsQ5EFYVduEAgcAJT9inqfgh66xsFhuP2P
         y3kA==
X-Forwarded-Encrypted: i=1; AKwUvByWR0O0Up1IpnPUS0nFz5g2JdjlY7VvyOXBhpzXYNXsfVEhdjRTheblkpDQYGdRR91t0+sRkonNr4Uz@vger.kernel.org
X-Gm-Message-State: AFq9FYIL9jubaESTinm1lWcXlMCt0/qc6fgNWiIEgziy2RlF6bwOOXu9
	xQbCgrp8E8sK/3nrqvNwPc6fjx9ZdnKnVLtocjuVDENaDk+4hDWJqYHtXP7by7EOQKzSh42zg+U
	LM1RIKnZnx31ZsHcC/Hlv1VJ+/EP3dpA=
X-Gm-Gg: AYBFou0xuY3YO/JzABzJak197yarUfW4gLHJPAHmXOSuHAF+inh9NJCa9yiBhQSpKYg
	YgYWoAWVb1amfSXjSu8PX5DEpu/qsFc72qwLsw1pGmPlP+c5DVmPpfyDzHvfe3tKhoFclTVpPTN
	ng5l4QueXi92Q8YiqH6KDrbi94wZgMdYOpYRQ+ejVUDmwYTbmwsCPcvSSiZ0V7+/tBxAMtt5kus
	qXtrm9fo68ON0XeRN5msa6CeOx3KWneCOr7G2iQNnkH6GwYAtxbYFmWgXn2UpJ3kSvceNYW8GBd
	FRVb35k0ut3fobu0aDcdndQpeu0VaqEH4hB6maPRAuNMRqfGc94Nmq6WOjR+DRBLerLRUV0JE7H
	t77Ef7+3FmpaLZRcni6p7IzNBYbmv+jP/2xDn+6upZcJWTrNjAfxJD/jg7AueXlXFK5NGHxHU5l
	n7dYROtwpInKZQMgKLbk8i92M=
X-Received: by 2002:a17:903:2f0c:b0:2df:8909:f719 with SMTP id
 d9443c01a7336-2eb004ec779mr101640265ad.3.1793289933884; Thu, 29 Oct 2026
 09:05:33 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029151422.56791-1-mike@fireburn.co.uk> <20261029151422.56791-2-mike@fireburn.co.uk>
 <06b18cb4-cd1d-48b8-8944-dd1139ad18ad@kernel.org>
In-Reply-To: <06b18cb4-cd1d-48b8-8944-dd1139ad18ad@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Oct 2026 12:05:21 -0400
X-Gm-Features: AclHuK_SzmCZ77Ax6albOg9ENipNfBXsoIiRBPAplK8_vOS9447MyCGtIC5RQss
Message-ID: <CADnq5_PbewORwc3Wsqw3VQESz3RNAKJy+KdnWHx9J1rKg35-Hw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: runtime resume dGPU on ACPI notify from
 its own node
To: Mario Limonciello <superm1@kernel.org>
Cc: Mike Lothian <mike@fireburn.co.uk>, amd-gfx@lists.freedesktop.org, 
	alexander.deucher@amd.com, christian.koenig@amd.com, 
	dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 11:26=E2=80=AFAM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> On 10/29/26 10:14, Mike Lothian wrote:
> > On BOCO platforms the SBIOS can signal a display hotplug on a powered
> > off dGPU by notifying the dGPU's ACPI node. On the ASUS ROG Strix G513Q=
Y
> > the USB-C DP alt mode lanes are driven by the Navi 22, and the CPM
> > D3cold table handles the HPD GPE with only:
> >
> >    Method (_L05) { Notify (\_SB.PCI0.GPP0.VGA, 0x81) }
> >
> > Nothing in Linux listens on that node: ATIF is bound to the iGPU and th=
e
> > dGPU node is not an ACPI video bus. If the dGPU is in D3cold when a doc=
k
> > is attached it stays off, no hotplug reaches userspace, the external
> > displays stay dark, and the level-triggered GPE keeps firing until the
> > dock is removed.
> >
> > Install an ACPI device notify handler on the dGPU's companion when BOCO
> > is used, and request a runtime resume on 0x81. Runtime resume already
> > re-detects all links and sends a hotplug event, so the new displays are
> > picked up; the device autosuspends again if nothing is enabled.
> >
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 31 +++++++++++++++++++++++=
+
> >   2 files changed, 32 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index 7974f9b7944f..deb63122828d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -641,6 +641,7 @@ struct amdgpu_device {
> >       bool                            need_swiotlb;
> >       bool                            accel_working;
> >       struct notifier_block           acpi_nb;
> > +     bool                            acpi_dgpu_notify;
> >       struct notifier_block           pm_nb;
> >       struct amdgpu_i2c_chan          *i2c_bus[AMDGPU_MAX_I2C_BUS];
> >       struct debugfs_blob_wrapper debugfs_vbios_blob;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_acpi.c
> > index 7f5abb03be1b..a4041f90b374 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > @@ -1280,6 +1280,23 @@ static int amdgpu_acpi_event(struct notifier_blo=
ck *nb,
> >       return amdgpu_atif_handler(adev, entry);
> >   }
> >
> > +/*
> > + * On BOCO platforms the SBIOS signals display hotplug on a powered-of=
f dGPU
>
> Although your system is a BOCO platform; I do think this same thing for
> this signaling to wakeup could apply to a BACO system too.
>

I would doubt it.  In the BOCO case, the OEM has a mux on the HPD pins
and redirects them to the EC when the dGPU is powered off.  For BACO,
in most cases that is just PCIe add in board so there is no way to
redirect the HPD pins.

@Mike Lothian does your system have ATIF?  This is already code to
handle this.  It sounds like it's just registering the wrong ACPI
node.  You should be able to use the existing handler.

Alex

> > + * (e.g. USB-C DP alt mode HPD wired to the dGPU) with Notify(<dGPU>, =
0x81)
> > + * on the dGPU's own ACPI node. Nothing else listens there, so wake th=
e
> > + * device; runtime resume re-detects all links and sends a hotplug eve=
nt.
> > + */
> > +static void amdgpu_acpi_dgpu_notify(acpi_handle handle, u32 event, voi=
d *data)
> > +{
> > +     struct amdgpu_device *adev =3D data;
> > +
> > +     if (event !=3D ACPI_VIDEO_NOTIFY_PROBE)
> > +             return;
> > +
> > +     dev_dbg(adev->dev, "ACPI notify 0x%x, requesting runtime resume\n=
", event);
> > +     pm_request_resume(adev->dev);
> > +}
> > +
> >   /* Call all ACPI methods here */
> >   /**
> >    * amdgpu_acpi_init - init driver acpi support
> > @@ -1325,6 +1342,14 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
> >       adev->acpi_nb.notifier_call =3D amdgpu_acpi_event;
> >       register_acpi_notifier(&adev->acpi_nb);
> >
> > +     if (!(adev->flags & AMD_IS_APU) && ACPI_COMPANION(adev->dev) &&
> > +         adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO)
>
> I'd install the notifier for BACO as well.
> > +             adev->acpi_dgpu_notify =3D
> > +                     !acpi_dev_install_notify_handler(ACPI_COMPANION(a=
dev->dev),
> > +                                                      ACPI_DEVICE_NOTI=
FY,
> > +                                                      amdgpu_acpi_dgpu=
_notify,
> > +                                                      adev);
> > +
> >       return 0;
> >   }
> >
> > @@ -1344,6 +1369,12 @@ void amdgpu_acpi_get_backlight_caps(struct amdgp=
u_dm_backlight_caps *caps)
> >    */
> >   void amdgpu_acpi_fini(struct amdgpu_device *adev)
> >   {
> > +     if (adev->acpi_dgpu_notify) {
> > +             acpi_dev_remove_notify_handler(ACPI_COMPANION(adev->dev),
> > +                                            ACPI_DEVICE_NOTIFY,
> > +                                            amdgpu_acpi_dgpu_notify);
> > +             adev->acpi_dgpu_notify =3D false;
> > +     }
> >       unregister_acpi_notifier(&adev->acpi_nb);
> >   }
> >
>
