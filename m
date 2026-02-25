Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31734314A6B;
	Wed, 25 Feb 2026 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.69.181.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045999; cv=none; b=HdqqgqsEnHGtUwBfWfFI/YcKMZz+J3fG+p9A9eB9ibmWAhzhzj4d3KxtY+J3HvV8dRGW7ohiY3JpuOixt8S/aedmN0KRlnYSu94mapXIhoZKRwCBFBvBNcmv1mklcKeWAzexoAvSrNt0oHF/Kx41I+8VDFaQpWG6b6pCM9gHYqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045999; c=relaxed/simple;
	bh=gmq/mJR9NAqzg6aC99pwKhL5SvMEOOdfgrmsvy7hN74=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Mime-Version:Content-Type; b=GLp9xjC+9SBW7g83DwZA9ReJcE4kV4x99nvZB4mL2k7IS7OLeJcg+PF0prI8uHrnRPUu/TqdTSukLokD/UJ5sW84RRnqxP1+56rg5JjpBsihdDFNSnBIDc0UEMAOnBmAIoqXB1QnVMVcgNNwHbc7ap5qfp6iTkMQBQjzg7G3OJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isely.net; spf=pass smtp.mailfrom=isely.net; dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b=BDh4bcLS; arc=none smtp.client-ip=192.69.181.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isely.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isely.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b="BDh4bcLS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
	t=1772045996; bh=V/5weU9sjTXr3Lql1/npeTKaNef+eDg6wmZ0VGEadGE=;
	h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
	b=BDh4bcLSy/JgQFt0/zBLvbXj5y/qFHH97027/Mb5Vhv1GCiEJEAjC/kjBl4stZU2d
	 h/vwvalY+Khp7P5GFxnNEXpQjYZGq25EeGsgTod9Kj4nF1OCGZ1uD7zGYnofk8S0I9
	 mI7dGpec7Sq/O4X5OOqk2wdDzvPdjqQQQF6dALqDK1laswWuXr2fYQt7Al/9o
Original-Reply-To: Mike Isely at pobox <isely@pobox.com>
Original-Subject: Re: [PATCH 0/1] software node: Use-after-free fix in
 drivers/base/swnode.c
Author: Mike Isely <isely@isely.net>
Original-cc: mike.isely@cobaltdigital.com,
  Daniel Scally <djrscally@gmail.com>,
  Heikki Krogerus <heikki.krogerus@linux.intel.com>,
  Sakari Ailus <sakari.ailus@linux.intel.com>,
  linux-acpi@vger.kernel.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  Mike Isely at pobox <isely@pobox.com>
Received: from ts4-dock4.isely.net (ts4-dock4.isely.net [::ffff:192.168.23.121])
  (AUTH: PLAIN isely, TLS: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by cnc.isely.net with ESMTPSA
  id 00000000000A0005.00000000699F46AC.000068BE; Wed, 25 Feb 2026 12:59:56 -0600
Date: Wed, 25 Feb 2026 12:59:56 -0600 (CST)
From: Mike Isely <isely@isely.net>
Reply-To: Mike Isely at pobox <isely@pobox.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: mike.isely@cobaltdigital.com,
  Daniel Scally <djrscally@gmail.com>,
  Heikki Krogerus <heikki.krogerus@linux.intel.com>,
  Sakari Ailus <sakari.ailus@linux.intel.com>,
  linux-acpi@vger.kernel.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  Mike Isely at pobox <isely@pobox.com>
Subject: Re: [PATCH 0/1] software node: Use-after-free fix in
 drivers/base/swnode.c
In-Reply-To: <aZ7E7q6vdUHW_Wj6@smile.fi.intel.com>
Message-ID: <04eebe7b-0f88-2122-eeef-568117bb8235@isely.net>
References: <20260224191922.2972974-1-mike.isely@cobaltdigital.com> <aZ7E7q6vdUHW_Wj6@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 25 Feb 2026, Andy Shevchenko wrote:

> On Tue, Feb 24, 2026 at 01:19:21PM -0600, mike.isely@cobaltdigital.com wrote:
> 
> > Correct issue in drivers/base/swnode.c that can lead to use-after-free
> > due to kobject reference counting error, which itself is due to
> > incorrect behavior with the "managed" struct swnode flag in
> > circumstances involving child struct device instances where the parent
> > struct device is managing a struct swnode.
> > 
> > Use-after-free in this case led to an Oops and a subsequent kernel
> > memory leak, but realistically it's kernel heap corruption, so any
> > manner of chaos can result, if left unaddressed.
> > 
> > This was detected in kernel 6.12, verified also in kernel 6.6.  Visual
> > inspection in 6.19.3 source (the latest as of right now) shows the
> 
> The latest is v7.0-rc1 as of time of the topic message.

I actually meant the latest release.  Guess I should have checked the 
latest release candidate on the off-chance that it might have been 
addressed.

> 
> > same issue.  The nearly trivial fix was verified in 6.12.  While this
> > patches against 6.19.3, IMHO this is a candidate for all LTS kernels.
> 
> Thanks for the contribution, usually for a single patch there is no need
> in cover letter. The comment block can handle this (the place after cutter
> '---' line in the message with a patch).

Yeah, a separate cover letter is overkill, but I was just following a 
process here.

  -Mike
   isely@pobox.com

