Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD6541A8F
	for <linux-acpi@vger.kernel.org>; Wed,  5 Aug 2026 00:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890551; cv=pass; b=Yxvj8fjDIX3UIGMONLlfbMxtN7VBLYi5qGxKGmKc7LtFRLYhRIoS/FN/jFHE1Ch+zGZTKRuJW7iRpLxxGZ233JsR86lPakSesvjfzNHZZ3zu9expW0fqHQtFX8DP9GJtzNatUAp+oCQ9Dd3p8FfAkx0/t6v7ViVO8nYGqkVO450=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890551; c=relaxed/simple;
	bh=hROq7CiC5JPsDATrpjzdjLmqG19Lhm6AqmIFcAkuAYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lym8j8Q/jVjf5lXyDRBMT5cxGa8gH7kjn6DgHVesdLuJG+ghgP4MB983oJLz1EJa/HYiV7mKontGLjoiAeJHvQzBXDCd1Q5G/wMdyF+KRZeUUyfj8P6QoQLLwN6WUvjEa575g4ALZgBl8QDXQK6BbA7wharDKDqcHy+jO3EIdeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3I57TFb; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3I57TFb"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c2a818fc4so2628741cf.2
        for <linux-acpi@vger.kernel.org>; Tue, 04 Aug 2026 17:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785890549; cv=none;
        d=google.com; s=arc-20260327;
        b=mvWF6VcdFADif0HrjoLv2YUM+obG0ZT4kV2qqlZpORDtbamlD99dI50nm50zHRf0sj
         IR+rs5Lw3oGstdRqzCJx2Z9P3f0biBquMyMaucEk5xOiR7o0TcQZqNN1xgbqOSAARLTe
         3sO+bz6HcQOqTAcfEo9n4lx5QoILfNW1m4Y3RqoeTtidxhufXdx76nyy6vUsY0DiCUi5
         03IeAqU/qW28q9nYKMCpkR81RFMmIHSXGlBdiH5xBZbsUnIAFaWLB5V5yx2MjkubZAJ5
         jDZGNOw4QeX/AEWnd4zTZckKZ+kzrO3Kb1TkFJ3i74+leCtcx+gfowdficao1eK6ZeNv
         o8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EBErenl0PKIUTYIJwGdAQi6pU7uJpHdyknBzcAbqpF0=;
        fh=Jvgx4cmmEXytF48D20hQkonPy2qJlxDX4IPpE46GQJU=;
        b=EenzaqzJSuiJnfWap8EdcvfPqQN8MYVwy/Tl1Vra6kXy6WCHyT21x+qxxtrNTBXAMB
         k97uUwaG0JPiXXpIfuTrvtDM8jc84LshUf4FGJnDVywKX01LmjA8dY9Sx8PMvulHO8Wi
         VF+l1R8XGtAZoR8aaE8wo62obWLQLNCbZN4rwC+Sjdx7TQXJxwo+lI7eVYGbJ3VLbiRs
         wqKx2ql9EtnIQ5g8hT5G8Z2FnR31S5KZGIWSN/VrPTdMkflR+KRI7JmysMJUFNfGrYID
         WzZYXpIYlYQGbmILfDrLd6mRYq4io7DixUpcuSVD63TD+zoOHDNACpemTJXPjjySwG54
         KDkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785890549; x=1786495349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EBErenl0PKIUTYIJwGdAQi6pU7uJpHdyknBzcAbqpF0=;
        b=S3I57TFb+a8UhmGqH2j1zO4tfwXbA0gBHJb3HyUd92S5c7kx6y/sTaaKKGleDrUNJk
         XyljxUOx37sfycJHnsUQ7cz75SuMXaMoYwWqeCrGTM+fhdCqHusfDJjH9qfB/KBDc8IY
         CATadaB94s24XDCKYUPe0AtR/+GxjCtNQg7F+xrcPaBa7EI7k0Fx/fuVY25YgxRUpVug
         iyoENy06ripYvkxedm8bNlYKjeSPB3QVqsU1Vtzv7l+KvxK5YNJDAdT6ODbL6NmxsaWx
         zfWehnHcyYE3NDAx/j6DPjFdeGMhrrnb4kVU9L2mt/k9C554o6h5GwL4FJDxoHoMisx6
         zzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785890549; x=1786495349;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EBErenl0PKIUTYIJwGdAQi6pU7uJpHdyknBzcAbqpF0=;
        b=aCzp7DUKW4z5SEosgfbnUCNmA39i3/LTeLzu19jXOtYR3A9DWpC3uv3NavfkmyUxoh
         ro65SG0hx79lLqK/TgFga8clrssMi8Hr95LeuZ1Lw9B77aULqUmv0axUvC0GUD9JdTk4
         AegJM1zAohkBr+7Dh55kt3khh5VxmT6vMllhOj9tDc5jO1B8RBlf2gJEKU5HEuvvcjM5
         SkYvsBA4YiQgfs+7sNW9P5QhhlconiYRE+xvP8bNitPO16OK4IThONAmX0o0Zy1ynuiv
         6Nb2ouEqEoMsQw6a4Gj9WXJFxcm1ksN05BdDhBqQeGTWNj9jS9FWsXR+JEDD+xjPQpAD
         dTzg==
