Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A453A3E4C83
	for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2026 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774609139; cv=none; b=ZYNuogY/Uap0tPD+bTCnnVivTRjvddS52s3cADLS08H/kc7VxLcryLJOWYJSDpr4aepF0Yh7RoVQGFkdBLJgtmi74retl1j1vGjiN6g1LhklCQ5e/NQxj2vYA7icXlcfL0bcg8DVfiaLKP9kyAckQwzO/yZwqGfaxC4TC0mBOzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774609139; c=relaxed/simple;
	bh=9S4NhEG8RujM2YnZlDBff7wpoBOOAI4mTDhINuqmJcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RANShrNjCZzNkdMk2wa3sIfK3l7FoHxeJLna10i8Hw0L6EhIzKarzRJSbKEftzpzwiI1EuYCG4c9as6CslqQGZhqqG49aDOs6cFo+5TWSP0Lmohf07CyrooTwZ89Rk+TYnt+BGk9EPsLa+DjgbLOIllDFHZc2rTZfW37JmsQAKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0iMmb9T; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0iMmb9T"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b6d9c981so1259220f8f.1
        for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2026 03:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774609133; x=1775213933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vynPpevJ7/+7bmxgSv8Zl+8u89rQ+Nu0RRVPSUGsJ3g=;
        b=M0iMmb9TYI+5pQcM/VP94sJd16y3izgjeCMrcIMfikJCTmsDt4E1lBRzErBWMyMY1W
         4zh6FZgkV1ETiFhzV9rfaJMyFIWGEc188XWISmwCioCbK0zuH/UTpuKEx9optGwTEMHw
         UHhzGUc/PVPRYqUbTK4Iuqy+KAtEyamwp6Lmr05ZtXYBVv+UuOZ9/mEuHyIDp50U+L3z
         44o5tsQtXSawQZ/4AQrhcG/pML0FG57bdLNj+ysDXSlB2HeQ1+v+2l/xcgjys7xCmPMI
         1P3J6OagPmn5UlmovZsJGDa6YPo+1wVBRbOFN/kFwNA/n5aLakMAwePquA6c7zIUG9jz
         ZVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774609133; x=1775213933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vynPpevJ7/+7bmxgSv8Zl+8u89rQ+Nu0RRVPSUGsJ3g=;
        b=WSEkdh+PXH6yqa2GW8CQwkOL5M/qxWFj/aO1JZu2abYsiox0vZq6kKY/0VPpEnILnG
         Hr50fI2XHUKO8iuhgeqXIHSn9/rIjv9YFowG8mnzM1DS6T8z4zvy6DPst9ZwLK0XTJ/F
         1S5F1swwoLm34uh6ZVjsh80ZqqXMJGe1qL2HctqfUCDY/jDqjjng6RMQRuBDfZyhw9XD
         2lYBcRrGIzVZyjv+TH4m0HircyHZkLJVGAs3Bw+XE/xp4LWHLfaMQiWbpSzvo0QadRWZ
         XBT45MLSH4N9l9/2XmhR+qoKbua5aAi8wv6kOqeNp39eKBSmzO5PmF/qIxmy5LVPDGuK
         DrSg==
X-Forwarded-Encrypted: i=1; AJvYcCWtyI8B66GfnaDTHlLn3IE2LaeQItizjLcH+KnOVxrt7gmVeoX9QNC2j6t+3ZTUElPEaCQFoCApwITI@vger.kernel.org
X-Gm-Message-State: AOJu0YzOW98qhRhVeG4XjCBTYRX85d+YDbiz8qCff8qP3oEnDXK5rtqH
	dnHHQRjta9NkbjoLtLS0glB8c2SwXHwseo4313tQWbdIR8QeNXiEP1ZQ
X-Gm-Gg: ATEYQzxbvHlmmoQ6/h24MigsFTxoLQkUe80D2iYQQRhzTFy++/O7E5MsGgg2tatoQhS
	oBQ0mNFsvv69WsY/LCj/TLvksShLd2fxIN35p/mTxsYomydM7ev5pebYAV58/xwTSUKg1eR6TMb
	1J1rN4FtXOShWZQa7TYwn0edwXaRh1FwR/fdew0D/akUoeARkCDDdrOWhCGI0x1QOFSNOh8+7IR
	0DL1lZLGiQuU9mTnaaAvx/d9sK5an6sXihg0gV2HEqm/LggjTJiO82E71LP7l9HlM5x5fuacEb7
	uv10mNReCdrehCMzxIe9lW5Xko7Y/8+pzBCT+olacyJyp7hd36ozDfbPM5kXZ8v0fMQIjFMVyvi
	QIUodw8LmAcnrnRukw3dAwJqd1fZl2dOVKTuO1qIQYL+5zHUc+4ShhxjDHoJn1/hJCoSN20obtP
	5/OD8IfNQYX2OOhhVi/u7zIvMi6uKPictDDJECURLk2cn76d7R/tSQqU8BS8AHyjWi
X-Received: by 2002:a05:6000:653:b0:43b:a16b:ee69 with SMTP id ffacd0b85a97d-43ba16befacmr1536640f8f.24.1774609133106;
        Fri, 27 Mar 2026 03:58:53 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e3e8sm16605099f8f.5.2026.03.27.03.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 03:58:52 -0700 (PDT)
Date: Fri, 27 Mar 2026 10:58:51 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Robert Moore
 <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Petr
 Mladek <pmladek@suse.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next] ACPICA: AML Parser: Remove spurious precision from
 format used to dump parse trees
Message-ID: <20260327105851.5e124db8@pumpkin>
In-Reply-To: <CAJZ5v0inLkQrjBdvgXe8XmE53gWSfDcFHZFM4iEj=a1Wmz6xwg@mail.gmail.com>
References: <20260326201830.3938-1-david.laight.linux@gmail.com>
	<acZNuoRmQ5BrfPPd@ashevche-desk.local>
	<20260327094508.1801bdf3@pumpkin>
	<CAJZ5v0inLkQrjBdvgXe8XmE53gWSfDcFHZFM4iEj=a1Wmz6xwg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Mar 2026 10:58:14 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Fri, Mar 27, 2026 at 10:45=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Fri, 27 Mar 2026 11:28:26 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > =20
> > > On Thu, Mar 26, 2026 at 08:18:30PM +0000, david.laight.linux@gmail.co=
m wrote:
> > > =20
> > > > The debug code in acpi_ps_delete_parse_tree() uses ("%*.s", level *=
 4, " ")
> > > > to indent traces.
> > > > POSIX requires the empty precision be treated as zero, but the kern=
el treats
> > > > is as 'no precision specified'.
> > > > Change to ("%*s", level * 4, "") since there is additional whitespa=
ce and no
> > > > reason to indent by one space when level is zero. =20
> > >
> > > This is cross-platform code. Does the same applies to MS VC compiler,=
 for
> > > example?
> > > =20
> >
> > Everything except the linux kernel will treat "%*.s" as "%*.0s".
> >
> > Regardless of anything else specifying a 'precision' when printing
> > a constant string is entirely pointless - it limits the number of
> > characters copied from the string.
> >
> > Basically "%*.s" is always a typo, either for "%.*s" or "%*s". =20
>=20
> So this change should be made in upstream ACPICA in the first place as
> per Documentation/driver-api/acpi/linuxized-acpica.rst.
>=20
> Would you please send a PR to the upstream ACPICA project on GH?

I'd have to go through a lot of hoops to do that.
I've never used GH.

	David

> Alternatively, someone else may make that change upstream with a
> Suggested-by tag pointing to you.

