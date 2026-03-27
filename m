Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36E93CF697
	for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2026 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605508; cv=none; b=V90suPvnCO9a2ekDIeOPs+Lv/hd0qs/pn3JJXqX2AVnRakO8OwaHw3o2BKU7LM4WgtOkcUinFUSMofmcs/PaBkVjOWPCOolCkD43R3+Bd7J8AvIYUTPkRzJAeRILcZKYEmmHDBGHRahPcqPgagFv1fj4oVCnSaR+aA4n83bEwKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605508; c=relaxed/simple;
	bh=3z8c4896YABlTwFsOrS0Dro7L6k9K94YvwgodP1D+wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLniqRUamYE76OxvyjljMSzprdKGtjSERV8uEdktHODbWku6EfBXojDE+7C7s4M1ptOaQRu6MJGk8KfQpcgHTKBUNZzq/xvrc1go/MHF8/XzCJw9TEzx3fW1pNB63z1CFq8oIsQ0qWwACNzXcZ6Ku15t9auQZkh5cjbtCVCWgaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBrkHZbO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBrkHZbO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B773BC2BCB9
	for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2026 09:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774605507;
	bh=3z8c4896YABlTwFsOrS0Dro7L6k9K94YvwgodP1D+wc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YBrkHZbOfAgL8cQeVpo05dN0E3c0tZQAN46O2/rHDteN3KjMymxoxwxuo4UVqwtBx
	 KpYTxiXnFN4XcJZZwvPVhAm99WsvGL3ciFIMzgYtrV0WUDv21UPZ9CVXVh/DUl/oaR
	 OyTECZkECeL1QeTqxd+Srl13qmNTgKeDKl36GPV4f4IMGBUOYHvGRaVOD5BD450Vje
	 F1UdmhezVxkIEUBjaBhKhy240stzAWATYXzoPjXJcYOge1/RqZTWPX7zzFZNWgSM4u
	 FJUjH8T1bax8g321HW1f3X+NhVTKyBUCcLDAv1rT7JLC+THx6GnWTUXk4h1nd+E8To
	 FVdrFSvyGvkXg==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-464bc03efd8so1055896b6e.2
        for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2026 02:58:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVn74eIp+XnvvJrlg2GMd7V1VjYAlq6IMP65gxRf9wOj3UrHHL7P9OAzxzD0Z4pRp/7fUE32mvHTrKs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3CoM40rPFgVatDw/oE7o0njsZxgOrRyp39jgOJniqpbUAQ00N
	dCw3vshvYvTVozfFLdhTJK5PkoXwzib3ic/bb0fcsXgmYUNFoPdMo8td7v0ncmpTzkau34cUDN3
	jwcofxkOWpZBtv791BOm531uCGRWAkKg=
X-Received: by 2002:a05:6808:c2c2:b0:467:19:d010 with SMTP id
 5614622812f47-46a8a42bbb8mr790267b6e.14.1774605506709; Fri, 27 Mar 2026
 02:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326201830.3938-1-david.laight.linux@gmail.com>
 <acZNuoRmQ5BrfPPd@ashevche-desk.local> <20260327094508.1801bdf3@pumpkin>
In-Reply-To: <20260327094508.1801bdf3@pumpkin>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Mar 2026 10:58:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0inLkQrjBdvgXe8XmE53gWSfDcFHZFM4iEj=a1Wmz6xwg@mail.gmail.com>
X-Gm-Features: AQROBzD2Av-q9akhVVcNmFh4Ccl_DA63nfjTQZntTomxVJiv_VZzPrlKB7HUw7s
Message-ID: <CAJZ5v0inLkQrjBdvgXe8XmE53gWSfDcFHZFM4iEj=a1Wmz6xwg@mail.gmail.com>
Subject: Re: [PATCH next] ACPICA: AML Parser: Remove spurious precision from
 format used to dump parse trees
To: David Laight <david.laight.linux@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 10:45=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 27 Mar 2026 11:28:26 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > On Thu, Mar 26, 2026 at 08:18:30PM +0000, david.laight.linux@gmail.com =
wrote:
> >
> > > The debug code in acpi_ps_delete_parse_tree() uses ("%*.s", level * 4=
, " ")
> > > to indent traces.
> > > POSIX requires the empty precision be treated as zero, but the kernel=
 treats
> > > is as 'no precision specified'.
> > > Change to ("%*s", level * 4, "") since there is additional whitespace=
 and no
> > > reason to indent by one space when level is zero.
> >
> > This is cross-platform code. Does the same applies to MS VC compiler, f=
or
> > example?
> >
>
> Everything except the linux kernel will treat "%*.s" as "%*.0s".
>
> Regardless of anything else specifying a 'precision' when printing
> a constant string is entirely pointless - it limits the number of
> characters copied from the string.
>
> Basically "%*.s" is always a typo, either for "%.*s" or "%*s".

So this change should be made in upstream ACPICA in the first place as
per Documentation/driver-api/acpi/linuxized-acpica.rst.

Would you please send a PR to the upstream ACPICA project on GH?
Alternatively, someone else may make that change upstream with a
Suggested-by tag pointing to you.
