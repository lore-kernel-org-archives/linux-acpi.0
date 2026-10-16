Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C258D48DB59
	for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2026 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175646; cv=pass; b=EWlr9EkKPH/M5cxpngbO9IHAJqb4d9CBwQrEMfmjic+HJDMSCmkq7RnvgnGphegrkc1RqXB+oeQA1N6Cxqi8T7GHIAfsABy6+t9H0cThnkp+2feq0PEahxMLOSc0jEjGLVdTQ154RJgilh5Ak+rSiochBbxp6TIPCUYFfyiVysY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175646; c=relaxed/simple;
	bh=4Mm9SIsdHVaKlbw1sl+yn6K7HWx4bhj0+WAsT/hKdqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4cryRaBEt3uVucoUyenhJQQQ9QGS4GaRZDlcySlLxykGkgqd+pHk2KPX4+QwX6yVO1bu9HmIOCkO04D97Vs6/hoa600/Ru3/ZFymv3mK4KyPZm2AIkohKOM6Btf4jODhQwAijvkC+sALXL4cSkDznd0MG9MyP/csGBjcrelcmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwYhfBSI; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwYhfBSI"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c34bff61551so31096766b.2
        for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2026 11:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792175643; cv=none;
        d=google.com; s=arc-20260327;
        b=PAQ0ubL1zuwit5Zqfry/4qMPjcuFanQxwMYcNs+1Z56ke4Z3Zx60p6p8jpIgl7GrbS
         gjJsBUAno8DyOpdr4KhVOQ0LeCuDVZxjxD8f/1z+ZKxoqHHrlHGoVpBhUqlASAjnkrth
         FOGt8JkBxEH+0YEmka9jG+pDVdXhEMK2R6v/YMJXZo6RntCIPWIOdM2CFxrmC2mpRN8u
         9hfL7cSgod+KyMPjqWZ3TjX/BqErwa8FWXIzVUtso4+NP64CL5jr7av4ItQHjq9dcLu7
         2DTVhF5Ub/UG7jPVLE4Bu/qP1L1/c57ze75o9R0/aDVB24Kir0roZdZA/IeI1ocDZscF
         D8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KiKuDaRVJ2Db05qPuytypvMvlXKTVmz5vDKzopfOVFQ=;
        fh=KoBdgBZT3rH3cUsm95GIeOMs+ZLD17UPhfbMVBUMCrA=;
        b=GdwMe32erPg6n4tef6x8IIkWS09GFJxfWcJpIbqxdBkTPgIZdtLsecjdIR+02Ml/xU
         shMFuJxB5N2dg5e1w65jZEYu3h30orgiBKYT+Wbn7WadJxUFOF9S1X8KwiIOYM1edjpk
         Hnnusu9mQCxE5FUmOP8ifpjJaTv1OlxoQhjeR4hIBBEH1blzgPI42DIDv+jPwYFdUpg8
         viZ7d0s6LlZrLGdrkx5tlMlZfHRt6WV5kuCHiWYsTZGZaNQ2TqWcICaCVInBXPA5lMSx
         3VKodHJnWlk399V2dIGkcy9F1VWYfd/cmaPCI4IWjxE/Y4pwL5QXzxYYf09ogdRgexWU
         3r0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792175643; x=1792780443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KiKuDaRVJ2Db05qPuytypvMvlXKTVmz5vDKzopfOVFQ=;
        b=iwYhfBSIiFd5q64rj8V/SgoRKN7PZM/Dlq2w4OSW5bgoWnK1ns83REcLthOX928zOD
         ZXmJren+RWlHxHCG5HdmYQ81TtOmc2EPnCdSMptGyK2K6OgP5yy6scNNpSenINbwUN6T
         NnsiH/2yJ4JwF4CIaFLzSy1ve4iWrUblYThjONrk3ylFSkm87HeL+y2SqPf3LSY6jpar
         vuuQ/GMner7bC5BE0Tz3xONun6BOugL5yIKCjwfRFTEhHKZomKNgfBDtqaU9ZNSyeFN1
         pc/BMvKxGxty/0vGWrMQ/3KTg05aNRe35IKDZqWNkf3TrVpycCd5c0qi1YPo9y3yK4tY
         OqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792175643; x=1792780443;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KiKuDaRVJ2Db05qPuytypvMvlXKTVmz5vDKzopfOVFQ=;
        b=ks8FgndB1y1KRK04oLPYyzMhpmc5YI88/0aLCWKG5GeeW9wvbYIbzzaVjq8vuGrGjk
         Mlmwah9xPjEdriI2zsig0zKLeeSZ2oYATfWYeccJRa6L1F9Lmso2idP8lGLuyQ5iMoQ8
         30avm2BXOdsNYqY/O/LVf1kyu2/EBqXbEO3bs97iYUmGLvkkntvn0e/SbLRwnFrsMK1X
         k309y/Mz4k00XnuhpHNvwRU1b7I/LbeTV6r8VG+930a3nxEztrQ+8ARe/oAlaICG0hzq
         2iyvBjsJxxTmuHUEoL0eiMhvASVmQWxAQM8UrS6guVmU71qMcMIlRs09XZjc43UaAdrV
         82tA==
