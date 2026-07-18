Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CECD37F74C;
	Sat, 18 Jul 2026 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784365669; cv=none; b=KtNuvvEs06td60R0LoHnd3c3WsZ3QASsyYFReW9m9ViIycfduhsWCP3XjhJB2mJ8vLyD4uVF8WQlM9mjT9CcM/gRLqiQ8BZDSTNlyxlWDDq2NoE8qiqLsuOdrlscSBZoG/YD+iTUghiwd5per57Sd0zJLTpos+cVEWnCZ12XChw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784365669; c=relaxed/simple;
	bh=nYkxTwAS5bKW3I7rAhgCy9zpVSs1G0EhoUAQHVDPfyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OC37YyrDLRtoaGnlMqGDSxamQhadbL6FGsKIhn/BQmrYqoon+6iWxv1kAEbW6tBFUuH6gQpQ9m4iHoICEuyYdjnPtb/Ut/JIt2AelZpb0U2q0MnFGI8pMWW0iHXrhWAeOZ1r7PZfkd3eoXxeNRCXbaBI9CFhr/Ic0ZivJxsfW3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bEoMuQq3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bEoMuQq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BB11F000E9;
	Sat, 18 Jul 2026 09:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784365668;
	bh=nYkxTwAS5bKW3I7rAhgCy9zpVSs1G0EhoUAQHVDPfyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bEoMuQq3XgOUiSuKKSF+Nf6LYnN/nDKhysLwHxGjjGBldO9AcdkO+H0pGm4WHB9jH
	 NeebLYGnOLMRDWJY50UGbZ0z159BLGRk95puoJWzXwP/P+UbX7kEUh/dolrAdUDes8
	 jHrP6MLyIcOx48bi18u3lPPtcVbgsqbRiBV911dk=
Date: Sat, 18 Jul 2026 11:06:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Metehan =?iso-8859-1?Q?G=FCnen?= <metehangnen@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 3/4] Documentation/misc-devices: add gxfp5130.rst
Message-ID: <2026071814-online-nicotine-bea8@gregkh>
References: <20260718081431.25456-1-metehangnen@gmail.com>
 <20260718081431.25456-4-metehangnen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260718081431.25456-4-metehangnen@gmail.com>

On Sat, Jul 18, 2026 at 11:14:30AM +0300, Metehan Günen wrote:
> Document the Goodix GXFP5130 eSPI fingerprint sensor driver:
> hardware interface (MMIO mailbox + 3 GPIOs), userspace ABI
> (open/write/read/poll/ioctl), sysfs attribute, debugfs trace interface,
> and the table of supported laptop models.

sysfs documentation goes in Documentation/ABI please.
