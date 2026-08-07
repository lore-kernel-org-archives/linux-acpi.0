Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C2332B13E
	for <linux-acpi@vger.kernel.org>; Fri,  7 Aug 2026 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102546; cv=pass; b=u6OnVf/WL0V/8MUpjF8nwUQeuQFkoPIwYFp0QfftS29UUOCnZ8PpCw/TQATqFi0ZH6kzICwndRTMJ4zkJAsVyFZecmrK3AD/+N8DiSAw/LyyL3T8OljWpz8xnTZPX6C1wyb8jkPM3+sTiuVWtktmVBI3bFT/gDOxZO0j7xDpWio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102546; c=relaxed/simple;
	bh=KonotXRwXiSLQlw6vlTzZA1LY9JAAKMhrEBp5NWp/aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYAFlPtJkMVIncL2ZsSewFIGFbM/L9MqJLmaDmOyRdXsSKh0+SlXIRePOx0oyb/eDRJnrXc2j87u9C8eUppXRpzSJJWwjcpE1f5zFWua1MF8UYt1SIQZvSSQOLDBjZb8+tkxGRIkJmTr4LQRZvMRzJIKB0m22nvBdElBvBfp+bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gywRWkup; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gywRWkup"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81ed073fed0so42195337b3.0
        for <linux-acpi@vger.kernel.org>; Fri, 07 Aug 2026 04:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786102544; cv=none;
        d=google.com; s=arc-20260327;
        b=kZaJQaFEcP0aSTRW4fGV0ecbdh9hwF3ZUoUHU+HMkTtcoGlO0ecELELuTEwbCkRhBC
         mFukb4uZYDcrKATjbBbhQnS75b7reabChQM3jP+PJa2nVQDTo79bYxEvg1aQeLbsC2Gu
         9Wp7RMBz3DZOjtsQmS1jp2SQTMucozvs2OhjH4jxO/JxzhwcPPiwjo0lz7R3NZ4zH3/A
         XMSsxzoqoXTVkLBGG5fDNZGTcsubQ3i+OQD0UR2ZCqa2YRNNH+q177EgovNXlTyO1+T6
         HqmHvX5h7tw+scZyrKGMOf/qlgyOxvtbJz4pRlHcMNs3P2+QaKaUREryGykhOCVgoBI4
         D9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NFbpeccrBLnPNDngnsLUG5X8Bi2l3FjgVOiCpFS3kpA=;
        fh=ElSTs2cs/G2/Ni5p+X129tKYLNHwMZPfXs0ZhOijjg4=;
        b=AolFZqUus5Z5wyZr5ytLTK5NIlK+2YfN9bZdDWBly+46eaDOBj3QMqJH3zuLiKpE6K
         +ZsVwWvm2q/kr8k/inpekpxZFBR+Q1ocT7Cg7NzzO5IbnurLhpt/OYoxHJQbD9TthcsZ
         VrsdhMusHWStqfqvzeBkNPFb5uInpU/DQl5xLHuY6oRbc/0YAb+k6EAk2wOgax69yfzg
         icE9qnRwtu6SglJTu48DqXzmiyQXmovPQnn6bIm+zMNl/jOL3QNBqWdCxTf98z9KJYJj
         bBt93Qsn1+kb5HVpVBKsYYTut7tHafEG3ToyIIwvONwiUU6ErbzjxscXa/yJWb31X1xx
         rOxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786102544; x=1786707344; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NFbpeccrBLnPNDngnsLUG5X8Bi2l3FjgVOiCpFS3kpA=;
        b=gywRWkupYdQcwx1CAxh1NJRwVrJW56NntIg+rqr98QrAOpyb8Sl9qH/7GgAkJNczIF
         ZqesRdYr5qrwH0RKrlknW/OgIQBDeZcA+0TSJWt0R41Fwu2j26OC4AW81eT6xGJ85gqH
         Dhhx6WGz4rhe7nooO4yzXrTK1Zg/O1jCa3jmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786102544; x=1786707344;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NFbpeccrBLnPNDngnsLUG5X8Bi2l3FjgVOiCpFS3kpA=;
        b=nTnVmmQ1Yinn9HS0qr/3GCYSkn7fMqbiFdUVp4dEESpuduq/eeeU8uHx5qiNCuWTh1
         bJGHozWBs2T9YFB74zUkgpxrTsVC4SF2P+G7lvfTb/ARyMtEH0ySYcOoIWR1WviPsmgE
         aygXid6RzwAYg4FZM+FI3Dp4q+BRkgiBI+akoucasDIL6kajzAo8ZWlHjqWsNP0/pO5T
         kTQy0r8T2uWbJbA/dZjPQWV89KziHxChJCiz+/1Z6jtc8xn8j473XJGbHmH2e2ph4L3b
         3aIBFO2QbKS8FU5UX47OjseZeVnFitluAYNn0KmXiBMK2cK9HEFyYWFby3llEbvJCKR8
         VVpA==