X-Forwarded-Encrypted: i=1; AKwUvBwWNRkyo24YoPgcNLy0r2pHUkwfi8bwO3NRXipizU8oGuKs/NbRvruhYEekE2U8++jQvzbwT6XJo092@vger.kernel.org
X-Gm-Message-State: AFq9FYKO5Jp41FWmwBSiIea4IPMmozhENFoAOs82jTeRsp7DiIIF1YQh
	v2JIgcKPdZ5V3Vl1Vu0Nt0Dnr8lVBa9JET8SQ9ews68I+P0PwE8a0dTeV7Wp0K372vvRT4o2LRG
	9Lrz6AxTPS18+U0rZIt2Y1a2lWzSFFp8=
X-Gm-Gg: AYBFou0Z1bqjqBM9pwxOeA2P0WFXHqWs0uq9CyFQ7wZS740Y/34Xg+J4z/IU5p511CJ
	33BXZkJJUdaYWZ7VITmrpQJi/dJzworOMRf0+qpKrYF1kSvgNNgipSYNOjFIA/RtIOcp+OjxJ/X
	fN/81uGr9crqmYOXjSk1ZH1RuJyKNlxUyjueG4ED3x0A2s6mCZOY4nOxR3RuKQ9n1nqQsfKNHdw
	GJazd8tOXKS3wDe1ZvBlt00550R0JLriFt4dS5u5ZeVW7iSrXJdNPjTtifkbGsU3Zlj6618JaL4
	TkIBHduDvEdF4CDwCTmWt1rVi8BjYNEEOjnbStW0xdgn7N4kuX+4ECCLjm7I2/b6xSAlK9S79sA
	l+eaa/jeISg==
X-Received: by 2002:a17:907:7fa0:b0:c31:77f4:cc0f with SMTP id
 a640c23a62f3a-c41a04f10famr51890666b.49.1792175642740; Fri, 16 Oct 2026
 11:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAUQFRPW-rbcZV-=qV1NMjF_358sdJTiGvQuRxRqAsehY+J9Qg@mail.gmail.com>
 <atEaguJD7dh7xNs0@ashevche-desk.local> <atEb6FN6ZbKI9xgf@ashevche-desk.local>
 <51c151fd-31cb-4ebe-8f3b-eb7634e68c31@amd.com> <4ba482fe-8b34-48ad-9d13-99ab532cbd97@app.fastmail.com>
 <CAAUQFRPDq6zdyySWtGM8i_uq-iZJK1qpvCvxTrRweLmS2+-AMg@mail.gmail.com>
 <8a94b2bd-70ae-405e-ab01-2a0d37dcc551@amd.com> <CAAUQFRO49_T8iRdL3zYaj82Y_rgPTgM6VjScN3rqK89NmRzLqg@mail.gmail.com>
In-Reply-To: <CAAUQFRO49_T8iRdL3zYaj82Y_rgPTgM6VjScN3rqK89NmRzLqg@mail.gmail.com>
From: Nikodem Sanecki <nikodemsanecki@gmail.com>
Date: Fri, 16 Oct 2026 19:33:49 +0100
X-Gm-Features: AclHuK9uJQxO9EDngPsXVwzN-I8R9edDjBwQJUry5ZQcGDB-zwaFtaR91Za_MtE
Message-ID: <CAAUQFRPFkwMe4fx7xV1iDb2sAb-opYcVo=wLr-F5hwjEEU8ymw@mail.gmail.com>
Subject: Re: ThinkPad L13 Gen 2 AMD (21AB): Caps Lock LED broken by ACPI GPIO
 11 interrupt conflict
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Mika Westerberg <westeri@kernel.org>, linux-gpio@vger.kernel.org, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've tested your patch on my ThinkPad L13 Gen 2 AMD. The Caps Lock LED
works without the kernel parameter, including after cold boots and
suspend/resume. All other hardware I've tested works normally, with no
regressions observed.

Tested-by: Nikodem Sanecki nikodemsanecki@gmail.com

Thanks for the fix!

