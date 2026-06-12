Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFFA396D36
	for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2026 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255536; cv=pass; b=GH/dgGFOX81Yzxj6uPnba7/ifE/unRn+m8JoL5B295ePfVbKNs5wqhWcLEfg9fDypq4KNmoNsW1chmn5X7k20yC5c027LUU7bWk3M6xrXOckQ6DbMdHx5w2iROvlQMkJh4e+I8K/6gyhgCUaQmsd1+E3Dx2XzZLIeEuJkEK6t7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255536; c=relaxed/simple;
	bh=V9+QmrpZdZ64QkPAYEa/J5l5l39WRUXFgGRxiy0LOV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvcADVLnsBjOfKwBoKgusBoT1MJkxNHlmHZ5S0natv/PgiGTXvq7xpm1vFCB1qrGx0wmiP4+I3dP6GALbSF+IIzn+1UlvKh2/x0IwfTc9+zAjuwLCWlnVV43Ee3EJW0JXp0DPM5DqiIr/YTW19s1qTiAJTMguOd11xtWJ9KFAVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VY6z8Y27; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VY6z8Y27"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7e8833c99fcso7755887b3.3
        for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2026 02:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781255532; cv=none;
        d=google.com; s=arc-20240605;
        b=XsmUb5dQDSCJSLGtJphewkx4ObsAGGqClMiE9TNJkopQOmGMdf0hVRmDi7cS9QXvWA
         5rLDcODr+wKcflFWXYplC0GcBbnZPZ6CYgeOeMVWgkp16dhkzU8ZWkb5yFimF2viCLjD
         YpmK3+nxxZ6meh+vwxTxg1lGlnCLVghgQxvt8LplABGe9DqtxczgiXrgqwETMgWEsRmf
         n/pwPARvUDB/0pGtxZPw/bhfqHGN4mehzLetW6f3lqsJrgiyK3VoeuFUHSCHehtYVPbh
         g1ih+xrZf/a8892ZnDUN5KKDeccwKn81Kds15aBWBjnNbc4udwKD1vQpW5wZUzK+A5Ai
         8f/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GT5k7NNhpJZZ3Z4dV7FccQcGuRptRglhhV64m8hW5dM=;
        fh=wiw7gNXvB/FKgJKFa85w61S8ABhwCM+OpE0I7mMeQsk=;
        b=ZMi3jrDFfG4wO0ewClQSxmJiTZ12B0A3irohNa/6PdFclGqpxYrX6P1CUjAe4qw3Dm
         /2+Zd0EpLUyxF1zsOU9UpRNAk+nbDIWEO7CcrW1c/96OpG8bBQsVF+ML72AjbrfOhHyW
         H1/yBdlC/T1rZlbpOeXN/W1ME0ziH5JqS15ffJuFtlKT7lvxhQSM8CoO2OD+Fmd45PyF
         StOHirnFKCqdq5byI1GhWeU1K/vDHasbGSNFksPd+MZ9PrV01GI8xWDIyjupKsFSTIXa
         KX7sA87jTme+xn8NpYCZeu3gRUYxwIFiatX6rIIYhu92A0gn//3aBsC2oeqeQ2mG9yMg
         pbMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781255532; x=1781860332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GT5k7NNhpJZZ3Z4dV7FccQcGuRptRglhhV64m8hW5dM=;
        b=VY6z8Y27Bq/k1VaXQDtfw4d6RhDkAb7ja36E1h1GoBPyxh8YLLuJ0VGxGCciWhduL3
         K6pOSFQWx1us+l10HBVmKuj+38x5U1b+jmRjcTWKFAb1lZmSa9x2dBwuyDpyBhsriic0
         0cEp83ACaRF9R3X5w43ashV/jsuNNogzc5ovw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781255532; x=1781860332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GT5k7NNhpJZZ3Z4dV7FccQcGuRptRglhhV64m8hW5dM=;
        b=dpsggRHl8/4rMoZ5vmt2AQNtE/ZCfvXQAQNt9dZfJdTodfQnqWklgdnCmErNOOFhCA
         3j10kDI/0hoo4KcQmMIkAM+uoDaCS9Bvkp1vd0ITCQY2PH9nYbL/jzksjHEPf8sKPaI9
         k+5epUFXPC6suzq0iQNPk6ymrGqwyrsd08plfv4Yvb97c9dsYB+HTQXhzOPjwGEZ4CzY
         wXFmWztD03vRXYI3Oe+9y0jqOxgvjSnF+NAH62MQ4u5UfKh9w05XlQ798qBcmY9Ik57c
         5KVhUiSFpwCuAz1gGhA6iPC+Rg3FeUei1AU1X7zWODHLRVNkVuiNIDksmRrkDhtUTZ2O
         tk/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8F1+qaMJg/9kDF1o20bC8do8ViLu/BFbYjrQ5xqqjbdHIS7xw3CDL3FwtyXTeU0/gs+7/H2+ByXwF0@vger.kernel.org
