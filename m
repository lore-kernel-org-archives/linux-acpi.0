Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4C428C869;
	Thu, 11 Jun 2026 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212345; cv=none; b=qxHCyVD+dBJ+emnXhCyLPrMjTJRAGO+9LuudWS9hTEspU34JtpNxY2Qsn4YxrdKQEUt7d6K/lHDymvFUIQVGnNzZmFY9uGlIVI7w9hujNHV5nkYJ208xrw1MicAefA+IEhp7ONlg38Whx1DbL5ksqH7IhqBQzyAz00c+caHdiPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212345; c=relaxed/simple;
	bh=kP8Qi+amsO8N5NNJEdE+YKvBqLHsXZS7QPCs1S/NfUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViuuwzBsnWZ7GLIUb8tGHRSZ2/FEQYD7xczAlFHY1U9Q1eWe6eQpxpxb/2Vn1r+BUdhTJfwXKenpKAzac8qgS56z+5p50nYrlGGIF8VdLay4qsb0mQK4rbqjnXj1kHAOlUHeo3H0zudh1z2aBMo0QbK3YXzEnPE9fIORoj3cq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEYuZwUV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEYuZwUV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781212343; x=1812748343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kP8Qi+amsO8N5NNJEdE+YKvBqLHsXZS7QPCs1S/NfUY=;
  b=lEYuZwUVqZo0YHbs4D2Ewd7OUjugIqJE3/iXjHmcroNlgWIS3pMRr5T3
   MhJePXmRd3V6YSHn06ytmxGbH2FQPZfG/KmwstL5SHK6kviWk2CbaSW1s
   oN53cIecAdQBnPfKSsAPJPNs+QUX28f2mmbcDecy3Bp2iwnBpvfEcdAAo
   BpRd0GRfkPU1h3g2vz2Byt+sV+LYpNu+D3DYf20+YDQP1tZq+s65z4Jqc
   OfNamCv41Ehl5Hez++eRS+Eu0nkeYHg05lY3ExE4On+T2uW8CLJEnEls9
   qlIkJ44P7HTY1nPh4bKK99RyrB+Y5/WyHA12NN1BhEI5EXTBGvWH5Qdze
   w==;
X-CSE-ConnectionGUID: QUiHGU+TSsyW03tgaAckYA==
X-CSE-MsgGUID: uEv47WCUTbGVMI58pwV8lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93528091"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="93528091"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 14:12:23 -0700
X-CSE-ConnectionGUID: IEN1J6OPSBOh+t+x5vH6Yg==
X-CSE-MsgGUID: H+B3wCG4TJywOrJjeK+zWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="284702784"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 14:12:21 -0700
Date: Fri, 12 Jun 2026 00:12:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Xu Yang <xu.yang_2@nxp.com>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v4 2/3] device property: Refactor to use RAII approach
Message-ID: <aisksqCUWUBGV2lg@ashevche-desk.local>
References: <20260611203537.1786399-1-andriy.shevchenko@linux.intel.com>
 <20260611203537.1786399-3-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jPkVr9=6HZ2gbCTtcQjmrH+3yZaiXi5jfkfD8aLzOPug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jPkVr9=6HZ2gbCTtcQjmrH+3yZaiXi5jfkfD8aLzOPug@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 10:46:31PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 11, 2026 at 10:35 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > In a couple of functions code can be made cleaner with help of
> > __free() macro. Refactor these to use RAII approach.

...

> >  fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
> >                                struct fwnode_handle *prev)
> >  {
> > -       struct fwnode_handle *ep, *port_parent = NULL;
> >         const struct fwnode_handle *parent;
> > +       struct fwnode_handle *port_parent __free(fwnode_handle) = NULL;
> 
> The thing on the right-hand side of the assignment should be a
> constructor, shouldn't it?

Nope. It's a recommendation to do a such, but in this case it's hard to achieve
(since the constructor is inside the conditional scope) and actually is not needed
as we don't mix up with other RAII calls, such a guard()().

-- 
With Best Regards,
Andy Shevchenko