X-Forwarded-Encrypted: i=1; AHgh+RpSCnLQq2NziaKcD0XcNXHORqnZJTMpwMgIDgezfvQxN6kxZBJaaxlBgqlQ5OiB8lwPgxN3RkJd0jEG@vger.kernel.org
X-Gm-Message-State: AOJu0YyEtfC59sQjiT2PcVSsyGluFK5Aouc7oHeqe/ChLPyMko1f6FDx
	vDXpKoadzoo9CpioxVXjDOl6NLG15VliaXyLN8+1Djn9f7ZreMIrWJ796EGRZVd38/mn2bn3v13
	3lO/s5WDthXyEvlAJeF0V8cRiSSU1k84jgXRoPogo
X-Gm-Gg: AR+sD11N9Sud13ztNpaRURGwHu9LG4ltPxkIcgK3TbZ3jyF9ngrs2VFRXNVKAkt7awI
	41NoRw8Y/jOlUdehfSw/a4I64YVaaRuD7mvMF75XpfRvS5FT9IULlHUFwIFZx3BIWSkLJ9TVxio
	/HxhbtVQx87R1OZnmHakPkvzIUF2TZlfpj5BCH5Wx+CgAMQFjkMvNw4KkMbN1bb80Ussn3k8WIX
	9oK9tFzqBpuBIG4aaebDmqABXNWWdHCtrLNIaTTpwFwLRTDGOCi6Mo//zxHptpXvn1rWdTI67ta
	ej3RxI/WiYAc3PXzyEOkuqdGP2rL4Yl4XJIf+WElWobTuDkKuXdLWncdU/EOUmw4FbkytowfdMz
	EjzFSJRhBKQ==
X-Received: by 2002:a05:690c:480b:b0:81c:872a:5152 with SMTP id
 00721157ae682-82022510fcbmr127613327b3.30.1786102543795; Fri, 07 Aug 2026
 04:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724084328.3943997-1-wenst@chromium.org>
In-Reply-To: <20260724084328.3943997-1-wenst@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 7 Aug 2026 19:35:32 +0800
X-Gm-Features: AUfX_mzUutrA5-Q9ACqE0pQ_D7Us70orWiV3KcyO1fjFDW5_he5R56G8cIzEovo
Message-ID: <CAGXv+5ETE2WAA8jwnQKSe69aR=qrqKnALuiSM12X_ZwFouxdRA@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] arm64: mediatek: Add M.2 E-key slot on Chromebooks
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wei Deng <wei.deng@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mani,

On Fri, Jul 24, 2026 at 4:44=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> Hi everyone,
>
> This is v7 of my attempt at integrating the power sequencing API into
> the USB core to support the USB connection on M.2 E-key slots. M.2
> E-key was enabled in v7.1-rc1 with just PCIe and UART supported [1].
> Hopefully this is the last revision. However the pwrseq patches haven't
> been reviewed yet, and the fwnode patches need a review from the fwnode
> owners.
>

[...]

> Patch 12 adds matching pwrseq consumer by "port@" node to the M.2 slot
> driver. This is only used for the USB target, but there is no attempt
> to differentiate the connection type. The driver simply tries matching
> the "port@" node first, then falling back to the port parent or device's
> node.
>
> Patch 13 reworks the power sequencing targets for the E-key connector in
> the pcie-m2 driver to add targets for USB and SDIO. The former is used
> later on in this series.
>
> Patch 14 splits the Bluetooth power sequencing unit so that the USB and
> serdev consumers can separately toggle the actual state of W_DISABLE#2.
> This patch is purposefully not squashed into the previous one to provide
> a clear target for discussions.

[...]

>   power: sequencing: pcie-m2: support matching on remote "port" node
>   power: sequencing: pcie-m2: Add usb and sdio targets for E-key
>     connector
>   power: sequencing: pcie-m2: Split Bluetooth unit based on interface

Could you take a look at the pcie-m2 patches? These are the only ones
that haven't been reviewed.


Thanks
ChenYu
