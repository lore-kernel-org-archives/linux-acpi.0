Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17A93C344F
	for <linux-acpi@vger.kernel.org>; Fri,  3 Apr 2026 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225484; cv=pass; b=pk91gfK+rIM7OMuzlgfXiMkjqGrgwwAuxkSVocPhT72Z6yVG1FdEFReYJ0aGFD+Ou5LychXVgnT5cUiezOfqshp/kqN/R7WxnvJcDX7eSd+WAC9G+mMidk2l+OvT8W/ErO3HkJ6Xs7PkisYhTqwXAT/Wq3UetpB/mg6rdbmgfE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225484; c=relaxed/simple;
	bh=IFY1epPJRbr7ePffEFt3cbANBhQ7V7M3EN+QpXKABqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TddpGOB+6oeGOZX38k4+DUdC9oVzbNl4QAR7rDm8Mn63Q95RDk3I6YY97uJahZ2C22kodcpkRolcbUDkiAR/bVy5sxaIzht1eLjeTDSLwdKmWBp/YandLySbkIw6A8NWRoC4MRvmS1k4InLLofJQI6pquGQEbtVC111H5z+VrK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joyfullee.me; spf=none smtp.mailfrom=joyfullee.me; dkim=pass (2048-bit key) header.d=joyfullee-me.20251104.gappssmtp.com header.i=@joyfullee-me.20251104.gappssmtp.com header.b=NK88hXH1; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joyfullee.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=joyfullee.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joyfullee-me.20251104.gappssmtp.com header.i=@joyfullee-me.20251104.gappssmtp.com header.b="NK88hXH1"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6618bc129acso2643693a12.2
        for <linux-acpi@vger.kernel.org>; Fri, 03 Apr 2026 07:11:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775225481; cv=none;
        d=google.com; s=arc-20240605;
        b=GDoafCNukDI5nJr2NYK7KPx1+zwuhnPXQuxpZdMwNXjlSYDqHfkhM/rgGo6cZi0l8x
         3bNPakRbE51UsFxQzM4sNyFw/nD7Wrh0Iw/U5WTF1a8U3hLZofOQuWsmsbBS1DfAI2Bf
         Sci2QvWKHS3Q1vRemDWIFUKxsJhNTepTEAbVz21qNWGntUatLgTFpXSBM30M3JYatXKq
         9L+aK67r3EUOq5OMaH07NeYXCG+yCigQDGl26dE3o+Cz/ocVi6BOJUw8yK5GE3sws6Dc
         n5lrSMwKpLtRX84HE9VvKF00biDsoinAWTPWHlNGeqsy2wSIziCIY4H/Osb0tuRFZIbc
         dq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9XosnJ0YUN8ejBUAFunXeZZtgn4wh2tVN1eGiMvblyA=;
        fh=d6CFLCvwer1sHYn0NZ7F9nUaJZWXMiWJi07tJxKluyY=;
        b=Yt0olKsH/+xlqLuvLR0aXicpBhYTEwW2tCsW8AE6/5XwSlmvjsXztnqTs+PZ+4/6tF
         46wKhbTs2fLOyTk/7qzNssvDeRY2OQg17ylf4Bp0oDbPAqIqDhVhdghENSl4PhpGIllu
         aRjZsnQeSDTjcmM9GkQrgi7rkV5ph+lrDPJuRkUF/lOt85F8Lqk8e7QZTSIWa3HPd9V8
         1KwO3TYqEv6XNfc8hUB5Wtm+DDomZrS7MVGPS5wzFAgg5oidPEAfokFZBvoXKc6Rff9s
         l7dGJINbOWoCYIhJP+QWtskw4R0y7C69BKNGEN3rPbfai8smfxf9bSTs46uggtezfUlO
         pfZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joyfullee-me.20251104.gappssmtp.com; s=20251104; t=1775225481; x=1775830281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XosnJ0YUN8ejBUAFunXeZZtgn4wh2tVN1eGiMvblyA=;
        b=NK88hXH1Ygrx1vKvCdh7xU2Y+1GEFrtXvXFBPSYk9UPFU3RK8GvaufNoSz2z0RMIsX
         KP6YNObykukQcjUPISvkYbUgWGa+LaVjZcdA+lK8G2HD4vpIGvfmItx4YzX7QcuY1Fxc
         ZAeZLoqzq3s6zZ7DNC7MHJanC5vj+hdV7RzBVVp4NG9LNlEEPTYoDjSjSNVnnwqjsqX7
         Y2tzj0Itr+IBVh5/DpoBXHbDBi+V+QKJvekTHjKjJELz2AvMntdVHoZRD2sdtZhHMvkf
         Pn27yqDVWnbUH8XVdxOmWV4Z+rFqqF3v/aB4XRSIUBNbbX6IrclBGb4iawMU8NxANhyS
         iSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775225481; x=1775830281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9XosnJ0YUN8ejBUAFunXeZZtgn4wh2tVN1eGiMvblyA=;
        b=cHCSw1rszu8DS8UfPiXEZhZ1KqeL/aL9HFJVdrZrc8qotFhhgGcqUFhJtgX/qoyUG2
         mbrmbwuQLinwUc1NQHAh98VsxNBMvSN/ZCo4DBCJupfcjCIjiOv4zkE6pz3ZO3wQaDiW
         eC6v0VNcksmxltMY3KWX4WYSlcC5vfLxJL7+FXdKAE5u9zW3qbYOk4B0AdheK42KHb5v
         of157zPooqAoG0fHeMb7zMX7PLa1aYKQGFon9oSAbiYjAk3bfpTucUf5Rv8ZT6CYkMII
         V4f8YiyGUcXgDgqzYqSYWTE+Np/FIcUxsLgrxPWgZccmxyA2Ex5+1c3wd9MAIu5mr9mD
         wPRg==
