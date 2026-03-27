Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FFD355F4C
	for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2026 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774610265; cv=none; b=OCFQx4x1hTgPXDkRfBT1x/b1Ck3vXwByGYCAQBd21KOl6hqHZn4+uUeW/FppmYzIXmSpCly+Dhol5WajGXZIrNh66DbGMxSmmR/bgE4S8SvGxYz752h6eAdNB/RN1OALg5UzHCQ1ZDLVqKB8UoZRpo2tX6GsI569xHM/Z2meQbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774610265; c=relaxed/simple;
	bh=5uR5C4kSTeoXCPZLUNxgRU/+LYofizIx/Fn/xYRnPHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3r7jzDU87HYOzjsGQC+8G/HqqhqW0ZHHHOJZm4GolZMofSGo01ky1ZWzlIKhrfElSC1cE8xYPDfhk79zidJGTQ1obUvm2t4eMMosI7l7Yh1YBvwqlIAHDsA6s/INzJsDmDHdvCDMHlu7TAJ/upWgMFDtLAy+xov7rrcY+74pxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tD+ncIo3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tD+ncIo3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68CBC19423
	for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2026 11:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774610264;
	bh=5uR5C4kSTeoXCPZLUNxgRU/+LYofizIx/Fn/xYRnPHg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tD+ncIo33k5E6WtS9z3II2KenbHuNoIsE7YvQ43O+mi5BZ4Dsc9Ssrmnr/cYsFS+5
	 CrUi52LvarLr7ZXeVL6T0vRhvV0p/emHH0gcfXDN0R71WXA4OPusrM7MkkReSwndHA
	 OshsfIuY1uxWfWZHoU6BLuJFwVbIvMV7627N5+YiJtTIrRIBQYHn+9HjMuLHmG2PC3
	 cpP1d8Jj8vnMuhKeL3mr50nt+mDKqGJY+/vZpJAvVMLCKb5N8fgMboRvWLi51BF9iC
	 WGLblfOUEvIThIj0k5+n/AJoY/67ApEqLHblkEsdZzemzpQi1RK33GUZvDTw7Ci80F
	 7yaIt1qWVBl+A==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-67bbea1e090so1200694eaf.3
        for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2026 04:17:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUM7/OVLOzZjtc9peK0JZtv5QR1ILyn2lZQyzDgj6bfpV0aHdLWS0uI9eIXrcFQqco4UHEBQXahNNdO@vger.kernel.org
X-Gm-Message-State: AOJu0YyRPWL1gKXZf5HO6miCVQEAMhr4O86xOW+AItVKEc27rLtUZ0Ec
	5lDyTiB8mGPs/A/EB7rcJ6RswCiKJS4YgszKkXcc5/SQriuj4jyEXJbHksERWIZOYwFPUymAI38
	JHWOCQUyk7+ZYBZ0WPFAhz9c0p5VigJ8=
X-Received: by 2002:a05:6820:8407:b0:67d:ebc4:1925 with SMTP id
 006d021491bc7-67e186ec870mr708977eaf.43.1774610263992; Fri, 27 Mar 2026
 04:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326201830.3938-1-david.laight.linux@gmail.com>
 <acZNuoRmQ5BrfPPd@ashevche-desk.local> <20260327094508.1801bdf3@pumpkin>
 <CAJZ5v0inLkQrjBdvgXe8XmE53gWSfDcFHZFM4iEj=a1Wmz6xwg@mail.gmail.com> <20260327105851.5e124db8@pumpkin>
In-Reply-To: <20260327105851.5e124db8@pumpkin>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Mar 2026 12:17:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gywDJaaATp8q9=zJAWEbZDp25U9SDRCzr9_pfXLFv=Jw@mail.gmail.com>
X-Gm-Features: AQROBzBq-QxOllv8ldhPMPaA3WeetHoMfq9Bn-hvPHItOgIZFm4LZxwH8QzCjKU
Message-ID: <CAJZ5v0gywDJaaATp8q9=zJAWEbZDp25U9SDRCzr9_pfXLFv=Jw@mail.gmail.com>
Subject: Re: [PATCH next] ACPICA: AML Parser: Remove spurious precision from
 format used to dump parse trees
To: David Laight <david.laight.linux@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 11:58=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 27 Mar 2026 10:58:14 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Fri, Mar 27, 2026 at 10:45=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Fri, 27 Mar 2026 11:28:26 +0200
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > > On Thu, Mar 26, 2026 at 08:18:30PM +0000, david.laight.linux@gmail.=
com wrote:
> > > >
> > > > > The debug code in acpi_ps_delete_parse_tree() uses ("%*.s", level=
 * 4, " ")
> > > > > to indent traces.
> > > > > POSIX requires the empty precision be treated as zero, but the ke=
rnel treats
> > > > > is as 'no precision specified'.
> > > > > Change to ("%*s", level * 4, "") since there is additional whites=
pace and no
> > > > > reason to indent by one space when level is zero.
> > > >
> > > > This is cross-platform code. Does the same applies to MS VC compile=
r, for
> > > > example?
> > > >
> > >
> > > Everything except the linux kernel will treat "%*.s" as "%*.0s".
> > >
> > > Regardless of anything else specifying a 'precision' when printing
> > > a constant string is entirely pointless - it limits the number of
> > > characters copied from the string.
> > >
> > > Basically "%*.s" is always a typo, either for "%.*s" or "%*s".
> >
> > So this change should be made in upstream ACPICA in the first place as
> > per Documentation/driver-api/acpi/linuxized-acpica.rst.
> >
> > Would you please send a PR to the upstream ACPICA project on GH?
>
> I'd have to go through a lot of hoops to do that.
> I've never used GH.

OK, we'll go for the second option then.

> > Alternatively, someone else may make that change upstream with a
> > Suggested-by tag pointing to you.
