Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672753C4565
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084603; cv=none; b=V9GTqBRlTIIxo78iIsaIjtwPOGG1L8pXmeU1skRVwI8XD2BMW2HLKlDpHPXoYzBnMU2yvnSAC42St9nAcQU1oZNBwum3ARcwRo2C2B3xMSSE7m4dWnMffe1tYZs4FK6Hs5sijXIQcKTTTk9z3YmWashs7SgJ/JV931HAxuQMYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084603; c=relaxed/simple;
	bh=gV0Slrjr8IXK+MlTCt7MN9hZHNcIK5BTbT3wdZMhFWk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBv5oAa/jwWwsUL26kyFntEc0CNyz9HVtlCmFMZjalF9l5G4mr76WWkkzsolQKinxmw0WXIgYZcCkrp3LS38xI4uTmABRgvjHhiLzzz3eR7eA+bS4/KL7AxmEqf1jCSZCLEIctHugqBOwJmqcYn1aMHQIs+jAm5/af0DumJOHyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSjWQJMV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSjWQJMV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AB21F01560
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 13:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783084602;
	bh=gV0Slrjr8IXK+MlTCt7MN9hZHNcIK5BTbT3wdZMhFWk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=oSjWQJMVtg8g/LXoUb/K2FqnMziWICTYSrswtHn0oREeAe9aGAEYylsP6FTuQE+dn
	 wjGcvMuvcRqlVqoh7z8fwaNzIObZDxlRBmXX30cJheTBHAMRiQRW2RuEZByS4wcOe3
	 jylAsGqYV5LUq0Mtm9kijSAaV4jz7Z1m1+pn3+uswdn7rouFE4CSzcakh1RFvjbTVG
	 TAo/PBKLlq4cY94y8732frnrFqI0G+57B/6Coa9bTvjuMcke80Ok/wRiEhvPcWYLrq
	 QZcgKjIj341ZG9DxLr1WSAQ9oGUWetnM5Ixk3cqNtqKBGe3XjpxSF3vLN/YA0yWB72
	 oPqwysfcEV0eQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39b349ae174so4923561fa.1
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2026 06:16:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YxavV4/+BcX+33jab9kMUqqRQ8wQxtOwWzsXu3BpyGlK17N/N8T
	4AJkvImXNG76G2YX8L9Hrek8ENTkGmeWnx3La7DF+bROv+5QGDZce3E7fA7Iusb+P++hwyapu+v
	nZbBzsCAxX4Th7dPNEvtNGvK6qKcaH6HcUebxndbNPg==
X-Received: by 2002:a05:651c:2554:10b0:39b:90f:b1dc with SMTP id
 38308e7fff4ca-39b36e0af76mr18538581fa.13.1783084600750; Fri, 03 Jul 2026
 06:16:40 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 08:16:39 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 08:16:39 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAGXv+5GHFnMj3qr5BcpLCQk25rWYOgnMKUX079ScELs4uqEdVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-9-wenst@chromium.org>
 <CAMRc=MdMhr6qAnAtUePbuBbsH=3MzRC+BrL5GssbNTwGjp_ayA@mail.gmail.com> <CAGXv+5GHFnMj3qr5BcpLCQk25rWYOgnMKUX079ScELs4uqEdVg@mail.gmail.com>
Date: Fri, 3 Jul 2026 08:16:39 -0500
X-Gmail-Original-Message-ID: <CAMRc=Mdoj204dTwVMeqFwsVt3f4JJUJtk93VL2hDgh7+C60eqw@mail.gmail.com>
X-Gm-Features: AVVi8CfEGr9ongua6ulDVSCJ0raV9SIaG27LcZHKlrYzQjvFFBvVAoVU8_PqL0s
Message-ID: <CAMRc=Mdoj204dTwVMeqFwsVt3f4JJUJtk93VL2hDgh7+C60eqw@mail.gmail.com>
Subject: Re: [PATCH v3 08/13] usb: hub: Power on connected M.2 E-key
 connectors with power sequencing API
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Jul 2026 14:58:56 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> On Fri, Jul 3, 2026 at 8:41=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
>>
>> So this is only needed to not have to track the state in a separate fiel=
d?
>
> Correct. Reading the field is not the problem. Updating it is, as the
> fields are packed bitfields, and Sashiko suggested that locking would
> be needed, though it may have been for the peer port, which has since
> been removed.
>

I'm not sure if it is. The user controlls the handle. We could argue, it's =
up
to them to provide synchroniztion. We only assign the target and pwrseq fie=
lds
once in pwrseq_match_device() and only change the powered_on field later wi=
th
pwrseq_power_on/off(). Unless the user does something weird, we should be
alright. Maybe a small note in the kernel doc would be in order.

Thanks,
Bartosz