On Thu, Oct 15, 2026 at 10:05=E2=80=AFPM Nikodem Sanecki
<nikodemsanecki@gmail.com> wrote:
>
> Hi Mario,
>
> I've created the Bugzilla report and attached the diagnostic evidence:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D222137
>
> I'll test your patch on a separate kernel build without the GPIO11 boot p=
arameter and follow up with the results.
>
> Thanks,
> Nikodem
>
> On Thu, Oct 15, 2026 at 9:26=E2=80=AFPM Mario Limonciello <mario.limoncie=
llo@amd.com> wrote:
> >
> >
> >
> > On 10/15/26 15:13, Nikodem Sanecki wrote:
> > > Thank you for looking into this.
> > >
> > > I've checked Lenovo's website. My installed BIOS is R1QET54W (1.40),
> > > which matches the latest advertised version. The version history on
> > > their website appears inconsistent, though.
> > >
> >
> > OK thanks.
> >
> > > I also have the sanitised ACPI excerpts and diagnostic logs ready.
> > > Given that a patch has now been submitted, would a kernel Bugzilla
> > > report with these artifacts still be useful?
> >
> > Yes; we should still have the artifacts somewhere.  We can close the bu=
g
> > completed but add a Link: to the patch.
> > >
> > > Happy to help with any further testing.
> >
> > Can you please test the patch I CC'ed you on?
> >
> > https://lore.kernel.org/linux-gpio/20261015193924.4081906-1-mario.limon=
ciello@amd.com/
> >
> > >
> > > Thanks,
> > > Nikodem
> > >
> > > On Thu, Oct 15, 2026 at 8:25=E2=80=AFPM Mark Pearson <mpearson-lenovo=
@squebb.ca> wrote:
> > >>
> > >>
> > >> On Thu, Oct 15, 2026, at 2:48 PM, Mario Limonciello wrote:
> > >>> On 10/15/26 13:31, Andy Shevchenko wrote:
> > >>>> On Thu, Oct 15, 2026 at 09:25:10PM +0300, Andy Shevchenko wrote:
> > >>>>> +Cc: Dmitry (as it might be related to keyboard configuration), o=
thers for
> > >>>>> the previously reported same IRQ on the same GPIO controller but =
for some
> > >>>>> camera stuff.
> > >>>>>
> > >>>>> On Thu, Oct 15, 2026 at 03:13:02PM +0100, Nikodem Sanecki wrote:
> > >>>>>> Hello,
> > >>>>>>
> > >>>>>> I'm reporting a Caps Lock LED issue on my Lenovo ThinkPad L13 Ge=
n 2 AMD
> > >>>>>> running Arch Linux. I found a workaround that completely fixes i=
t, and I
> > >>>>>> hope the findings might help implement a permanent kernel fix.
> > >>>>>>
> > >>>>>> *A quick note:* This is my first time using Linux, and I'm a com=
plete
> > >>>>>> beginner when it comes to kernel development. I used ChatGPT (GP=
T-6) to
> > >>>>>> guide the troubleshooting process, analyse my laptop's ACPI firm=
ware, and
> > >>>>>> interpret the results. I personally ran the diagnostic commands =
and
> > >>>>>> verified the observed behaviour, but the technical explanation b=
elow is
> > >>>>>> AI-assisted. Please correct me if any of the analysis is inaccur=
ate.
> > >>>>>> Problem
> > >>>>>>
> > >>>>>> Under Linux, the physical Caps Lock indicator LED never illumina=
tes, even
> > >>>>>> though the Caps Lock key itself works normally.
> > >>>>>>
> > >>>>>> The LED works correctly under Windows and during certain stages =
of boot, so
> > >>>>>> the hardware itself is functional.
> > >>>>>>
> > >>>>>> After investigating, GPT-6 identified what appears to be a confl=
ict
> > >>>>>> involving GPIO 11 on the AMD AMDI0030 controller.
> > >>>>>>
> > >>>>>> Booting Arch Linux with this kernel parameter completely fixes t=
he problem:
> > >>>>>>
> > >>>>>> gpiolib_acpi.ignore_interrupt=3DAMDI0030:00@11
> > >>>>>>
> > >>>>>> The Caps Lock LED now works normally, and I haven't noticed any =
other
> > >>>>>> hardware issues.
> > >>>>>> System information
> > >>>>>>
> > >>>>>>      -
> > >>>>>>
> > >>>>>>      Device: Lenovo ThinkPad L13 Gen 2 AMD
> > >>>>>>      -
> > >>>>>>
> > >>>>>>      DMI product name: 21AB004LSP
> > >>>>>>      -
> > >>>>>>
> > >>>>>>      DMI product version/family: ThinkPad L13 Gen 2a
> > >>>>>>      -
> > >>>>>>
> > >>>>>>      DMI vendor: LENOVO
> > >>>>>>      -
> > >>>>>>
> > >>>>>>      DMI product SKU: LENOVO_MT_21AB_BU_Think_FM_ThinkPad L13 Ge=
n 2a
> > >>>>>>      -
> > >>>>>>
> > >>>>>>      Kernel: 7.2.9-arch1-1
> > >>>>>>      -
> > >>>>>>
> > >>>>>>      Distribution: Arch Linux
> > >>>>>>      -
> > >>>>>>
> > >>>>>>      BIOS: R1QET54W (1.40)
> > >>>>>>      -
> > >>>>>>
> > >>>>>>      BIOS date: 2026-04-14
> > >>>>>>      -
> > >>>>>>
> > >>>>>>      DSDT OEM ID: LENOVO
> > >>>>>>      -
> > >>>>>>
> > >>>>>>      DSDT OEM Table ID: TP-R1Q
> > >>>>>>
> > >>>>>> Diagnostic findings
> > >>>>>>
> > >>>>>> The following is GPT-6's analysis of the diagnostic output and d=
ecompiled
> > >>>>>> ACPI tables.
> > >>>>>>
> > >>>>>> *1. Linux sends the correct keyboard LED commands*
> > >>>>>>
> > >>>>>> Using bpftrace, we observed that atkbd_set_leds() consistently r=
eturned 0.
> > >>>>>>
> > >>>>>> Tracing ps2_command() for command 0x10ED produced:
> > >>>>>>
> > >>>>>> SETLEDS: value=3D4, caps=3D1
> > >>>>>> SETLEDS: value=3D0, caps=3D0
> > >>>>>> SETLEDS: value=3D4, caps=3D1
> > >>>>>> SETLEDS: value=3D0, caps=3D0
> > >>>>>>
> > >>>>>> The driver reports success and sends the expected Caps Lock stat=
es, but the
> > >>>>>> physical indicator stays off.
> > >>>>>>
> > >>>>>> *2. The embedded controller tracks Caps Lock correctly*
> > >>>>>>
> > >>>>>> The DSDT defines the CPLS field at EC offset 0x0F, bit 7.
> > >>>>>>
> > >>>>>> Reading that byte through the read-only ec_sys interface showed =
it changing
> > >>>>>> from 0x00 to 0x80 when Caps Lock was toggled.
> > >>>>>>
> > >>>>>> Enabling dynamic debugging in drivers/acpi/ec.c confirmed that e=
ach Caps
> > >>>>>> Lock press triggered EC query 0x78, which was scheduled, started=
 and
