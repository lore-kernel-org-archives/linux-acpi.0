Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C00551982
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996274; cv=pass; b=AXk9iz/wzuMe0UMmlVKnBm7HTu7hOA6tQE1SiarkyZFr4pw6X96jsBZJae+IDbF837WsNt+ET5xK+eHjRQRg2akGVyY81mXCT1vKMFxrbePXD2UInX6lY6fAfkwcAO/epCGDGoenBph9pDRDJCuWpyk74JB5dNe8Q3CuhI/UAUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996274; c=relaxed/simple;
	bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBDomy56JEj/XYTvkoab6gapc5MTyaHl2+H8UD3EJi86JVzxmOxNMAUYGAqrBlhaj30CNaDYcwv2RTJXSJE0j/11xITf9XmsZsVBOMZF1hmkMXXe2gK+rBg7mZFjGrFZ5uOnb0ZICl+iJIdITfWrG8xtxYaLB3vwPEmisJSk0LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG5LMeCX; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG5LMeCX"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3513f217933so38843eec.2
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 09:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996272; cv=none;
        d=google.com; s=arc-20260327;
        b=VYlIOKWVnQIBPfSlvhgEc89BP/Y0TZIqwUzz+ogQ3aiNB8zh6FKOc1z4i9rX9E8wKp
         UXE07MtxpwLuJX3th/2Om/VwVCi1JLI63vVP+tKzHtBAoOMIwhCaX83jFeC+mzHR/kgf
         nDKQM3fgUq2EC8It4IzKXWyWiMImEudDV8Ear626PDXQthSTpmDNwdmDHI6WaKEBtAYG
         Y+K22+LvmD60soT2SMBU5OfO6/WaaBeWihxTqNYVj5TSnWaduPiyHBYUoybEWAwMAEOr
         YCvr8PLypMmxp0V+Da2zF82/2hFL94Z5ApDim6NyPNQePpaobnI7/NtXGeG96K1cYyty
         Wftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        fh=RiEibKH0r6Z8DRLeFLZo+oKuikRACc6DZ78sxunThbE=;
        b=I4Qax/pZiH8hfa377EuhkKCKD0zXPgEmWNrr0lg4eFP7g1Wvqqtis/IoIQat4Yvakj
         8bBAzzL4sH365MgON/fWdIdjy/wjBqA9Az9Wc8qsj21iY1mK1zXqQJyNFgXTmXvbRrPn
         kBgHF8D+olEuNyWwAa8MPeOK1RIsGbP2gJ/3q6JdSJMf2MlzXI325dbA3Re0XD8q/9Fr
         OBBZmKdUkiQLCqdMlEzUvmX9cKDm21BXUuKQgz3fHE1uGocSO81Fw8Ud4H+uCSrHjrfS
         5FOC7fVgqW9rvYGQ6IfWVj7lQUbIyXJFouMMlt+Xf0aqxiucfSOri/WkbXGy+rJNmTWY
         e3tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791996272; x=1792601072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        b=dG5LMeCXSiSbpubk/BTMkvWJ2dvIK7jFfkGhSVKuiPvEccVQI9eRP/pY4aiG8kSDk8
         sybScDEKYa9pUjoob3fVfnbNdFtdkBXsSjpfjP+bPyBK5Chd00x6HJJ7X+HteLAY7JfU
         o4429zXiiE7e1UOccLBxgzcZh+G/nI2B8bjb9YKWi7iAEGL16Iblz9B6MpdkbUl3G+Fk
         3lPFokI++jDRZ0Cwvj1/64bOOygK5BR8VGYFxRHD7siF53FrkARVocKqUOcShcj0hkn2
         gYiKlI7ykCQvFk94TVoBL/XLbOsKN6gefpMbeBOS/eufSnZP21bV5ckiClL1WUdGnm6v
         +u4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996272; x=1792601072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        b=b9BrqwsTcD8d0Vpi+3+lc3V0eHRfcV2y0vshRnMi/S8mFHDwull4Kv6sp6xynZTmJO
         +QeHT6jtJ7OdR0YKTtxOni0OQC3/Rht/bvlfNn5Tkkobfhe0WqRoJ45JDg4+12tzYkzt
         7qH2vsNiCWL6jiXlGrbbSrik/sEopeiO2xd2QI+2zW2rPCokoiM00ekIEb5qI5IRCnJl
         GJOFBuHX5UtcBpPNoaIABdXBx/WTsM14kthUQy/J1JRsSS/8E5rs+ZRhtutujNvMB1jW
         MxrOZtEkOEnltEOljzD92KDINOw8sUGXaenZqzfDDsf7Q9ExLLEHMdkbiZKLg8Er3Hb2
         AUMw==
