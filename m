Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F19350A05;
	Thu, 26 Mar 2026 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513689; cv=none; b=Rp3O06GGZTk4dwD4+M84LzL36cu0vJra7ghH9JkRNI/v0g1rQJLGIFjMRDjQZkjs6oGGYb3WYCmvTz9nLAlcp9802++hq4VRiSb9ZsK5rnrPMtXe8eGKcc+oJHlJJ/yQUDE+MHRpOdoaR4RzSXH1qWgOkXOlkn8uIMRzyKlHzRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513689; c=relaxed/simple;
	bh=inHJ4dT6ElVj4BE6uqmx4EW+OYoui9+Rb+XGJqS3kQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG9fwe5CGkKwbSyxpRsJy+rSwXPipmORJ9VSiyDZDjjQpgxpGKmQoa8EQyk3T0mmKx+tDAH1z5kDFYr9rk2ziDqprInjmL4T34HkpbmwggwmxBoy+fjsBM9cGrmUmvbVfRVs7tBNG9z4sk4HDnuOXTR+xql9StgOZjjyLxf7k0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzK1sd+F; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzK1sd+F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774513688; x=1806049688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=inHJ4dT6ElVj4BE6uqmx4EW+OYoui9+Rb+XGJqS3kQ0=;
  b=lzK1sd+FZemllMchLp9T/Cub24bCyx79+2Ues93pW+Ey3t00PY84JzNd
   YwG+lRPnqHxs1QKZPhBqi3AnW+T+I487O77Bfkij17vSmhMjqQwuhNZYH
   PpWs+UJbJ94KELmdvdaxWwQX4BhYTxziAodQZNOjqTO+gQZsw9gofqIMc
   0mqP0gvT3twJot18RhhDK669XM+ykEatfreUsFSsZNxsfKSRnXuTIaZhg
   50wRbDgj+Sy1vQ5nJQzA9/ddN8GsfnWzWKE6LBriAHod/ZbSr/IKFvP96
   B1xj4Dm4e81OlknC8N1Smk62R6Qf+DGZTHSkGjAZoeROUUh62grmu0SrU
   w==;
X-CSE-ConnectionGUID: JxcykNArSTOCAjj3rNgV3A==
X-CSE-MsgGUID: qtvMvRrySGaUpB8Nk/HY/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75467479"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="75467479"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:28:08 -0700
X-CSE-ConnectionGUID: NgrkqevTTh6FONhCos6p+A==
X-CSE-MsgGUID: TdwsWJYXTaazMBl8v5vJpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="262854479"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:28:05 -0700
Date: Thu, 26 Mar 2026 10:28:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] software node: allow referencing software nodes by name
Message-ID: <acTuEl39FjgekOxA@ashevche-desk.local>
References: <acIV6xF8mY-8wd5e@google.com>
 <CAMRc=MdJ0U2_ZQ5rP0Vmbv7+-xurf9F+WOwD3LwV=n5Fx33U=Q@mail.gmail.com>
 <acK69OColNT7ViLf@google.com>
 <CAMRc=Mcw66QpjQt4+_JdMq9JiAY28hjzNHa24gfOCCXyie-uRQ@mail.gmail.com>
 <acTtzuGD-K5XvVir@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acTtzuGD-K5XvVir@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 10:27:00AM +0200, Andy Shevchenko wrote:
> On Wed, Mar 25, 2026 at 05:32:06PM +0100, Bartosz Golaszewski wrote:
> > On Tue, Mar 24, 2026 at 8:30 PM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > Please post the reworked version so we can review all the details. My
> > > concern was that it relies on notifier chains to notify when devices
> > > get registered and unregistered, and instead of matching node names you
> > > now need to somehow match device instances and software node instances,
> > > which again likely is done based on some name. This just piles on
> > > complexity where a simpler solution would be sufficient.
> > 
> > I will post it. Hopefully before the end of the week. I want to cover
> > both OF nodes with paz00 as well as ACPI with android tablets. The
> > latter case will have to wait for devices because there's no way to
> > look up an ACPI node by name that I could idenfity (correct me if I'm
> > wrong).
> 
> What do you need from ACPI exactly? The ACPI namespace in the OS is represented
> by set of ACPI handles, each of which is the object pointing out to some object

"...which is the pointer..."
(sorry for the possible confusion)

> in it. Any object in ACPI has a unique path. At any time, after parsing the
> ACPI table(s) into ACPI namespace we may get a handle based on the path.

-- 
With Best Regards,
Andy Shevchenko


