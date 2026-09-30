Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4269511E80
	for <linux-acpi@vger.kernel.org>; Wed, 30 Sep 2026 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800882; cv=pass; b=HMqacBN4YJ2ved8g/15yS8W+c+9ROrQldY9oL0LFD3xlSEltv+fd45mkBWZOWY2aYXod55Q764yYQfiaVbnf8q7qgeGfj3/y5prcfF+nQ3pAcHUQAJcQ1M2Su8MXmKDdqxLpIHCSnUWVrC5TqzHhGbwiFjpcMktHB6rCKkggXTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800882; c=relaxed/simple;
	bh=4ZgBL9At6wAfTG1eapgAa5Mkts6axxE7nn1CIos/pc0=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igwxii6Saf8CklS6aRy14WTTLHYbBQFHSiYzP9IG7lZ9J2rUGk5MGe0lcQzGC24yUKUsGBC1wXAvdYdhDJM3hIZTaxLvC8OR3EP8QZyrlINHCDmlI3vfasKdXMt6lxD8LfilxeFw67yx1oENt9P7XHm+vPXk4rbMO2NFkvUq4jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/2M+WH9; arc=pass smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/2M+WH9"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532d8b454e1so9409681cf.2
        for <linux-acpi@vger.kernel.org>; Wed, 30 Sep 2026 13:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790800880; cv=none;
        d=google.com; s=arc-20260327;
        b=EEUENRBJhgg653SApmM4lRgFXprLPxJDD1wb/wcpYYHTvIiWuZYoPBYfcWJ5bVb8Ee
         AjAhEBsq+BNJ95/8W6lXmgYmfk6afOz+DXqiuf+GldinmESQXVWUgAbYJhqYr9wGdgOq
         Y6wkXtHQDye5jWPHufLkaLkJclKEW3V1yLO0//+4fY58pM7Kc3ZoSpc3MkcV9XT681d2
         s9Ab88OCiC/mZ3u6Xke/TTckDObma7Qo4kjccRH2MY8oaBvJsaSlglJvBi5NdTZQxLfz
         OnQ5Kj5735aG0GGmg34DuparUUAl3e+UimbDB6SkUy0V3BN89dxTwgDMydMiHw/2C1B9
         +MBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=4ZgBL9At6wAfTG1eapgAa5Mkts6axxE7nn1CIos/pc0=;
        fh=khRdyQmRy3TKLxenTcW8J9AADHKuZLpsXnPuVSMr2Hk=;
        b=dQqxfwBB6xaS4WXeIQZ2z6LqzAy5V6bjKYwjfIjQEXdGOLwwQOnfsUaTri/L2DX6bf
         xzUQ9LlCLDOa27aXxx7sHdPpKr7ztkkGyGJVU5yZqr3J3MrI5WIrJF2I2LzLavSDPHY4
         LcmA3u3vT6H69p1EBSv6oyNjI+NXdkJpUJ58KggjK/fu9dsUwSZ8c0s+VRsEeTJ/PI8k
         ftz9mzEKgeicOdaXXjmzW0Ucg5n7qgQQldEddrQ1HY2a7Sd9vjEI7JZWSXCULbLM1YKH
         o4lsz1vI6PcpdDRH49svgkU23YP2bPN17YlpTg7/RIEPD/WdKDthCBp724Ec8wcKsLIU
         YfQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790800880; x=1791405680; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4ZgBL9At6wAfTG1eapgAa5Mkts6axxE7nn1CIos/pc0=;
        b=L/2M+WH9BPjv3gBD5XuIqtyyXziAr4FnWX7HFBXQkcgKBgza39T3xHpRgd45MH3Yho
         m0IJ0RrwHj6ce65/bHh/+gnj6kGSAqVY5UzfeSP90mguYnQPqxrgzpj4NuG/mkkguSfK
         GO20mK3/CfAVZC+agSrxGG954CwlKBllgMIfS5jdx4KuPpv/VtHD34Au88+wdYf6OMw5
         aDMSlHCwgEbKdeZTeiAhD4yXj0k4181yD7xQ2lapkug21sn1JRoi7Hy8etE+VbC48ZCv
         Lb6kqDzGt0FGySjuHzbMccaoEJgsmQmtPq+DYK2K5GZBJjAUQSBCuabsU/9gzs5PDyZk
         BNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790800880; x=1791405680;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4ZgBL9At6wAfTG1eapgAa5Mkts6axxE7nn1CIos/pc0=;
        b=M+rBWIA9WcGjmj0w3axg9/pYd1/pBEXlFK7vOEXVlnnsNvBjUoH53HBZMEH5hSrUIS
         CnjCy+m1a73yg5A6Gg8WU2rKO8AueQuXPYNlsnp/DU3Y/0yvc/hcwYoWrzrrbGizi0g5
         2LJXcayY3Q/pxTQyB8roM9tCjgr1hpQAa6QnANBOFerbEvzKZE/8+jAENmJbev2TDLjr
         OW/FfFCVXjVpNyp5z/tMvtbK9zN44ixf1V96CTWdTx5atVXClUWRmvMJAMXsYAugK5DY
         qim4rorXw1aKljQ0Qt+JUEjXVqI0emVBCm9uwPnIR+GfF38tR5X6fulcD7RQtnAeTURl
         VKww==