X-Forwarded-Encrypted: i=1; AJvYcCUGdOP8O2Eci356RVkD7G5fPSFWdd6EkZ320Vzsabvi+NR7qv38kewEygqXzzLsF6EGhUpOmY47K1u1@vger.kernel.org
X-Gm-Message-State: AOJu0YzLDWI69uq8hf9Dc4iO2fDsdQTo2pGuaKOsnXmS4H596rfFhWDZ
	fW+1zIdoA09MaMZq3pVqqtcF+YGlAbsH7zIrln7cxzMn6Nl79sthdxrWU2wDtjEIMfzONF99POf
	FcMkQN0Ud/4HGtkL48S9Btg040ScbJ0MnGgaZPo8+jA==
X-Gm-Gg: AeBDieumCtqDYqql4CPH08JS4lCzSfK33wsNrBCMPb4DmaIIFnog/2Pc0kAPjVcVIIA
	FHHZAc09bLxIRo2T2qUpvyWqkL0ygP+6u5xMAel/8v02pUnR/tyn4CjJX3A00Ei1yfGApsc00l3
	sCHxNQspCa6FkcsVOgAITBXyltnMX/fimAvW5zNRKbIFRMSerpw04/wF0vgAZfIxpRECntEoOP/
	G7l4++Ao8LJqL0ElVR8BM6/et1oOTCKXC99cgent2QD0zmiI6DMk2TKJdh3SyAjWOBSC83FchtY
	nIAlYg==
X-Received: by 2002:a17:907:6d05:b0:b98:8e42:95ee with SMTP id
 a640c23a62f3a-b9c67b9e36cmr144796466b.46.1775225480967; Fri, 03 Apr 2026
 07:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADj6jrgK+sRXoNaYH90Rdc8DYEFK2iSF4vkJC=KE4UaZ73y67A@mail.gmail.com>
 <a935b2e3-e11d-47ec-af47-7eb7e86a9dd0@amd.com> <CADj6jrgcuz=Bcp0q7BHVizVeF=C2r_8qXw7r0Mc5X9Vd8uWK-w@mail.gmail.com>
 <4192851c-20d1-4185-9f63-32c66ed2a664@amd.com> <CADj6jrgse2NksUgkHUzTm0332ba4qnV=0QOJAnupS=Lr=5hh4A@mail.gmail.com>
 <4978c9b7-00bf-4562-baae-098bd0d09ba4@amd.com>
In-Reply-To: <4978c9b7-00bf-4562-baae-098bd0d09ba4@amd.com>
From: Joyful Lee <joy@joyfullee.me>
Date: Fri, 3 Apr 2026 10:11:09 -0400
X-Gm-Features: AQROBzBZsF6vCnurIxo_LP4rU-VgtPOhiDWv3gF24onCXf_ue1uebeHL-8ILQ08
Message-ID: <CADj6jrh2AT6vvQqujB5UN5tfcQ-qdDKjV_7fK18zsqkHpFTMzw@mail.gmail.com>
Subject: Re: [BUG] ASUS ProArt PX13 HN7306WU: amd_pmc s2idle S0ix corrupts AMD
 1022:150b root port, NVIDIA dGPU returns header type 7f
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: platform-driver-x86@vger.kernel.org, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 9:23=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
> To your questions in the original post (again sorry for the original
> knee jerk reaction):

No worries. You are right to be skeptical.

> 1) Yes semantics of how AMD-PMC works are correct for this platform.
> There are lots of other Strix designs that do everything correctly.
> 2) Yes; there are FW dependencies that are design specific.
> 3) There are no quirks for working around this bug you've found right now=
.
>
> I believe this issue you're seeing is likely a platform firmware bug.
> Whether it's AGESA or it's ASUS firmware is unclear right now.
>
> I have not seen this specific symptom you mention on other systems
> (including AMD reference systems) so I am /leaning/ more on ASUS firmware=
.
>
> I notice that the BIOS you have from ASUS is quite old:
>
>  > bios_date| 03/18/2025
>
> Any chance there is a BIOS update available?
> Unfortunately ASUS doesn't always make flashing in Linux easy, but
> hopefully you can find a way to flash the update if one is available.

A firmware issue is what I was afraid of. That 2025 BIOS version 316 is
the latest release for this device. I'll reach out to ASUS to see if
they have an unreleased version they can send me, but I'm not
optimistic. I'm still in the return period so I'm feeling a sense of
urgency to either fix this or move on, but I'd rather try to get it
working because it's a nice little laptop aside from this issue.

Your first idea that the kernel could be racing the firmware prompted me
to try a few timing hacks--really just shots in the dark like inserting
a 2s delay immediately after resume prior to the kernel touching the
devices--but no luck. While I'm waiting for ASUS, I'm happy to try any
other ideas you got.