X-Forwarded-Encrypted: i=1; AHgh+RqMAHRDXUyKcUROo6BzaYV/6egaCbOFk4HgLuUtJutbv2erALUISK3l9CXLXmt5exLnbYs7efYtwI5D@vger.kernel.org
X-Gm-Message-State: AOJu0YxJmWQKz1L3BFLi4uEX1XUEj+zLCChdxaZagf7w1p6+m3bAGc2d
	OUpAnvy15TcB8gsEuiswG0BfHFLw50+9Mg5PBxyBUBxPUMrSWMEWz77lxNVa+6cbH6O8fg4QpRy
	+OcRddgVbDsi0MYmnh8z+y0Ha7JTowqI=
X-Gm-Gg: AR+sD11KCu9kr6pbghCz0lDACH0FQ00X1CLWCyAVPgvH0xnlRFA3JFvnLrObZAfTeeo
	10d0KHawb+TQic4BS3RLSMB6FhpaVZdTXTQl/puDThDGsAOE8zvdFB9dXFxqI17MpxayoYYveI8
	ciIDj/GDJU8u0s0mw68qllNuEcB93e9Y8PWbFVKl0aMRv2ZLuzpZXdjOjzsB4g23BURyf3Zv8GB
	NArf8SoJK1ONphlBQTLZ+DyqYrPmn21EuZ4Tn0VUnsnid1zSjx719nELJLBbzBo5qVUrCjMqrOF
	wvhCn5AmtGBAUJL+h1paJuHbAU7nMCzFJWo4JkAq2O0Wf6GUex02mp+R
X-Received: by 2002:a05:622a:4cc9:b0:528:2c84:eab0 with SMTP id
 d75a77b69052e-52ce618ca62mr36317771cf.33.1785890548216; Tue, 04 Aug 2026
 17:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803203459.10680-1-derekjohn.clark@gmail.com>
 <CAJZ5v0h78CSSORe_td1gp0n5DDWXN4zcnuXJsz247KYxgs-mdg@mail.gmail.com> <CAJZ5v0iY-SjCG3hdqggbchBA1DrYw04ARyNuzoyO67NF0dt2Ww@mail.gmail.com>