X-Forwarded-Encrypted: i=1; AKwUvBzC6Imy0cyCfbMyeIbq888kboxf9Jh55bh8Tz9BG0fIfpOt8Vy5RLxOmUtMZWMvk7Vk6kzyGoLQ1Umr@vger.kernel.org
X-Gm-Message-State: AFuF++klBvLZIKW5bcBpE17qxrRvuw5vs2iH5M25ZA8SZgFrUQWUsFuj
	UbGyM/wudxQtKKTuDwtXu6eowBLPu5peFMIbG6NcUdDbFRJDnpM5xjUTWqJgbUUhxmu6d2Sy1FK
	09GhNcrpMB31ylY4DGvO+zy3L8iNjmi8=
X-Gm-Gg: AYBFou0WA1EZzdKBTvzmmWKROLngBFtVLOWYQ2nv8m8QTPY+WqE4ArhMwsiHu9BziTl
	iHgQWtxyETSrFanDimyBhbho0IGb+rxJrx80XQpPZ1Lx/h3GOI6T5Wqr48PLs0FjqsFCBm5WXrs
	pD/mA65t9hJfNvgsyCgDf6YKCdS4Wkjvv16XoDZzu1HMmX3J4Z+I9GdE2P8w2EQgBl/lAQ9GgRK
	Z16FgHk8JQpKyM4gSLFiWusuW5ZwE/NH1K4BmbWZnc6WK5Z05pcXobdVC05AtwQEowVk0pKopuJ
	HoNRCTLo53jekbJrv9t4UGhPDHCbd27VhmiP+4HsbYzAlTSxpvlXlrTS/dyC8YGP4GT+5uq0ob5
	FszEmT3jcx8KytfKZKF5nnCTBU0EeR0eUSae/xCcA
X-Received: by 2002:ac8:7fd1:0:b0:52e:3991:84c8 with SMTP id
 d75a77b69052e-5337433c972mr47060651cf.2.1790800879485; Wed, 30 Sep 2026
 13:41:19 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 30 Sep 2026 16:41:18 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 30 Sep 2026 16:41:18 -0400
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aqfyj9saFPR2K8j2@ashevche-desk.local>
References: <20260913095111.2543502-1-miguelgarciaroman8@gmail.com> <aqfyj9saFPR2K8j2@ashevche-desk.local>
From: =?UTF-8?B?TWlndWVsIEdhcmPDrWEgUm9tw6Fu?= <miguelgarciaroman8@gmail.com>
Date: Wed, 30 Sep 2026 16:41:18 -0400
X-Gm-Features: AclHuK9Ie7lhPgTp1aQTn9gk8FsouNbrLOg2hwfGPxPNkd7QeiClVQ6hAoric8s
Message-ID: <CABKbRo+zGanUe4uJU1HC=Nwm6E4j6DUh55pEgvng3U3AmaOPQw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: device-id: document struct acpi_device_id
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: rafael@kernel.org, u.kleine-koenig@baylibre.com, kmehltretter@gmail.com, 
	corbet@lwn.net, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks Andy, agreed on both points. For v2, I'll use
ACPI_DEVICE_CLASS() in the commit message and move the drafting and
validation notes below the --- separator.

Miguel


On Mon, 14 Sep 2026 16:11:43 +0300, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Sun, Sep 13, 2026 at 11:51:05AM +0200, Miguel Garcia wrote:
> > struct acpi_device_id lacks kernel-doc, so extracting documentation from
> > its header describes ACPI_DEVICE_CLASS but not the matching table entry.
>
> ACPI_DEVICE_CLASS()
>
> > Document the four members, ID and class-code matching, and the table
> > terminator. This complements the pending documentation header-split
> > update without changing its include directives.
>
> > An LLM drafted this comment and changelog after being asked to address
> > the missing documentation noted in the header-split discussion. The
> > field descriptions were checked against the ACPI matching code. The
> > extracted documentation passes kernel-doc and a focused Sphinx HTML
> > build with warnings treated as errors; checkpatch reports no warnings.
>
> This paragraph is more for the comment, no need to include as is into
> the commit message.
>
> ...
>
> > +/**
> > + * struct acpi_device_id - ACPI device matching table entry
> > + * @id: NUL-terminated hardware ID (_HID) or compatible ID (_CID) to match.
> > + * @driver_data: Data private to the driver.
>
> > + * @cls: PCI-defined class, subclass and programming interface code (_CLS).
> > + * @cls_msk: Mask selecting the class-code fields to match.
>
> Hmm... The only driver which uses this is AHCI. Yeah, that's fine, of course,
> but might be that in the future we can replace that with a traditional list of
> _HID:s, who knows...
>
> > + * Use @id for ID matching or ACPI_DEVICE_CLASS() for class-code matching.
> > + * Terminate the table with an entry whose @id is empty and @cls is zero.
> > + */
>
> --
> With Best Regards,
> Andy Shevchenko