X-Forwarded-Encrypted: i=1; AKwUvBzq7oUyugsoIfWXvo5bt+XyeEDc8KeLyozDpcBd+SZxBmnHLGwV33VRzVd5fC/L4UREXpMzbjQ6/4JT@vger.kernel.org
X-Gm-Message-State: AFq9FYI6gbqe3TfRMcneNgeYbUukXF4fvFJxx3ycALPDU2QCZH/eNaKp
	3uurH9tzVbMv6tV6ascenC6lySF23j3alLA1Gje1cReelALLJDRMKga/jwG1qW0XsVOpdUWjb6f
	a25jIJgkwob2rC/tLEznneRa3lRpP/9g=
X-Gm-Gg: AYBFou3v1kWpeugiTYUovAGwMbeyqIyTlRgsTKeEQyPuMrkVgF8Ez4ncyYw1B84i+R3
	EBqTqYVPdwPR3gzh4IEp76H4VijbwpoG2LEifXRaX5gV4D1M9uWcEfXEo+nAuOxabJt7ntzr02C
	P5Gb73oq/FZR7vSo1h01i4rZ37RKM0i+3bSVqPSemgj2G1/7jZXm/fgAJj5lk91sxqJGyfU/ynK
	7VGgG+gEhxDKAWYsq9/kXxEFYO9ICj1fxgi3XsD7Je01w22wsff7aluLe9RJagtvYtmu+haidxV
	QUYbhxZjf0CSFHibVrh08wWtmsqqUC9Q45VlShH3+TiGM6QWA4HId8f2sTwAhEodM3A/+irVQbx
	hgy+d/mnBwpYSciUeR2sECc08pqrbGkbzGtcJOIynWat5iab8xrzsZ1JFKkkWH5IU4cICZGiN3H
	uUnVu3I5ZO8whiRysHs9mJeao4hLxLRmE5jKTn3dA5GU9ApdLcpCQ=
X-Received: by 2002:a05:7301:5413:b0:358:c9f3:b055 with SMTP id
 5a478bee46e88-358c9f3b260mr28158500eec.1.1791996271702; Wed, 14 Oct 2026
 09:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <2026101425-why-boring-4f2d@gregkh>
 <202610140932.5F9CFCE5@keescook>
In-Reply-To: <202610140932.5F9CFCE5@keescook>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Oct 2026 18:44:18 +0200
X-Gm-Features: AclHuK_d31yoge0njHjovdIQh7JfJY6W-PLjzMLBq14NjY-schAqigzEJUAQwG8
Message-ID: <CANiq72=4WQ1B1oCSW=69u_Z=FFLE56hYCqDwWr+poQdzSTS31A@mail.gmail.com>
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct kobj_type::release
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ian Rogers <irogers@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 6:37=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> I'd really like to have the attribute available, and I've got at least
> one user I can apply today that don't require fix-ups (seq_file), so
> if Miguel is okay with it, I'd like to snag patch 1 and send it with
> my seq_file "first user" for this coming merge window so it's available
> starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
> other subsystems to be able to use it. And the kobj fixups can continue
> in parallel. Does that sounds okay?

Of course, please feel free to pick it up (with the small tweak I
requested) if you have a user.

And if you don't pick the user, I could still pick the first patch up
through the compiler attributes tree if you and other folks want to
use it after -rc1.

Greg: adding the attribute itself should be safe and would unblock
others that may want to "protect" themselves, without having to wait
for every potential user to get fixed (but of course I agree they
should get fixed -- we should not forget about them, if that is your
concern).

Cheers,
Miguel