In-Reply-To: <CAJZ5v0iY-SjCG3hdqggbchBA1DrYw04ARyNuzoyO67NF0dt2Ww@mail.gmail.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Tue, 4 Aug 2026 17:42:17 -0700
X-Gm-Features: AUfX_mzXjOBFymAjv__F_-spSIDhui44c-22NM2c7rts6N8P-VdcblU9vHlQeSU
Message-ID: <CAFqHKT=4znAiut6LyaR2uWRGVTRGB4YZkWog+Fo0r_ukyq9H-Q@mail.gmail.com>
Subject: Re: [PATCH] acpi: pci_root: Add quirks table for _OSC support
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, David Box <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 6:08=E2=80=AFAM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Tue, Aug 4, 2026 at 2:46=E2=80=AFPM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
> >
> > On Mon, Aug 3, 2026 at 10:35=E2=80=AFPM Derek J. Clark
> > <derekjohn.clark@gmail.com> wrote:
> > >
> > > The MSI Claw A8 hard-locks on resume from s2idle whenever an SD/MMC
> > > card is present in the RTS525A card reader (10ec:525a, PCI ID). This
> > > issue is not present on the Lenovo Legion Go with the same card reade=
r.
> > > The primary difference is that the Claw A8 withholds LTR and DPC whil=
e
> > > granting ASPM control to the OS, leading to a split ownership. The is=
sue
> > > can be mitigated by passing pcie_asmp=3Doff, but quirking on the pci_=
dev
> >
> > You mean pcie_aspm=3Doff I suppose.
> >

Hi Rafael,

Indeed, that was a typo.

> > > in pci/quirks has no effect.
> > >
> > > Attempted quirks included use of pci_disable_link_state(),
> > > dev->link_state =3D NULL, manually zeroing aspm_l0s_support/aspm_l1_s=
upport
> > > via DECLARE_PCI_FIXUP_FINAL, and pcie_aspm_remove_cap() on
> > > DECLARE_PCI_FIXUP_HEADER. Only by disabling ASPM on the root hub is t=
he
> > > system able to resume successfully.
> >
> > So if there is a clash between the firmware and the OS, the question
> > is why it only happens during system resume and only for this specific
> > device in this specific configuration.
> >
> > If disabling ASPM globally makes the symptom go away, it certainly is
> > related to ASPM, but it is kind of hard to say what exactly the
> > relationship is at this point.
>
> Besides, does disabling ASPM globally affect what happens to LTR and
> DPC?  I think so.
>
> If that is the case, maybe the suspend-resume code paths skip LTR and
> DPC if ASPM is disabled and they do something to those capabilities
> otherwise?  LTR and DPC generally should not be touched by the system
> suspend-resume paths if native_ltr and native_dpc are zero,
> respectively.

I'll be up-front that _OSC handling isn't in my wheelhouse of things I
have troubleshot before. After reviewing your feedback I
re-investigated my assumptions to get a better handle on exactly what
the mechanism was that was resolved by the quirk and found some
interesting results. The LTR/DPC asymmetry and ASPM disablement were
masking the real root cause of the failure. Upon looking at my dmesg
again I noted that the quirk caused _OSC negotiation to alter the
PCIeHotPlug control state.

Normal boot:
Aug 04 14:33:12 clawa8 kernel: acpi PNP0A08:00: _OSC: OS supports
[ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
Aug 04 14:33:12 clawa8 kernel: acpi PNP0A08:00: _OSC: platform does
not support [SHPCHotplug AER LTR DPC]
Aug 04 14:33:12 clawa8 kernel: acpi PNP0A08:00: _OSC: OS now controls
[PCIeHotplug PME PCIeCapability]

Quirked boot:
Aug 04 14:37:48 clawa8 kernel: acpi PNP0A08:00: PCI Root Bridge
[0000:00] _OSC quirk: stripping support 0x00000006 (MSI Claw A8 BZ2EM)
Aug 04 14:37:48 clawa8 kernel: acpi PNP0A08:00: _OSC: OS supports
[ExtendedConfig Segments MSI EDR HPX-Type3]
Aug 04 14:37:48 clawa8 kernel: acpi PNP0A08:00: _OSC: not requesting
OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]

I then tested pcie_ports=3Dcompat and also was able to resume. After a
bit of back and forth I found that using pci/quirks.c and setting
native_pcie_hotplug =3D false on the root bridge in a HEADER quirk, I
was able to resolve this issue more cleanlyl. Given that, I'll be
sending a different patch to resolve this once I've more thoroughly
tested it to see if I can isolate it to the device itself and/or root
hub. Considering the possible performance hit you described, I think
that is a better path.

Thanks,
Derek
