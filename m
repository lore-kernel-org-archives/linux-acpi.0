Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F93793AD;
	Sun, 19 Jul 2026 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784459457; cv=none; b=kp2q8KlGu+5ETuZG7lVxbN30SQFzp5zpLb9zpxEAC+hs1QjHkFIYfiqVjIzhoTsMtFtQD4petKa5Ghd4hHEhfcBQtYSoxhPuHeemqtLHbc58q08hRnwcQF+/mLYad0ruNx9/lY8FXUYW1C5nAD9VEjFDNGpRNzFoQaEoAapLNYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784459457; c=relaxed/simple;
	bh=mdke71YrFSWPTc8JbgXwOkl7igcZIZUJnHjD+N2sltE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfHiaKQxOh4JF+eyaozyuyPPiBSjdzcVSFwEXb5kw+brcg7/BwjfHeD/8F7zxf5RPDBv+tY9vz0HXm6EX1Ef5/OcdwfBQZjAcY064cC61Tk0JnMgWpf21miC/RjqUG3+yL6WXeka6jyhHNJic4IJjP9ajxtCYtXPBLMZperiarI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AhnV5Fvq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AhnV5Fvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B4F1F000E9;
	Sun, 19 Jul 2026 11:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784459456;
	bh=HAA/fs+rG9K1gxuGkG6lGIZ5IoliVLNRaDMOmOzLaz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AhnV5Fvq4/35ApNQzVYbWqmJNrUbCOEIGSPB/tN72JB7eDOdVsYyIDTqqMobfP5yC
	 wa7DI+d0Us9KFaBr4KMRsnKQokvmZwOg/+4RPfWYeV+SyeWfErMjiCGha6jI5De/zb
	 1/zQ9GVBJtEjb/W9NifEvW9Y3k9t2svaVhzk485I=
Date: Sun, 19 Jul 2026 13:10:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Metehan =?iso-8859-1?Q?G=FCnen?= <metehangnen@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 0/4] drivers/misc: add Goodix GXFP5130 eSPI fingerprint
 sensor driver
Message-ID: <2026071912-bunkbed-confined-cfe8@gregkh>
References: <2026071842-timing-distress-ad5a@gregkh>
 <6a5cac92.b39440a8.65068.278c@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a5cac92.b39440a8.65068.278c@mx.google.com>

On Sun, Jul 19, 2026 at 03:53:06AM -0700, Metehan Günen wrote:
> On Sat, Jul 18, 2026 at 11:05:30AM +0200, Greg KH wrote:
> > Is that the "normal" user/kernel api for these types of sensors?  I
> > thought we had a real api these days, and a vendor one was not generally
> > a good idea as you are just exposing raw hardware design to userspace.
> 
> The GXFP5130 communicates using a vendor-specific MP protocol over the
> eSPI mailbox — it is not USB HID-compliant and does not expose a
> standard fingerprint command set. The libfprint plugin that consumes
> this device speaks the protocol directly and handles enrollment and
> matching entirely in userspace, the same model used by other libfprint
> char-device backends (e.g. goodix-55x4, elan-i2c).
> 
> I am open to alternative approaches. If there is a preferred kernel-side
> abstraction for this class of device I should be targeting instead,
> please point me to it and I will rework the driver accordingly.

Why does it have to be a kernel driver at all?  Can't you just talk to
the device directly from userspace through the spi userspace api
instead?

thanks,

greg k-h
