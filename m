Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D63B39A7F3;
	Tue, 24 Feb 2026 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771939067; cv=none; b=Wvtr+1yj2LRsWdw7r6obTFPZW2VRP+H/GKkyBMqFGwHckAOiWChiOg+SIIje3KfU9Jkgx9pEP8gJJqL1a/IqjtOT4MCuFHBfgxaTdj3xTItlz1zN0doPuvjGGJqthWF24pgtwowMgaks+6e2HLFt3OxmIlQ9OSdBMqBFihoamXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771939067; c=relaxed/simple;
	bh=bMplMu0bSfA1J+PGWnsh3jq8OpjOPRk/mfhNW1Mx6iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gk2yWikzQa/kLW4qN8DtLCCDPbzrwY3B4yJdwR3/8or7YydsD3/oqqn6Yy2a5nSl72mUf5jicfkCor318Kz+D7fvTVEb/5ofIm5MMkHOfkYnbyB9jqwrZ6B2Kvm0H19irwA5DnGh/EwMcAkXWfb7D8HkAVlHWGABZJywLvQaMC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HkGE3TPR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HkGE3TPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A25AC116D0;
	Tue, 24 Feb 2026 13:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771939066;
	bh=bMplMu0bSfA1J+PGWnsh3jq8OpjOPRk/mfhNW1Mx6iQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HkGE3TPR7yDq5RXbs1npyj4X6mNWNg+ziC61FERYa/t2yQsv/NTX7BXt0JQQKoH1d
	 cSKBpot3Swjg+Cv20MC+AOovJ40j+FrbmS4LiJVyuwPgkUawszOFNI3jGAJVUn4u4d
	 s4OuMnxZ7V+H1HfMyzL+yLr3i8zaRKdKhz2mBhBM=
Date: Tue, 24 Feb 2026 05:17:43 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 1/3] driver core: Split device data types to
 device/types.h
Message-ID: <2026022436-scrambled-mumbling-59a3@gregkh>
References: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>
 <20260223204412.3298508-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gS6kyCOmwL-9JYiaxCDVubtBoK6Rb5NSgHD1GwkGoCRA@mail.gmail.com>
 <aZ1p4lgioFlxhFr_@smile.fi.intel.com>
 <CAJZ5v0hUwCFKH3f6pCW1idquyJ-93wtXzO70tq6D+ruU17+oGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hUwCFKH3f6pCW1idquyJ-93wtXzO70tq6D+ruU17+oGw@mail.gmail.com>

On Tue, Feb 24, 2026 at 01:21:10PM +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 24, 2026 at 10:05 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Feb 23, 2026 at 09:53:17PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Feb 23, 2026 at 9:44 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > device.h is a huge header which is hard to follow and easy to miss
> > > > something. Improve that by splitting device data types to device/types.h.
> > > >
> > > > In particular this helps to speedup the build of the code that includes
> > > > device.h solely for a device data types.
> > > >
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > But why do you want to move the struct device definition out of device.h?
> >
> > Because it's a data type, and we have many drivers that may require it
> > (embed the struct device), but no device.h API is called directly —
> > only via a certain framework).
> >
> > device.h also includes many unrelated headers in such a case.
> 
> Why is this a problem?
> 
> Could those headers be moved to different header files instead?
> 
> device.h is mostly about the struct device definition and the other
> stuff in it is more or less additional.  Why do you want to make it
> the other way around?

I agree, this feels wrong.