X-Gm-Message-State: AOJu0YzHuOZpnnVxW9hAmZr1YI0Ib90423Nzv1htCFT+w6SN/MK2io2Q
	MUzde3XjYx2Mvf96U8I6SF+Udf0WIH/lnVtzQS6a1xhtpPYGqA47mjxALwtu6kKKkTzoFPA4LNo
	u1Lq0r8aUgKTkA9TEs1kIAWzWh40jW39ErZPTUpHY
X-Gm-Gg: Acq92OHhsd9kpHR5DKRz6eMMCoz7S8d9AuZ4iEqrlJw7Wm2KVfWkb+mIbtihdKFd+7v
	7qu9CzsSuRz5EhhDk/xOnVq2AQKsiWFtZj8f4t0iIug5Z5rL95bDnM9MqujcPAzHsKf8PFmUsBi
	DzT0kWqVu8hbOrZbTafGfT/9g2QWb0w02PGxMo9Hrai8MCpUgCedxoFu1iXeJ2beVL5felU/O8k
	oWi4hvX/VEwb6QxGVNFzwK91FfNuhIdqkoscciY2vohpUt4vY5OThaj43+NLla/eif6e44BOo3l
	F4PCoFUy
X-Received: by 2002:a05:690c:f0a:b0:7ef:d039:a334 with SMTP id
 00721157ae682-7f7bcf0d73cmr16871217b3.22.1781255532401; Fri, 12 Jun 2026
 02:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-11-wenst@chromium.org>
 <ail1sAxgh5Xtkj2y@ashevche-desk.local>
In-Reply-To: <ail1sAxgh5Xtkj2y@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 12 Jun 2026 18:12:01 +0900
X-Gm-Features: AVVi8Cc47lUt9lrnuGQ2TayhjSsjO0Ufug4-8BS--usEeOHUYmKa3VTCiJvbq60
Message-ID: <CAGXv+5Fkp9R3i+WnCunbydJpn_rjxX5Cz9Cb=auS-cR1RE=R8g@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] power: sequencing: pcie-m2: support matching on
 remote "port" node
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

On Wed, Jun 10, 2026 at 11:33=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jun 10, 2026 at 04:40:44PM +0800, Chen-Yu Tsai wrote:
> > A USB hub can have multiple ports, and this driver needs to
> > differentiate which port is being matched to. The USB hub driver now
> > associates the "port" node with the usb_port device, so here we can
> > use the remote "port" node to check for a match. Then fall back to
> > the remote device node for the other connection types.
>
> ...
>
> > +             if (remote_port && remote_port =3D=3D dev_of_node(dev))
> > +                     return PWRSEQ_MATCH_OK;
> >               if (remote && (remote =3D=3D dev_of_node(dev)))
> >                       return PWRSEQ_MATCH_OK;
>
> We have device_match_of_node() IIRC the name of that API.

Ack. Will also replace the existing instance.
