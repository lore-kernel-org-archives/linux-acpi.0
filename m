Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BDB49A3A1;
	Wed, 16 Sep 2026 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584914; cv=none; b=r142o8+/KHUjeDxNIGmJEVNPUgxR363/QrfwQbAfoqspQ36oTpezxgLkzDsj3W2e7EYjVojd5wCGwgQXZIDalMzOPl57hbbo4EOFsRNoQva3spKubNvWSpjd2KYBeZqdVWEDsrVjMScR8+xpflNiX81MkZLEgs40VdR3pp2zTYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584914; c=relaxed/simple;
	bh=HyuBGHZrxcgQr8bcaEjDiqVkuiqFishZcx9XFFuEwg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7Mu9jC/Wicag9ntTJYmntUZpvAU3qmLwKK4dQxtZOPwCGOgI66iGLU6PcoGuzTmB5NMibnnpiVYvIRl+UQNZUuDVZohU4xpCX9zQJie4j+nr79CjZt48ZQM0p2cuI9jyloo9Y5Wpchc4ISh9s5nqLqodLsm/9UNIS5J0khNcu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eALZNRAd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eALZNRAd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E901F000FF;
	Wed, 16 Sep 2026 18:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789584889;
	bh=UdQ/AAPkYxLe3x9Yuvf2fg7gw/7f+WLQdOzYeGseyZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eALZNRAdzX++m4145qkS34gPh+NypSADn4gjVPDu/igYbnL6Ij865xafKU3yrXXWV
	 cifjOa0cQWOqjHmS1t2/2vg3JICnTGIspHwZLGbdumVRLuzsA0u72dPKwwaJvrzvnK
	 zaDgJ2vgamSFPEMEcOPQByu+22sZg4X4oUxoSlnI=
Date: Wed, 16 Sep 2026 19:52:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Driver Core Development <driver-core@lists.linux.dev>
Subject: Re: [PATCH v2] driver core/ACPI: Introduce companion_bus_register()
Message-ID: <2026091644-shiftless-armchair-a429@gregkh>
References: <6329043.lOV4Wx5bFT@rafael.j.wysocki>
 <CAJZ5v0geju99B56CqAQjKwZcwg7mqXPUxx_a=kQ1KpaKpQztuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0geju99B56CqAQjKwZcwg7mqXPUxx_a=kQ1KpaKpQztuw@mail.gmail.com>

On Wed, Sep 16, 2026 at 08:45:50PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Wed, Sep 9, 2026 at 6:41 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The ACPI bus type does not allow drivers to be registered, so the sysfs
> > attributes related to drivers created for it and its devices are
> > useless, and its drivers/ directory is always empty.  All of that is
> > confusing and wasteful.
> >
> > To allow skipping the creation of those sysfs attributes, introduce a
> > "companion" bus type concept and add a special registration function for
> > registering "companion" bus types, companion_bus_register().
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It's been a while since this was posted, so any feedback would be appreciated.
> 
> In the absence thereof, I'll trust Sashiko that there are no issues
> with it and pick it up.

Looks sane:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
