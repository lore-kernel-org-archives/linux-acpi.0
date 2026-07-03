Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817C3D7D8D
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085170; cv=pass; b=og0JSFkcjOi+NX5KxdogsMQVoOFPcjNsShPZqSc2FkgQkbRlRK75GkKmSAnOcLAjBIHv2ih/l7UpAI2fdPWc6snHlpSpFQch+qrmYLyIeU2OTZ+jedUi6Yz+YWjlLcoOLCR1vPmXjDu1cSBvOwx2B6cSgKKZw6xo3BmlM+GPg6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085170; c=relaxed/simple;
	bh=P4zhLhFMp7O4gmnRm5uDgMPugvo8rGAGH9W/oNg9Rsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q95s6ja7ZB8SGSx92IAmZQ8IxUr0zeVNHdIV+2huIhAVXRm8XmS2g2E8VPLHNHtbANJnQZXyHzm8JNaeu0Xwby6HpgdyGaXV0EwwFsMCQej15prXiGMziEN1/XUudZeOwJWF6C7p0gOaLwL/KgALhI3Ebe/yurFeYqsngxAsvNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KJrt8HfN; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KJrt8HfN"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66628618509so777624d50.2
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2026 06:26:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783085167; cv=none;
        d=google.com; s=arc-20260327;
        b=jGlhas5UZatDScqRd9kxRd3oCRzaatKAhrRpR/gHK5d0R0bfFB+rU4Xw/iEC/nKeLH
         Fl50vXHPW7KNalmOdMTtcuI3zc8eW8kiTD1bwU4uLTO+iLZP5ROUrbW+sWOZdwpTj2jy
         BbpTreBk/7oQaSYcbuck6C+cIUjOAppe2gKA4cVwKwyq+FaZbO09SJtxngcQPp2x1HBH
         igeUyB5z8YSAO/7OJ9vS89qZuMDZPCAoeB1axubICRhP+Hqis/NWs74mY5eSW2yZQlWC
         OEABw+NDBZeuZrUPyOmKd/Rtf8n71OI5XzGhrUzcWVKP/98tr8+cO7si+p4mFLh5kABo
         PEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P4zhLhFMp7O4gmnRm5uDgMPugvo8rGAGH9W/oNg9Rsc=;
        fh=CRHpO8pqaoexb2/kuLe0guZ0hzP39RzTzBmxvrS8jsM=;
        b=Vpr1SC84jWtXJU/K18eVLQW48/tLbRBof42/lJQbFIdSBSGZFPELv+Pyv+JmLsMR4h
         V5wpPzVOw8BT82lPG1vw7oeB5l8r2neAdXB7lKd1Zmqej/cs0n7gSZeBjJIE4XdnIcT+
         vofJHBWP38TvRV+Xt6c87UgANG/BwPqxDSVBCsi0hMTvvEey86X1BKA5QMP8KT8haPD3
         racFNji+lz0aDWWBEDct4MmCPgzqaC04yiSJtjZPJYSBmMpZddSqjbXdEIAXq4FHkBLS
         wXoGkXVV0g0yWqDHwHQUueuewIt53n+tPR/r4Zwb1Vhm6ouO3lD2HMUodQU4u0VNE+cU
         1v1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783085167; x=1783689967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4zhLhFMp7O4gmnRm5uDgMPugvo8rGAGH9W/oNg9Rsc=;
        b=KJrt8HfNHAIjRwl1rngsaRwQF/9FG/CBUQfLIs6l/S0TOIfaVompOtGsf8X3bPYz2D
         RpHkamXeIR2v+GJi9wvXvM4EG3fqa1ExPuTLfmCtACLkWQ1SQRgq8Jnf8+Y6no5X9ShD
         3ZnIRWkysCQxSmaWU1XoTY7M6QhPv0auFgUNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783085167; x=1783689967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P4zhLhFMp7O4gmnRm5uDgMPugvo8rGAGH9W/oNg9Rsc=;
        b=UNRLxXrwSSz8+cy0DE+Xf76qEnx1xF7x5J+D+kyiDGwZHVW/Qi2rrjocwFWxt/XxLB
         F76JFK03uDDhq1FdcSEEroV7YB+B3OC22GJM8YWGcCu8jAYuM6A56Pqy22JMGQNaRJoO
         +sudOX2cqKjb714zabMDNS3/q/MQSUOi9q1REZMrLEX2istGeZux05dk0qOyEj/X788R
         GTlDqgLVpVlzVX8ZAkXDkycoSSdd9UO4SaKZ/XviSVr/hx5ZcfbPG3+NSTHVZ+QYzLjK
         Kapnhikskp68csIj6rH1QfWllctT1AOUYP9UY5IgdDFKvfj/cSe2nxCx3SdnJkE29o35
         ne/g==
