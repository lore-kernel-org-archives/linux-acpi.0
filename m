Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034323806CA
	for <linux-acpi@vger.kernel.org>; Thu,  9 Jul 2026 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607477; cv=none; b=TZR0bY3RN5em/vBS+qSeHgHZe8El4sxJMVXkdoqHbdlT/6UsrUz95C76fdPDwdkjU4LQ6r5CjV4XkmKfwAartoGq/yY0sXjgDCZ/8gwfXXORogLc8cr4oN4MtKDisiaoRrKAkvbFBs2tpM1AjQbnkE+1LdPPi2B+thFS8B3mi6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607477; c=relaxed/simple;
	bh=C3Mw8q4Nno0demwxgT9owXxN/qKewUThoyTmm2QW7F8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiFJKiQtE6djf5diW9tQON47olI0ONlPLUzbeSFpv37b0Wkf7rWayDStgJFKsqKPlYqVkfYgl1sfcaqYROzdIQfwvrShEF73e0mM6imrv4UKrU5Q51J2SFoczKKm+iQI1LLTpxZ9uoTGZZXhKRLohZMYneKMSne9zWfnpXXP+GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLOZIDO+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLOZIDO+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15B71F00A3F
	for <linux-acpi@vger.kernel.org>; Thu,  9 Jul 2026 14:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783607474;
	bh=C3Mw8q4Nno0demwxgT9owXxN/qKewUThoyTmm2QW7F8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=iLOZIDO+lyJhwkH2hmjAysd5QarjwYBTfZcs4s5flnO8wkm4BzWLLE6+SqDT375Zt
	 mhcwPGTRdwFWbcfcFDqrD2SR6x4e328QZ/GdjwL1UQpjIG1MIRvmJ8qjtCQS020ukY
	 DIKnWCJsybahgCObHZPqid4wiSalS1g2MIbJd5J7HRWhlG81Y1DO7eale792kvHxAX
	 n9QGRG8VUpEsOlL7/JRTX6seju7rdberuvBc1xzyb4mvLC8jxCeUydDD5+6I1HC+yI
	 jWyGyAIWRJU2ZYlE9joTS9K5JXltFrnwGmqkMfX1bL/gof401wvHNwu5QE3z6XpDzI
	 bV2kCg4wjnO6g==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c61ad6750so15128021fa.2
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jul 2026 07:31:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YzeXFTAr7RYLiZOxxzscPpMVYYrl2XnRExU2Gh0qNOzpjyaYprg
	25XkkBGrXea4j7ni8ZC4+oCbxgKnTCiUqrrZDchUQ3jobqsh9rKjVspJpwbIULwk/TRu/YJL/Mn
	UYt8Xionj2ZjnJAWjxtybqXo0NFJI9TuB9HM8SzcKjA==
X-Received: by 2002:a2e:a912:0:b0:39c:6ea4:f0a1 with SMTP id
 38308e7fff4ca-39c799c85e2mr15206641fa.26.1783607473388; Thu, 09 Jul 2026
 07:31:13 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 07:31:11 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 07:31:10 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260709095726.704448-11-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709095726.704448-1-wenst@chromium.org> <20260709095726.704448-11-wenst@chromium.org>
Date: Thu, 9 Jul 2026 07:31:10 -0700
X-Gmail-Original-Message-ID: <CAMRc=McZNHswz2E8-0-XKpUwrzw4vNooGrYe893hWe6_Fk72yA@mail.gmail.com>
X-Gm-Features: AVVi8CeE1ugyeFFTvSY6q0TqTEjoKIk_A1SAmSoXfKQhtfuqHopW23IvHHyz7SA
Message-ID: <CAMRc=McZNHswz2E8-0-XKpUwrzw4vNooGrYe893hWe6_Fk72yA@mail.gmail.com>
Subject: Re: [PATCH v4 10/14] dt-bindings: usb: mediatek,mtk-xhci: Switch to
 ports for USB connections
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jul 2026 11:57:15 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> This reverts commit 454a1e3cd36c113341d7b71e8e691c6e47ab4a8a.
>
> MediaTek's XHCI implementation supports both USB 2.0 High Speed (HS)
> and USB 3.x Super Speed (SS). The block can also be synthesized with
> either HS-only capability or HS+SS capability. The SSUSB controller
> handles the device or gadget mode. Saying that SSUSB handles the HS
> portion is wrong.
>
> For example, on the MT8195, the first two instances support both HS and
> SS, while the latter two instances support only HS.
>
> Switch to a "ports" sub-node for describing USB connections. Port 1 is
> Super Speed if the controller is SS-capable, otherwise it is High Speed.
> Port 2 is High Speed if SS-capable. This port mapping scheme directly
> matches what the hardware returns in its capability registers.
>
> Fixes: 454a1e3cd36c ("dt-bindings: usb: mediatek,mtk-xhci: Add port for SuperSpeed EP")
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
