Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188FA433BD8
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419729; cv=none; b=TBAlHw8o9IfaEfx0OHwY0IkNzC/+wP7gETFP0Q4e9QoHNnxriq+jf+dgd/ixl+bS3ioeM0K84HzpDeHVymnim7BJSNlTz1mAodGh3GFFW59j3x9xN2sGlJ/NwyvIP3+4LUqkqHbYDL8XFOrBwD6cWEDSaXLRIk/GkBKkT+kjvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419729; c=relaxed/simple;
	bh=sKE2xC6X+2IdWYTl4zutx8wFqjnVGYhszftxHKoGsyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/qYGbaH0+7wP23xAUZ8K/u+xHGltBNAV+FkBGSgsEjqESPqybXfeEOvt2hwrMx+qxe9DquXLefCPLiPxpfTDxStxcGgoXPuGsixxkShIhuKo/i39PgW2S3f/dllze+yP/8PL8e4cyYQJxcL9K9yTm1oG69dtfBT+IGj52tnwsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcMaWMSv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcMaWMSv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4A11F00A3A
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 13:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785419727;
	bh=YWCbGRN60aLduWSj1P0c1mwKjRkg5va/RqN0EEDtBiA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EcMaWMSvpvXflh1UWsET849B9X8RIOgqkUxP5QJ59JsAMzXWeJqyFi+XG3cW1/o3u
	 qRC1YtWSRz4mqUOV2+x1fPE/xIs9ynQFRS+6Jfi6dJa0dbMrnnmwDM3yX0hKHuBQa6
	 1vn+RQWTB4cENKShzJv/VMkhfLrbU9VvRZ/HbqB2zMJ4U6n1iokzorghgLQ+Gq4akG
	 63osD3uVaC/l4DoytIbGer72ThsA1SKLq0NJE9LD/gDP/I27v0tTO05N1hZouihhBI
	 zUtTXYvunRF5U/rsuKPse/aZOijsdC7Ib+ZjtYARFE3+rO1CRpV+nCSsMz0//Qr1w6
	 fSScFyaKEK7Pg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aebd52488cso2340978e87.2
        for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 06:55:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqXDfzqlcq5NAssjjYar2oad8fTgTlcUhH3P8/jXTk4Lw9djCHn9aUsiN1CvQ9moK6ZVLaVTL38/4o2@vger.kernel.org
X-Gm-Message-State: AOJu0YwHpbhrRzqGgjFmRddBn8btf7hDsVnZh25eyiu7EOFCw49Yxg1e
	7s+31as9IHVStdKx82CCCCbAti3TzNOxTdkx0yYUa4TClnVMvg3e6z19L5ID4fYHT0YbZWExt02
	ccd561KpGK2SF7tRuiDViKZrm4iGdtKk=
X-Received: by 2002:a05:6512:39ce:b0:5b2:a951:d959 with SMTP id
 2adb3069b0e04-5b2db378408mr732761e87.42.1785419726227; Thu, 30 Jul 2026
 06:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3353bdf3-4f33-44b1-809b-b0378bee5816@gmail.com>
In-Reply-To: <3353bdf3-4f33-44b1-809b-b0378bee5816@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 30 Jul 2026 15:55:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h1kqDEBYk0k05rv6f2SJ7g+TN4FhBDJYZSVUctu-0FdA@mail.gmail.com>
X-Gm-Features: AUfX_my-eWqY0dDbynyNa1iUY9tCXfwBCUG1XQRADfSP_Nxlv55HPv_Xg2X8VDY
Message-ID: <CAJZ5v0h1kqDEBYk0k05rv6f2SJ7g+TN4FhBDJYZSVUctu-0FdA@mail.gmail.com>
Subject: Re: [REGRESSION] usb controller fails to initialize on intel s1200btl
To: Julian Silver <mendaxca@gmail.com>
Cc: rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, 
	linux-usb@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 3:25=E2=80=AFPM Julian Silver <mendaxca@gmail.com> =
wrote:
>
> #regzbot introduced: c0f691388992c708436ab5f6e810865be6ddf5c6
>
> Hello,
>
> After commit c0f69138, all usb ports on the rear panel stop working. The =
kernel logs show: "probe with driver ehci-pci failed with error -110". Spec=
ifying "intel_idle.max_cstate=3D0" can work around this issue.
>
> Please let me know if you need any additional info or trying patches.

So you get a timeout during ehci-pci probe if the intel_idle driver
initializes before it.  Apparently, CPU idle states get in the way of
HW probing.

Does adding "intel_idle.max_cstate=3D1" to the kernel command line also
help, by any chance?