X-Forwarded-Encrypted: i=1; AHgh+Ro9LfOKb9FjwarRQHvttq84pDeH860eJ0WRYMrBbUnyle5MHc4WrSxWqDWYiCWsFqCSlrLuQehFKjdx@vger.kernel.org
X-Gm-Message-State: AOJu0YzGrmy/egow+b3LZF6qmixLwng9g0+T4TlqVDBiZNfT/JEXzTKr
	QBVUERcPQdhuQl/dfFo5++8y5C58kPwexOvoLRKcwyh1k277vlaA7qyclTrtEn8UFpRVhv2tHBl
	a2IxGHdX5JQGQBnGGN0GGD/wNMkb/zl+Nife0xEsF
X-Gm-Gg: AfdE7cncNBdGLeQIgMCMyk1RuOiongMuGk5B6WFvQjYzD+uLdCVvCqlDuh1MOwew2tx
	tE0vpqf+23BmmuSfPFFZ2aKPtdDuI7DvrZGYHnwGL5xZNu04iurFIBEiprffOaKfe3ukHBPxKPI
	gyGYT0rwi0oNXXR8zJUQfi47bvOcaoWHjPHKyDXFxKZMejIDUzXMBBC5z/PjOB/yjurbTtdz6um
	dcR4MwKaRdd1pe/UT1Ivt2trSnhqoI/Ir0PI08uwEb4iUPXkQ2Cw7FpDEFkxVrS4T80UCgNKquf
	byjYQDkWXE2st80w1naO1GmUTacTMTkIObqktA==
X-Received: by 2002:a05:690e:480f:b0:664:fc22:36cd with SMTP id
 956f58d0204a3-66521ad34dcmr7426372d50.43.1783085167252; Fri, 03 Jul 2026
 06:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-6-wenst@chromium.org>
 <akeyxn390mVmYo83@ashevche-desk.local>
In-Reply-To: <akeyxn390mVmYo83@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 3 Jul 2026 21:25:56 +0800
X-Gm-Features: AVVi8CePOG6OpnrlSpGFhkpL2GOtwCFUk_NB8IIc5qFTOLO5i-BW3OK69XKCfdo
Message-ID: <CAGXv+5G3ETTGbgjWJCbQjn9yvRamx4GHPxjWPgmy_aXWUxm0iQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] usb: hub: Associate port@ fwnode with USB port device
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 9:02=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jul 03, 2026 at 07:03:06PM +0800, Chen-Yu Tsai wrote:
> > When a USB hub port is connected to a connector in a firmware node
> > graph, the port itself has a node in the graph.
> >
> > Associate the port's firmware node with the USB port's device,
> > usb_port::dev. This is used in later changes for the M.2 slot power
> > sequencing provider to match against the requesting port.
> >
> > To avoid potential conflicts with ACPI firmware nodes and then causing
> > power management issues, only assign the firmware node if the hub's
> > firmware node is not an ACPI firmware node.
>
> Now I'm more confident that it does not mess up with ACPI case.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you and Bartosz for the reviews.

FTR Sashiko pointed out that this is likely leaking a fwnode reference.
I will add a fwnode_handle_put() call to usb_hub_remove_port_device()
in the next version.


ChenYu
