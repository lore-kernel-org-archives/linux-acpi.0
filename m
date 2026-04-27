Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD4F399015;
	Mon, 27 Apr 2026 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278851; cv=none; b=CjjWgELirpnix1fMCCfppABTIGGrXEYClpp6MK/teVSKizoSSYQ9Df+hrgdFY+bbxwbldbXfPI/9cRBygSB2YQZBacjaXDvoMsXJDHAC1kYooBUmocggSrETIdqHTyt+txEYuTuNGUv8eDiAOSaN7gDgXicXTvzJ3g2c+CQih+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278851; c=relaxed/simple;
	bh=e5T1gzDV/h9KDqYH/B/WVPnQVc+06pj0No4KXliZnUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVQ9ZmUwpgl55r/281M6hTxORVGuiD+swAnbtpObstHjoFWpwyiaAsMuHRrp6Px9tiFkh7X3xwuw8V+SQIxRMe5iQ9MtKAfyE83hg5/0p6bBZjxQbIVHlsMYjPsUgTd0mSMCjqReaRSv8CJuBrbDLXX+FdQfNkosSp08elb8yJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ko+QNRwK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ko+QNRwK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777278851; x=1808814851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=e5T1gzDV/h9KDqYH/B/WVPnQVc+06pj0No4KXliZnUI=;
  b=ko+QNRwKOK/719QFmYvo3Sm/5qBXaz+HdDCeDkGulOgrDFhwZoP1MYh4
   v1gf5/TNvIsNnzm76NBm0wL3ZDzcsP/UGBe1LjWvz2PbV6k1meGccgc3P
   t6pgJ8F+nYzyI/Dpz4VW0NRWCfppJBh+vGOapHjH2mWSu+Nep3ZryZL0h
   NKsowkbbryMbxm86I1sISgeq7Ssu5nyX+LC75a+5aGIkvijgj7CGPvrUa
   zreEB2qRwZcz1BDk3Jln+28q8a6tfoCsP/VZ13XRu6DePFcZ//Qf6BJh6
   hCW50C2a7Gi0wdyeYYSFd/6sZyVDENqifd2xp5KFhqEnidLY5KX4e8aXx
   A==;
X-CSE-ConnectionGUID: gLPwRxuxQ1SL4oTkuRmk4g==
X-CSE-MsgGUID: vVdtRfwZR2eU8ej6Ty1LvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="77865533"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="77865533"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:34:10 -0700
X-CSE-ConnectionGUID: nj/PXrcVRr+8EQHO5gxkyA==
X-CSE-MsgGUID: syc/kzADSCqo6oK2ci16Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="229255525"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:34:07 -0700
Date: Mon, 27 Apr 2026 11:34:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] software node: provide wrappers around kobject_get/put()
Message-ID: <ae8ffTttF5Ffx7aS@ashevche-desk.local>
References: <20260424124250.92890-1-bartosz.golaszewski@oss.qualcomm.com>
 <aetxEcjE8wD4-ZyV@ashevche-desk.local>
 <CAMRc=Mem3m8JZXafL9xrUvWZWuFaCofkNEdVYLNMgC+3N0i21g@mail.gmail.com>
 <aeuNEYymSicUcMyZ@ashevche-desk.local>
 <CAMRc=Mc-Tk7fqZT=JinL8+01YdTGJq-LciZgnnGkaNEXa8Db_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mc-Tk7fqZT=JinL8+01YdTGJq-LciZgnnGkaNEXa8Db_Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 10:15:54AM +0200, Bartosz Golaszewski wrote:
> On Fri, Apr 24, 2026 at 5:32 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > should also work. And here I referred to the fact that we already have a kobject
> > instance available. Yes, my counter example is just to reveal inconsistency,
> > I kinda agree that using swnode specific API might be clearer approach.
> 
> Let's do kobject_name() -> swnode_name() separately?

OK.

-- 
With Best Regards,
Andy Shevchenko


