Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84B83E3171
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942752; cv=none; b=ZOF6D9z1WqYKGM7d8ChQx14YrSh11pqihkibpVE2x94MS7TzelGcrXgaTep5jPUbaXrVM++dp4oTEzELpLsFCRD7+6wICa3x0+FI/xVs2JF+leV2ryvs0LFZUCWS8oc+NhbzfasyYQPRu8k8KequUBZfn82Sfz9PEHkni6LAxKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942752; c=relaxed/simple;
	bh=1qiYzC4e4C5Osb7cyOfG+hx3gfnhgiG4CgnJdnnYqWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mI8J3yvpIJdadQlB8NEARk/5YWSoKGu+b1KNw+Mg3B1tzV4BDmaKqEhRTnYjx3HHsSWIBOckxyhQy0W59OgG2nUOsR/EQGXOImWH1Sfgd1p+zrsOG1R3rQv5QFBu/bX/rAiaRQV5vDLAm4UEs92x9g/TTRQzZowcodCFrbbd80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Cb9Pt/2T; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cb9Pt/2T"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b979d16dd0cso126024666b.1
        for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 10:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773942746; x=1774547546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwNvoAxpSBA3F4YxfMu4dubOKf0cPSpjGd1s0V+Fdds=;
        b=Cb9Pt/2ThGCOHKWUUcjBwRe/ZBeJ/ai8kzL8fPRjdlVmxYqisPenbBe6HI6nmzSt9i
         Ds/lgf0YqDRdgiY6ud63gJgB3nYUe31dK1zMRsknxmmnz/uFfMoy2RChyEYTTl/J/JTJ
         z9cD2LUf2Q3wF7E1JyjVCRB6lI5hl556588iA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773942746; x=1774547546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IwNvoAxpSBA3F4YxfMu4dubOKf0cPSpjGd1s0V+Fdds=;
        b=DTEk5Lb++0aQAqYwQi4PELT7Hivc4j0H97Nm0rawqwdAHkhiSwZw9vQAkJeC31myBs
         2NBpY8LZP5t4fhiZYGkQ4mWWQyE84LcIyT6n7J7W5LdNNRct5HxDo/H5TLmGg7/z9AnU
         AQaeMIgyKBEpJVUZWWrxCTJ9xGcO6Mv7YIgieLCDpSDOhll0POfFT7oQh4P99sRPg/Yv
         ieS63HlNsJ1uCbOtXqc3tSDklKKW6TqeCYPeW7Qc1jSCIf5sdyiyjHo6i2MDkEcA0lpy
         HYYnFveo2ibD/SmGTHtYtf1btWn6bcAk40GFkNgqlvdq4eKlbB2SV31tidz60TePq2jg
         qLAg==
X-Forwarded-Encrypted: i=1; AJvYcCVEk0btaH+SD/UKGAeGjHSryRBY5/oMbuT7TY8VSdGFiPIwO7kMO1viXg7LZgzxaWrHEIK1nS+rkurl@vger.kernel.org
X-Gm-Message-State: AOJu0YwBIZknXjmGh6x+tTUHfl1MWsrmYPiXHTAOtJJVQ1VEqOuW5BiJ
	mKxhkp5Oegrs0NRYht4NGVXYQD0lNydqo8HWnftTuYiWJqPbcs1xH9tPNEd0JEKxKnpxqVUeMJt
	Nz9t+Dg==
X-Gm-Gg: ATEYQzwlZT6JmM/E+abAbbjSpl+DvdI86uX8z5KKFNv0NtgvRpgOm/Vt7TQP1bW2cX+
	k/psjMzzLWeM7aFphlDnWtY01iTA0zedxjXm/ybkC1beYRAF8JwW+v3zH2Qwcur1FvCW2DWbQoo
	FZK1hCEGzWA6tRQd0PZPDOFQB00VO75XowtizKod9wmmB2fR5OZmwJtYccKen63qpfH7U0OgC21
	gi7AJco0vVgxoG3SEgmm2q3IggjiJpSxVTnlCdsdu7yEsXZuCf1UpOD4toOf7k6HVo1KRkC266x
	wGpN5fB7Xl4QVVxQW2gig72r2/mzr6WdTTDMJEuoHiDMsSTjLSnrPRJa9uMXykCCGppginSA2Qn
	uhxuI98XqbOy9CpT55/AjNhOVs1MJ/Pq/dGcI67SPENN03Leuc4uxM2z1n2SaizckGSJd0FUpVn
	XyMthrP8avHkF/oNRijH/H+BJ0dcUSjaUAlPr+SCNF3OxeJO9BkmpcXKtxfEH46w==
X-Received: by 2002:a17:907:c281:b0:b97:bd6a:470e with SMTP id a640c23a62f3a-b982f0bbce0mr21747966b.10.1773942746133;
        Thu, 19 Mar 2026 10:52:26 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f16ddcadsm469567566b.47.2026.03.19.10.52.26
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 10:52:26 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b611274bso539500f8f.3
        for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 10:52:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQaF6IJQ5GJfH7VZElVladlKKDfCjH7dns5VcDxiFuMQ1E46WNsyTxu99TEQpoOfIM2M6ObvvEZcME@vger.kernel.org