> > >>>>>> stopped successfully.
> > >>>>>>
> > >>>>>> *3. Lenovo's firmware controls GPIO 11*
> > >>>>>>
> > >>>>>> The DSDT contains:
> > >>>>>>
> > >>>>>> Method (_Q78, 0, NotSerialized)
> > >>>>>> {
> > >>>>>>       If (CPLS)
> > >>>>>>       {
> > >>>>>>           WFIO (0x0B, 0x00)
> > >>>>>>       }
> > >>>>>>       Else
> > >>>>>>       {
> > >>>>>>           WFIO (0x0B, 0x01)
> > >>>>>>       }
> > >>>>>> }
> > >>>>>>
> > >>>>>> The WFIO method writes bit 22 using WMEM(), targeting address 0x=
FED81500 +
> > >>>>>> (11 * 4) =3D 0xFED8152C.
> > >>>>>>
> > >>>>>> This appears to control the Caps Lock indicator using GPIO 11.
> > >>>>>>
> > >>>>>> *4. The same GPIO is declared as an ACPI interrupt*
> > >>>>>>
> > >>>>>> In SSDT12, _SB.GPIO._AEI declares GPIO 11 as an edge-triggered, =
active-low,
> > >>>>>> exclusive wake interrupt.
> > >>>>>>
> > >>>>>> Its _EVT handler includes:
> > >>>>>>
> > >>>>>> Case (0x0B)
> > >>>>>> {
> > >>>>>>       MSTP (0x3911)
> > >>>>>>       Notify (\_SB.PCI0.GPP1, 0x00) // Bus Check
> > >>>>
> > >>>> This looks like some GPIO related notification. I dunno what Windo=
ws driver does.
> > >>>> Mario?
> > >>>>
> > >>>
> > >>> Honestly - this sounds like a copy / paste BIOS bug that they copie=
d the
> > >>> SSDT from one system and didn't change it.
> > >>>
> > >>> I would think quirking it makes sense if the BIOS isn't going to be=
 fixed.
> > >>>
> > >>> Before we go much further can you check if this is the latest BIOS?
> > >>> Check Lenovo's website, in case it wasn't brought to LVFS.
> > >>>
> > >>> Also; Mark can you ask BIOS guys to look this over?
> > >>>
> > >>> It sure seems like GPIO 11 shouldn't be in _AEI.
> > >>>
> > >> Yep - created internal ticket LO-4711
> > >> Just a note though - the platform was not in the Linux program (and =
is rather old) - so my expectations of getting a fix is rather low I'm afra=
id
> > >>
> > >> I'd get the quirk ready, and if I don't get any feedback from the FW=
 team by next week go ahead with that.
> > >>
> > >> Mark
> >
