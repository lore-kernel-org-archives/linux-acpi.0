Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ADA349AF8
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771880010; cv=none; b=SCzD3Akj6ib6Tqnw7z+Hvx/yO4qQJrswYe4z/Say4pNq1QjFxyEhxuIAlEK4J9weBf7sFfyxgx++stlaJ91+5kGML0EXzp/JOzIOmAJFOX/IjSJxNilb32l9BClrNuygtuJCuFA++L3rKF/gI2xYhxEIFff3YymNAnPtkYp8qzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771880010; c=relaxed/simple;
	bh=tVaw2A8/zSgfDkV4gE2LRSuNl+dDGDSb2/JgQ3jlKO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyWtSFGZpzXAkVKt2pHYl92FCYiNPDl8T3AZC3NAF4OkhMfCcQcRqS8YVJJ3+8xyzcyQxSW21kXLhVnrb+1YLjBgITIvaPXNkualLpgqEcC6p5fXNrmgqIa6LKgjMU6pYHpzEqw6SYYFYTpXVyQOHDqwnAvt4Tshc2zH8UnU8RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYGnQteT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYGnQteT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90992C116C6
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 20:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771880009;
	bh=tVaw2A8/zSgfDkV4gE2LRSuNl+dDGDSb2/JgQ3jlKO0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AYGnQteT8Ma7tdrcNn1jbEn3WirBNPrcBPQBfENu3wnXYQdrkEQmvSjiOOnpqLARb
	 KvpsJTK6suPz6cQ7da6mP0xYh3A9veiFq5G/o7u5Mb/Rj6bIUujWABZr2v7tn5ZGX/
	 SmiBy+Cnv4rDi5ToeRZiaImiJRYIMU1QtU8W0VHYNhkVRdpoYG9XOU03kvRTRmthiB
	 OAndHoveyCICD/Nht2J3q65PChWZvNf1xR9uNFT3fTcd3dKtDURJOPP7IejW/u0wV2
	 niESeYuFZzRDceqk9874w8odgQN0XkTrozjZJOaSf/b4js9Phqj5A2UXIbAUUl2GXR
	 AJtdw9RHLO32Q==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d4b9c839b1so1902359a34.1
        for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 12:53:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2oa+YkD/sFVr/FTX3MeOoZDyjPiSuMB4Te6c+BQwrBXL4CBtAEbty75II4a6r2bU0t0imbHly5EzV@vger.kernel.org
X-Gm-Message-State: AOJu0YwyQaWT9R76xM03XhNo3MLHz469ShDjNdeCMDYbFMN0w6DbYt2U
	MbZ1JiCtWJ+25/q89iVt8mfoESu7M+Pf/Bno1kPBqofs+oMIoIwfx6t2PCFNHyKxcmEjm0koplP
	w6QFmcB2ZCAD9xunsjhQm/7vxf5DTQ5E=
X-Received: by 2002:a05:6871:79a5:b0:3ec:5e47:8553 with SMTP id
 586e51a60fabf-4157a505f0cmr5590982fac.0.1771880008715; Mon, 23 Feb 2026
 12:53:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com> <20260223204412.3298508-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260223204412.3298508-2-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Feb 2026 21:53:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gS6kyCOmwL-9JYiaxCDVubtBoK6Rb5NSgHD1GwkGoCRA@mail.gmail.com>
X-Gm-Features: AaiRm53R5zGZONV7LRjSx9S61mwEBpph3P8MzdzKWRPmqGH8J1uQZifwgGK08OM
Message-ID: <CAJZ5v0gS6kyCOmwL-9JYiaxCDVubtBoK6Rb5NSgHD1GwkGoCRA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] driver core: Split device data types to device/types.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zijun Hu <zijun.hu@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 9:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> device.h is a huge header which is hard to follow and easy to miss
> something. Improve that by splitting device data types to device/types.h.
>
> In particular this helps to speedup the build of the code that includes
> device.h solely for a device data types.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

But why do you want to move the struct device definition out of device.h?
