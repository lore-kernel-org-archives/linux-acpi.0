Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF0F394797
	for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773405098; cv=none; b=ZE76jlvG/FqA1cotB79Uqh5+PZDhjmAHgy8kmDGy9mOwbNowaCx4IK/X6IrHHnqKA/pNazK42+wkktw+TAVbvIHoWDz8XT/UwwekBgkovzPEnuGm48Bpe9XoJ7fKNoHcJBXkOr0RKQO+1B6fSX5XbEcCWZ0McTENwivuNrolSo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773405098; c=relaxed/simple;
	bh=psnkMBQgvZHqWgbcP86HlnNA4fjdC9QrAhMtXjey0jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENwUg4dwfNyEBC2nIO+ajZoSTo79w/vE8rJd41glhP2haOYsD1uqe/t2htXyHNrISwc8f+GiA95ZGXe1qWHoaumV8omDuB69QTs6ww0xYx/IcQCVIWjvZQ0zwhpenfxtA+d62ytLY4DoOMefTuy8c0cLHFBmKpqQb3jPumVN0VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Grh0Bze+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Grh0Bze+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30EDC2BCB8
	for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 12:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773405097;
	bh=psnkMBQgvZHqWgbcP86HlnNA4fjdC9QrAhMtXjey0jk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Grh0Bze+h4xtvO8Bjdlnn1rOX0gEGigQS/CWsIx0Jkcq14fr2Gd7TJ/skXM+mnb+i
	 gBcymId2zPDi5m7l2wxws5ep9zwY/VeH8clVx6QTgSS/97rmc0kRUSHsSGZXgxgxzR
	 R83f/lCYh/iYcROi4S/pV+ms1jrxrbz320YsBXEPlsF2t1oMcnR7Iw2omNRKF1Z9Ae
	 ll2EiNohwZejkEGW7VY5ET3EBoJrR5wKO5Uhc0CRXqDPwi7N1A69ijG3Yk57OkEIo/
	 QHXGzmzjiiGuxOt3fDu94YdFh9tOQShJThF3DQWT3d4rPe52qJxGkVA2AcWxU26wy2
	 eSwi3k8cMPGyw==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-466ed3bc95eso773518b6e.2
        for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 05:31:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcjcvcOTs7WzsljiHmcLJWMyxsbaBFPXY5Ivc91woRBTpQ1mU4+S++p5RwDezcoacCvmwIwPLp1u5v@vger.kernel.org
X-Gm-Message-State: AOJu0YxY+xCktbmdMkmeGNViYtnuF8Tu3TgSsNCZTJ+kNzouMcKrnVlS
	2iDD/2RqfHN50v/0D4NSS+KIVbxNnmOOZ3suQrjE5e5HWcRGPowIAJohjpdmH9uma1L929vrEIh
	ZKVD5jDVo8k+Cij6wsIikg4B/RE+nkdI=
X-Received: by 2002:a05:6808:6717:b0:467:462b:ab0 with SMTP id
 5614622812f47-46757050cfbmr1430065b6e.2.1773405096637; Fri, 13 Mar 2026
 05:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <76675c4d49d3a8f72252076812ef8f22276230c2.1772282441.git.houwenlong.hwl@antgroup.com>
 <b5d7f0734005eb08f31e7b9b72e253efcd2614ab.1772282441.git.houwenlong.hwl@antgroup.com>
 <CAJZ5v0ibAwNi95giT5tF-7UvZ4SijneHkOtOB1d83SbjYLv4MA@mail.gmail.com> <20260313122844.GBabQC_L7iROuslPNd@fat_crate.local>
In-Reply-To: <20260313122844.GBabQC_L7iROuslPNd@fat_crate.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Mar 2026 13:31:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j_chGXMdyK8FGeK=PFs=R=cE5ukx-1u-5J4nEVrpesLQ@mail.gmail.com>
X-Gm-Features: AaiRm537ttHJhSLSoazUbRYArnwU8s430NGE5PpH--IPy5YfTUPvM2KB6_tmR0A
Message-ID: <CAJZ5v0j_chGXMdyK8FGeK=PFs=R=cE5ukx-1u-5J4nEVrpesLQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI, x86/boot: Remove {set|get}_root_pointer() ACPI callbacks
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nikolay Borisov <nik.borisov@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Sohil Mehta <sohil.mehta@intel.com>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 1:29=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Thu, Mar 05, 2026 at 01:20:53PM +0100, Rafael J. Wysocki wrote:
> > On Sun, Mar 1, 2026 at 6:05=E2=80=AFAM Hou Wenlong <houwenlong.hwl@antg=
roup.com> wrote:
> > >
> > > After removing pvh_get_root_pointer(), the only get_root_pointer() AC=
PI
> > > callback is x86_default_get_root_pointer(). Move the implementation
> > > directly into acpi_arch_get_root_pointer() and remove the
> > > get_root_pointer() ACPI callback. Since the set_root_pointer() ACPI
> > > callback is also only x86_default_set_root_pointer(), remove it as we=
ll.
> > >
> > > Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> >
> > Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
>
> I'm assuming this means I should take this set through tip ... eventually=
?

Yes, please (and you can append " # ACPI" to the tag).
