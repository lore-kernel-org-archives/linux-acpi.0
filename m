Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587246;
	b=QrSCQEk27as0dAIfQ0nVLzxV2/13UGpAZr+IT3wSCtJ5P8rBFdNqvJ03VvV6SADG9Qsc
	 wXs8POohfkkhBGJzJMbEWDye4gbaM3j8NiXeXG7TC8VBLm93lINUMfDA94uHlGRalYIap
	 69a0himTa0XN9W9XvElvuqE6f0AG0b2UiyCHkxYN2yljVyTGbSMv/e2yW9qcBDFPNv8Uu
	 7am8fOV7xCfBdVr1Q20lotknlY22OZ3PGFGKTHjqqt0MNdZVMywSjj+7m+OpUvJm2wqkj
	 bPzuL4dnkvoZgyn73RhaOH5Y2dWYm+9TavGH6qu4hoRv2RKbt4oX6ZNnjZ8+KdEK8/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587246;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=j97SfSaNINREcAUOnX4Ita9v3nTN3dmHaeIvc25MaPY=;
	b=G/Esagbf0SOKcikA7gCrmJf0XgN0A3F3XaF4yDRLohWziLh+cIhm0WYrI7fhm/QslLX7
	 /st4MpU7MPTxcwBgAvyGvK4UZ/hL0+IRs/+TV7aSfSt/tOnLwGijbT+6xLjaBBZvSDaPp
	 0/DX1t6fwxOH5zAWHhON4Nh4qGsvg+M0kEe4zEsix0IF5OFsQLrnoYheVHErVNhqXqiNG
	 phmp9YBxYupmtxVTAgvBbiQWE4mAvwddH1abNlHpZqtIuen0RCXP0vHs9l1cyBbtvaWqJ
	 5LwPv+1hA+0kid23BehXATfe7UvM/A8E+8pl5ZrXjeUcfwHgmFfMR6TDNN/H6aLlWYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nhd7Tn/G";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0741D606B2ED
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhd7Tn/G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CAA1F000C6
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587245;
	bh=j97SfSaNINREcAUOnX4Ita9v3nTN3dmHaeIvc25MaPY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nhd7Tn/GnjgtnmAIXpmt3VH/lRxhsFlvKIA1WFp97+DFSDKPw2zptvVl6GiEpLf9K
	 XKRcm1LTsf/YJQfcBhuaugQmBsd1xKPNEunyd26O1hk+554xAnP9LEHXNJekMQz+CG
	 RnRb3WEyvXapTEw2ZTgCPJj61jln/91QjB8xV8V82sXxgkUFexbibLt+7rC9VlJhVH
	 5J+iyqJB7bDPWIWP8beYWnQH57tOJVKP8Lox/bLL9Zp/wlq60nHzyOvjPCeV0SnZ3r
	 qs0YwsdTDa8KaSW5djmS+Rtp4YG5Ym0FW7GgbHiH6gfIXatJKnLjqWtsZp8z0htQjS
	 i4OzowCaWJu7A==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3acef9307c7so14642571fa.2
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 08:27:25 -0800 (PST)
X-Gm-Message-State: APuU4Z+3yq5tNjmpmesYK8LFHWqj6FWayZBSdxBJOXW06mnFWZPCG30t
	rlQR/fxhHWExG18Kw83HuczOdyOtikXeZJYKClgC3jmR06dbjFhViVhvBgpK3WywM+s4paPksre
	1qxMYRVdiCDa4MCRYwpktGjwsS8SXy8c=
X-Received: by 2002:a05:651c:b2c:b0:3ab:2a19:862b with SMTP id
 38308e7fff4ca-3ae2b4b7fd2mr9981721fa.4.1794587244008; Fri, 13 Nov 2026
 08:27:24 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <3471545.44csPzL39Z@rafael.j.wysocki>
In-Reply-To: <3471545.44csPzL39Z@rafael.j.wysocki>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 17:27:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gB+ktRht4j8SjSTo-mqmsRR+e5m1sfc6j5gnGop6=BJg@mail.gmail.com>
X-Gm-Features: AclHuK-loPyRxcKMfF_r6Mj1RdEKPCYy9Gl17nXvlsXJr1eeoXvD_joakaRzCLQ
Message-ID: <CAJZ5v0gB+ktRht4j8SjSTo-mqmsRR+e5m1sfc6j5gnGop6=BJg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] ACPI: glue: Rework ACPI companion lookup related
 to device type
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andreas Noever <andreas.noever@gmail.com>, Mika Westerberg <westeri@kernel.org>, 
	Yehezkel Bernat <YehezkelShB@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 10:12=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi All,
>
> The ACPI "glue" code is responsible for binding Linux devices (like platf=
orm
> devices for one example) to their ACPI companions (represented by struct
> acpi_device objects).  This is done by acpi_device_notify() when the give=
n
> device is registered.
>
> If the device's ACPI companion is set already at that point, the binding
> simply adds the device to the list of "physical nodes" associated with it=
s
> ACPI companion.  That's the case for PCI devices and platform devices, fo=
r
> example.  However, there are cases in which the ACPI companion is not set
> upfront and it needs to be looked up via "lookup helpers" registered by
> the subsystems the devices in question belong to.  This series changes
> the "lookup helpers" representation and handling.
>
> Before the changes, the "lookup helpers" are represented by struct
> acpi_bus_type objects which is doubly confusing because they have nothing
> to do with bus types and because the "acpi_bus_type" name is also used
> elsewhere.  Patch [1/3] renames struct acpi_bus_type to struct acpi_dev_t=
ype
> because all of the existing "lookup helpers" operate on device types.
>
> Next, the registration and unregistration functions for "lookup helpers"
> are defined to return an int, but all of their existing users effectively
> discard their return values (they are discarded right away or passed up t=
he
> call chain and then discarded).  Patch [2/3] changes the return type of
> those functions to void.
>
> Finally, since all of the existing "lookup helpers" match dev->type to
> a certain device type, they can be rearranged to point to the device
> types in question and provide a .find_companion() callback, and an
> additional .setup() callback in one case.  This is done by patch [3/3]
> and allows all of the affected code to be simplified quite a bit.

In the absence of any feedback I will assume no objections or concerns
and I'll queue up this lot for 7.5.

Thanks!
