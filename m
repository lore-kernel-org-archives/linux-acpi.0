Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA97232860F
	for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2026 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781248832; cv=pass; b=h8Nz3sTijO0DapSZiUPiZB79C/hNd2uYoym14BbsjlnXGtYukLhq4QMyOf3u1mpTyQhpQ+WsCBZZ+X7F+WvJ8A715gHCQujM20RLMxk/m7LItXAU9dsMPVJxD0B7GJBmJWJRZU+0MF0fLlqKn8dQrj6Cez+PTBfx+Fx/lMPNqxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781248832; c=relaxed/simple;
	bh=IkWHCCFQX7aMDTxBgQKIawFEFZfCBBbHv2LydgIraqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0V+z6E3I82AjbRZKjK9vpIju555hwybl1l0vbzgaP+Q1mDg5afjOget8ItGpKPvaiSM+CSKbnUHrdwT1d6Flc82nT3QgzZot7xT4oQZfxCeXQXDvS3XYdWsbSt8JOI2YSqTk6lz8vSVnQBJYpw+FqsMfK8CIoMgug9jNPSRHao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Oj4GuGzD; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oj4GuGzD"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7dc6fbf3e86so7901757b3.3
        for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2026 00:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781248830; cv=none;
        d=google.com; s=arc-20240605;
        b=d2YdX6EkLRMtmcqfJePX8rPEChr4cX5F1I4dBZ9ZLrj9UO6KZ8dHb1X9N0QsZddbVV
         sCbZdCBIrrJg8UrSy6xYL/xG90iW9G4WsQ80CcNni/1e6HaUaZq2FvA9ItIoOvwkJSRk
         OvnYxwRtRqHx4VDcI15/V/0fPjazHjO9rwo3wqaUAB4L4KyJlm70kxfeVKqrq0DerM8Q
         LTQZvuTXfIunUrgd4yWmuTyDJgs+wBbGDEvGVYDb8/ldXQgCeuOi2tXNuiPS9fu0tGPg
         /tUN1qcOdoKVq8+DOTIOi3g7nNo2tCz/Whjd/ey2jEAXF7BkQTydebPIH9sL3V+dY50c
         Y1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PEcj4bZjlu2HtgA6/DpQKuZoEr9jILxBgREI+9hl/bg=;
        fh=LunONxDYTuVal6SFdIA/l14A/4H0jU5IZ4en+M5+bFU=;
        b=NbJFydrmpWdEPT17RNnf/jK+C7nsnC5cCu3I/CGiTQ/B3l1yylbtqWu56eMRXMVjiF
         5v6BDXy4Ylp4MVBH7E9TgKvbtnLySguVp9UB44/vQ3U4VYhXu5YmyoWSZLAI/QTYeGZj
         bz0hHKTGxBTmBFL5w9PuIYsinWvsSmiUjGy6as1RPXa2EbH8tRUbYiqZZuRRWuGs5Zb2
         n55ce/SRvC0vyItkcNJzWGVTEmMHBLLL8Qcf8I+WUs9us8s5yduu78zRrtmJAbVQ0z44
         OGZcxhOpNw55kOAyYEPawinOM6hgJqLK0d5yI6WDoXmWFU5Nq0sbrq+GSQWW/Y/uk5M7
         /4UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781248830; x=1781853630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEcj4bZjlu2HtgA6/DpQKuZoEr9jILxBgREI+9hl/bg=;
        b=Oj4GuGzDu9GI26DqlprSNV/s5e3UxGAX3WAvF5EG3Eog+1hSTDfzsXpVg87iTTjNlf
         v8jWX1Dd+SPcZvi25Y2OkVchGb6xU6Sg8YfVmgsfJ99CLZH8s5qOmu3/P68rcrtYPtxS
         k85chdfol8gkgjb95XHASHkvZ+YTtvZKmW/tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781248830; x=1781853630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PEcj4bZjlu2HtgA6/DpQKuZoEr9jILxBgREI+9hl/bg=;
        b=Y9vX2OJV7il94svyNlWhssGPrOb93WEc7WCXdobAd4fmZtZPxjUW7F73ixE98dmr8o
         vFs5gt36hazHyIPMu0dX1UNwEEnuRFCNFhIibz4XunzEN23XBNE4b5xA3JeZiYnN1weD
         EEkfv/lXWBOJ8ZqqkrgiPIEM9bkzGOApn/YvR4aGi0LVq9PwkJuDVDUqZmGhDZv4S8Z1
         evU/XLdzoukNEoyjFUV5Y+9kCL1hNzgI4hs/elE3QEpYH70qGWTYozrqkYiPSF3/P6mv
         dikiyLOYRDnM92lf5stx+9wOkxab1WVTMqF/h7hJnqGCd+PFqKrXUkxwrRFsr30uGQR1
         hg0g==
