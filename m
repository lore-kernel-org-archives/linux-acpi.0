Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997480;
	b=ODpHHjtNVM6hA+OlsLnVhY5QVPQNGMWHfyGpkZfALfMXCTpCz+/ACTUfaqM1cCsQ7CqP
	 j/3YP+vr+Y71anzuGfhVoYVMcORlWxA4XAu9+ygcFBbTCwdUxfl5LyN8mHLoC7Smm95io
	 qZ4fK9+a8aESa1tgSAoKELRBHubY7Ly9HxRk8tOpshjyuMKfnm+oxUtwn0D9xvIP7QYTj
	 u6tLErnaMXvDJ9y/QJiL4yy4twdIvGja0apcfkw2yu4yzQs7VOBxO2epPXeBP571FI+oy
	 Bsk21BFNK2tX0qii6nqfCdBE1++uDYRdU/fCj/8kbWS5gqnSSdfE7Naym4CiJ5bfePQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997480;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CWFtzEGOjYXWWrRXdjVOFSZ25rh8/v8jlZjeE8XoHSI=;
	b=a1bYf6sp/b08mGNlddJoHf61NxZGM8LsiI4OvcfkwGMRjkPaz9EcKqHIW658q0eGJMAD
	 74SWo1npt1vX+u7Qee/liTmPe1FEpoDjI9DwGnzp4JSV8WqEq/VRXPHqsvH3PRk0Wk2jR
	 1ifXHiyO0+53mN/Awor1E9wDwwlu60p0tvqdGLJbHlBK24raMwKzPLghApagxxnmApB6q
	 L00HUZyxYrvoxsd/hW34fr2n+B4HC06AFE3OyDngPOdP1yFceh4N8zPnflUfjnk6uKtkQ
	 v0TqIMLmdaxZa/yI/Vk1WgITSCknlbcKUmFAB0BJcAwI/M1MLOpl/ON2wPlp9V5yi2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWIvhJ2H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA75606A32C
	for <linux-acpi@vger.kernel.org>; Fri,  6 Nov 2026 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWIvhJ2H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B4C1F008A5
	for <linux-acpi@vger.kernel.org>; Fri,  6 Nov 2026 20:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997480;
	bh=CWFtzEGOjYXWWrRXdjVOFSZ25rh8/v8jlZjeE8XoHSI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CWIvhJ2HHH8jG9uSfhCSDdMluji48syxsypheLFVGyyvHBde2UEqpQ7PBfhRVkViR
	 tMaGtPq4x8VjhvDEoAKJvxMAQBD7Bb9wj3Y1CiUgtZPWixG5xbxne+eYvyMrafEso2
	 g1oZkPfPhld8HDgxl9vybcKhTDGBcegQH6sj4brzD+XyVS6gy5PEj4TD5EPTzqBXGv
	 62DS2k9UdIpdnGjfiQcc4DrXZ7OA36W8GXQvk0GrM8RjRA+GLXdAKMZS+MrWIMAfjw
	 cpAyf88PllwA/p4krB+dhgBx+zfll9+QK80qTYpysVv4RTEp7gP8XiG6CoZBOOdSzU
	 8Ceq3dJukGw7Q==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so1304970e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 06 Nov 2026 12:38:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHagTv6qpg0an/Sca0XRYLa4Bif91ZKOyqTvVZQv713VbaAXJr1Q1wRx2UQatyr6h+Fdk3FKpP5dE5h@vger.kernel.org
X-Gm-Message-State: APuU4Z+yz7SFBTu0mqTBaZ3pD24YCK/cuXjGAEMUCqE00M1KRk1obmXp
	ZKM/PzJUBOVjqlraTJKEEFivfQqThg7IKpi9ktxNGc7/Eoc8ZtGOPEAufGnjWC5jE/Udd3T0oy0
	UrFV4ktGCH7YS0NQv2u6ca2qoqrW5Eq4=
X-Received: by 2002:ac2:5692:0:b0:5b6:1a7c:27 with SMTP id 2adb3069b0e04-5c003c0903dmr1289753e87.42.1793997478844;
 Fri, 06 Nov 2026 12:37:58 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261005153723.2644331-1-fuad.tabba@linux.dev>
In-Reply-To: <20261005153723.2644331-1-fuad.tabba@linux.dev>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 6 Nov 2026 21:37:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i4wc1oeRZ+eswsLErgchfQa0Mmi8K7nBM7Mb9T7NToHQ@mail.gmail.com>
X-Gm-Features: AclHuK89uJyG-LZ30b3MHdFmqSZ2vlWQfjg36o0s-bFfSBL5BozxQuU83pcSs24
Message-ID: <CAJZ5v0i4wc1oeRZ+eswsLErgchfQa0Mmi8K7nBM7Mb9T7NToHQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI: tools: Fix stale headers in incremental builds
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 5:37=E2=80=AFPM Fuad Tabba <fuad.tabba@linux.dev> wr=
ote:
>
> Hi folks,
>
> Two fixes for incremental builds of the ACPI tools, which compile
> against old headers after a header changes. The first replaces the
> copy of include/acpi with a link, so the tools see the current headers.
> The second adds dependency files, so objects that include a changed
> header are rebuilt.
>
> I found these while fixing the same kind of bug in the KVM selftests'
> sysreg header [1].
>
> Based on Linux 7.3-rc5 (72d3fcf802c45).
>
> Cheers,
> /fuad
>
> [1] https://lore.kernel.org/all/20260922071945.693714-1-fuad.tabba@linux.=
dev/
>
> Fuad Tabba (2):
>   ACPI: tools: Link include/acpi instead of copying it
>   ACPI: tools: Rebuild objects when a header they include changes
>
>  tools/power/acpi/Makefile.rules | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> --

Both patches applied as 7.5 material, thanks!