X-Received: by 2002:a05:6000:18a6:b0:439:beee:43b5 with SMTP id
 ffacd0b85a97d-43b6423d90bmr470716f8f.3.1773942745211; Thu, 19 Mar 2026
 10:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317090112.v2.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <CACRMN=euZzwDpCQupzth-J1z9qWXPenmy_bu727+R-kt97zexw@mail.gmail.com>
In-Reply-To: <CACRMN=euZzwDpCQupzth-J1z9qWXPenmy_bu727+R-kt97zexw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 19 Mar 2026 10:52:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WEWMdh+SuSE-5P81g7NhV8KH_4u_FxcRdBFRTAaASqhQ@mail.gmail.com>
X-Gm-Features: AaiRm51jE-pJGKyYKekSNJEdkSVtbmzl88hjmcc-VHWIT0EUhGVU2WYljuGhtW4
Message-ID: <CAD=FV=WEWMdh+SuSE-5P81g7NhV8KH_4u_FxcRdBFRTAaASqhQ@mail.gmail.com>
Subject: Re: [PATCH v2] device property: Make modifications of fwnode "flags"
 thread safe
To: Saravana Kannan <saravanak@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrew Lunn <andrew@lunn.ch>, 
	Daniel Scally <djrscally@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 19, 2026 at 10:25=E2=80=AFAM Saravana Kannan <saravanak@kernel.=
org> wrote:
>
> On Tue, Mar 17, 2026 at 9:04=E2=80=AFAM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > In various places in the kernel, we modify the fwnode "flags" member
> > by doing either:
> >   fwnode->flags |=3D SOME_FLAG;
> >   fwnode->flags &=3D ~SOME_FLAG;
> >
> > This type of modification is not thread-safe. If two threads are both
> > mucking with the flags at the same time then one can clobber the
> > other.
> >
> > While flags are often modified while under the "fwnode_link_lock",
> > this is not universally true.
> >
> > Create some accessor functions for setting, clearing, and testing the
> > FWNODE flags and move all users to these accessor functions. New
> > accessor functions use set_bit() and clear_bit(), which are
> > thread-safe.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Mark Brown <broonie@kernel.org>
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > While this patch is not known for sure to fix any specific issues, it
> > seems possible that it could fix some rare problems. I'm currently
> > trying to track down a hard-to-reproduce heisenbug and one (currently
> > unproven) theory I had was that the fwnode flags could be getting
> > messed up like this. Even if turns out not to fix my heisenbug,
> > though, this seems like a worthwhile change to take.
>
> Reviewed-by: Saravana Kannan <saravanak@kernel.org>

Thanks for the review!


> Thanks Doug. Hope this isn't the cause of the hisenbug. If you report
> it here, I might be able to take a look at it too (no promises).

I don't _think_ it fixes my bug, but I'm still not 100% sure because
the bug can take a day or so to reproduce and it appears to only
reproduce on official kernels built by the builder. :( This makes it
hard to say anything for certain and also hard for me to inject extra
debug logic.

I did finally capture a ramdump of a device in the bad state and
managed to inspect the state of all the fwnode and fwnode_link
objects.

The problem (simplified) is that I have a pinctrl device:

  max77779_pinctrl {
    pin1: pin1 {
      ...;
    };
    pin2: pin2 {
      ...;
    };
  };

...and then a client of the pinctrl device:

  client1 {
    pinctrl-0 =3D <&pin1>;
    ...
  };

  client2 {
    pinctrl-0 =3D <&pin2>;
    ...
  };

At parse time, we get a link between the "client1" node and the "pin1"
node (and "client2" and "pin2").

In a normal boot (where the bug doesn't reproduce), when
max77779_pinctrl finishes probing, all of the links to its children
(which don't have a "dev" associated with them) get moved to point to
"max77779_pinctrl" (__fw_devlink_pickup_dangling_consumers).

When I detect the bug, the max77779_pinctrl device clearly has
finished probing, but the client devices still point to the child
nodes.

In the debugger, I can inspect things. I can see:
* The fwnodes for "pin1" and "pin2" clearly don't have a "dev" node.
They also don't have "FWNODE_FLAG_NOT_DEVICE" set.
* The fwnode for "max77779_pinctrl" clearly has a dev node (and a bus).
* The fwnodes for "pin1" and "pin2" show zero consumers.
* The fwnodes for "client1" and "client2" _do_ still show suppliers.
* When I look at the fwnode_link between the clients and the pins, the
"supplier" points to the node for the pin.
* When I look at the fwnode_link between the clients and the pins, the
"c_hook" is non-empty.
* When I look at the fwnode_link between the clients and the pins, the
"consumer" points to the node for the client.
* When I look at the fwnode_link between the clients and the pins, the
"s_hook" is an empty list (next =3D=3D prev).

It's a bit baffling because everything looks nice and consistent with
half the link being severed, which doesn't seem possible when looking
at the code. The code seems to always add to a consumer list and
supplier list at the same time and remove at the same time.

I've started to run out of ideas on how it could possibly get into
this state. If you have any, or want me to look at any other data
structures in the ramdump let me know.

-Doug
