Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E11429812
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131628; cv=none; b=IRBBAKKTkROu1XSSAcodbY6ooN5QbkGaXFwdBKvseiTSu+Z0xugMQGA7u0NKswU54NMcKJbEzlv7+nCYU690BIclnXG4icQ2UpmHaWcAM/lORffa4K1byWADxDr8HkfQDk2CcQzzRq8VCn7RtntzQiu/QkqGQvAcW8YbXqKPySQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131628; c=relaxed/simple;
	bh=DPVi1n8ACDhfyUgJPgVQqje5SmRiB+YQicEQwIp8evA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ic/vsGuZuoSQ9WLn1a271pyhFg2XYI03wCChriX6iG2YgbKPHmBFsKwGfwYnz+uQdnlINLPqfeaqsvvJ59DsICZOLFVBukyoNyOZPpRslgdNgsokmNGvJuXvQnZqDTpv/grpi8AR2icphw8fPWZ7A1uLaGS/GHNKcPTzpXATflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raLkfqHJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raLkfqHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798B6C2BCAF
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 18:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772131628;
	bh=DPVi1n8ACDhfyUgJPgVQqje5SmRiB+YQicEQwIp8evA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=raLkfqHJ+qBJ8kzTn1oU7kIG/BDALCp7CjdmWdD9rTTJ2m3OCgfo5CqWKhD+FgNCa
	 LpO+DHsSqfWJbA+mjjXx5Y5Oowj7eHLAGSOSIxggIpgA5uoSY/6XV7x3C6lYaOF0sV
	 2xg9o/H4RNJ6mcfL0742Ohm+5DmnvQ3BWn5g7R8fTbrdGJtmF0rxO9AA+B3BlG3ho+
	 a+1Ksb4KeZY4Jead2ZsccphKPldYW4DQrrjWBdcA7I84ppc7FMuABXhnSEBr9jJPCc
	 PgoFhCsIfh7vYynaW02GJZUD4wxB7QuSxTM7YNjD9+miAMqqb1yW/WEA1onptEovM8
	 s1LD/DLESWYSA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-677bb1c3a9dso448827eaf.3
        for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 10:47:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGNo3V0RkB8zxmkksAh22+EnP0Jo31SUa+RMbo/BnoH3GNTPtbjaHgwaKmIDSAiUhfIIWwytKivQzh@vger.kernel.org
X-Gm-Message-State: AOJu0YxuzqC6p2opFBc5WmTH/b/iua06+IJoeScq0vzDJRC1d19Dn980
	DDaT38r0pr7zqQ1hT4hJot2myiqJKrEY3rBHgxW6WsJOZM1GiTLNygJWVRKaabaDKmNBMc8yfKy
	c6X+CsPwh4P/i/6x2fZfq6n5lIyeZAmo=
X-Received: by 2002:a4a:ec4a:0:b0:678:256e:d734 with SMTP id
 006d021491bc7-679fadf3a4fmr181537eaf.20.1772131627591; Thu, 26 Feb 2026
 10:47:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204212931.3860-1-W_Armin@gmx.de> <c5d23d8a-8f58-48c3-90ca-5d1a46964280@gmx.de>
 <CAJZ5v0g6w_2+4oUytzxHtAhsJczK9pe84ZfXPeOcjKqU0k_GkQ@mail.gmail.com> <6825e6b2-802b-4cd2-b2c5-b4eab67b00e4@gmx.de>
In-Reply-To: <6825e6b2-802b-4cd2-b2c5-b4eab67b00e4@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Feb 2026 19:46:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h7Nc2gUr_WaJSL4vEekhfL_4aojDWdkidnS=3T-=uxRg@mail.gmail.com>
X-Gm-Features: AaiRm53SGf0qDt2xdPx1eIHMn3WpNMQEldFKGCSBp9BU93PmPka_p0MC_MxKsPs
Message-ID: <CAJZ5v0h7Nc2gUr_WaJSL4vEekhfL_4aojDWdkidnS=3T-=uxRg@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: OSL: Poweroff when encountering a fatal ACPI error
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 7:35=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 25.02.26 um 22:28 schrieb Rafael J. Wysocki:
>
> > On Wed, Feb 25, 2026 at 12:06=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wr=
ote:
> >> Am 04.02.26 um 22:29 schrieb Armin Wolf:
> >>
> >>> The ACPI spec states that the operating system should respond
> >>> to a fatal ACPI error by "performing a controlled OS shutdown in
> >>> a timely fashion". Comply with the ACPI specification by powering
> >>> off the system when ACPICA signals a fatal ACPI error. Users can
> >>> still disable this behavior by using the acpi.poweroff_on_fatal
> >>> kernel option to work around firmware bugs.
> >> Any updates on this?
> > I was about to apply it, but then I thought that I was not sure about
> > the Kconfig option.
> >
> >   I don't see much value in it TBH.  If you agree, I'll just apply the
> > patch without that part.
> >
> > Thanks!
>
> You can drop the Kconfig option if you want.

OK, applied as 7.1 material.

Please double check
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/=
?h=3Dbleeding-edge&id=3D6f09a7009a1d7a132ddce3a8dd0c46aac66ad8e2