X-Forwarded-Encrypted: i=1; AFNElJ+7KHIucd2NByZdX+zvx5ALEqvLoUIrqGd0Kt3M6H+AMCCSQqxYkTkTbkXDPQNBS8SONQRhkNNkq6Gr@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc68VS7wS95Ec+c8YB6UpcAQFPhXjJTgse1N8JmkpGZNxOc2MB
	rhARu8ds25tui27JF6DExr+VGfgipcoB4MVSMkRren0L+yVl/2QIA1lq8cyH1UwkUTDVsCSL/yS
	4yxbUXkUPuCV2Ec+r4e6MEfhkIfbvq+FrvmNE6DSt
X-Gm-Gg: Acq92OEO3o8jTB8WhlEQ7QoaKghFY7IoOxHxr7bejjy4jKwxwqZx+OlnGXfQAWi+B18
	yKJz3h10LMzaPrp7upYKS4AK5BY/EnNT44Wd1eNzll1LTlHXhnoyURLO0ilItlnrDEa0rfdqbHn
	T1TT5PMi70bdJNQFD8FSVEqL+dLJ6/KgrMrVe/rgxNqIjdvI3vN2uDgvqVB7f3STUimK8SFmlQR
	SqB/h6Z/wcr2OybgHTkpyFSpc4F4JKU9Feih/7pMaJmQJZZfjg0ytafEVKGjtWdv9TrAKD5K77a
	wNjxGYm7
X-Received: by 2002:a05:690c:c4ce:b0:7ef:81dc:c0e7 with SMTP id
 00721157ae682-7f7b6242881mr15277067b3.19.1781248829675; Fri, 12 Jun 2026
 00:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-3-wenst@chromium.org>
 <ailv8HpnrCH3Zb8C@ashevche-desk.local>
In-Reply-To: <ailv8HpnrCH3Zb8C@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 12 Jun 2026 16:20:18 +0900
X-Gm-Features: AVVi8Cfix6rlRxpmlL_G61si3smqjEz2qk3oIH1X9DTqc3HutmT3uL6lEMZg0_I
Message-ID: <CAGXv+5EHHWfiWgqPpf-RMKoSQLc2cd9OA4Z36SNoL5C53kVh2g@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] device property: Add fwnode_graph_get_next_port_endpoint()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:08=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jun 10, 2026 at 04:40:36PM +0800, Chen-Yu Tsai wrote:
> > Due to design constraints of the power sequencing API, the consumer
> > must first be sure that the other side is actually a provider, or it
> > will continually get -EPROBE_DEFER when requesting the power
> > sequencing descriptor.
> >
> > In the upcoming USB power sequencing integration, the USB hub driver
> > first needs to check whether a graph connection exists, and whether
> > the other side of the connection is a supported connector type. The
> > USB port is tied to a "port" firmware node, and this new helper will
> > be used to get the endpoint under the known "port" firmware node.
>
> ...
>
> > +/**
> > + * fwnode_graph_get_next_port_endpoint - Get next endpoint firmware no=
de in port
> > + * @port: Pointer to the target port firmware node
> > + * @prev: Previous endpoint node or %NULL to get the first
> > + *
> > + * The caller is responsible for calling fwnode_handle_put() on the re=
turned
> > + * fwnode pointer. Note that this function also puts a reference to @p=
rev
> > + * unconditionally.
> > + *
> > + * Return: an endpoint firmware node pointer or %NULL if no more endpo=
ints
> > + * are available.
>
> Yeah, you see, even here is inconsistency with previously added kernel-do=
c.
>
> > + */
> > +struct fwnode_handle *fwnode_graph_get_next_port_endpoint(const struct=
 fwnode_handle *port,
> > +                                                       struct fwnode_h=
andle *prev)
> > +{
> > +     struct fwnode_handle *ep;
>
> Unused?
>
> > +     while (1) {
>
> This is usually harder to read and follow. It's like "pay much attention =
on
> the code", but here no rocket science, no code to really pay attention to=
.
>
> > +             prev =3D fwnode_get_next_child_node(port, prev);
> > +             if (!prev)
> > +                     break;
> > +
> > +             if (WARN(!fwnode_name_eq(prev, "endpoint"),
> > +                      "non endpoint node is used (%pfw)", prev))
> > +                     continue;
> > +
> > +             break;
> > +     }
> > +
> > +     return prev;
> > +}
>
> So, this can be rewritten as
>
>         ep =3D prev;
>         do {
>                 ep =3D fwnode_get_next_child_node(port, ep);
>                 if (fwnode_name_eq(ep, "endpoint"))
>                         break;
>
>                 WARN_ON(ep, ...);
>         } while (ep);
>
>         return ep;
>
> But also big question why? to WARN*(). There is no use in the entire
> property.c.

Will drop. This function was lifted from drivers/of/property.c then
adapted to the fwnode APIs, so it still has the structure of its
origin. With the WARN() gone, rewriting it as do {} while() becomes:

do {
        prev =3D fwnode_get_next_child_node(port, prev);
        if (prev && fwnode_name_eq(prev, "endpoint"))
                break;
} while (prev);

return prev;


Thanks
ChenYu
