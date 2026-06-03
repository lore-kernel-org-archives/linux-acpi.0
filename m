Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A86388E75;
	Wed,  3 Jun 2026 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485173; cv=none; b=HHkAXESMjt2boQAQDABd1t6tR96c20F7Kp7ckyZTnftKFLl3kJDqiJPBtvAWx4wmCYtEJir2jAUTP+31FKkCqm6qR7UkZQRm10TKDhtqHenlgIGJqwMXky5HW7JCWKeKoIsR1ms6cD6DaJXqW5vqJL+DJjPcRWzd0uhHrz81vms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485173; c=relaxed/simple;
	bh=IUz9/vmGK46A2+1syLqel7njQrU1BNMKYyMf8FXc4Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j55Rc9HRIGFwDU0yY0iHZxpowYiJb3nzv2YtDMlPZI7Cqij/wDxeJX2e0yy8XQZceoiBejdK458gWGGtZbHgmNpE5EwqqhzS/ZidUFeeC9sHA2LSEwU+O0vef56eowINC8ZVcN2EsTb1P4B0SjJPW7JYUeqfAnwei5cEa/qQ/gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0qJtWDq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0qJtWDq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780485171; x=1812021171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IUz9/vmGK46A2+1syLqel7njQrU1BNMKYyMf8FXc4Zg=;
  b=W0qJtWDqz6kNyemUVW3d3njrz1oJFa4twoJkEVz9sgqNxF3PwR/ZITsk
   D4eDsP9gPS7l65hX5X7XrwE9xlGIGrlb4eKuRK+Pq7URiPt2/NbGPvJrv
   e22FpBwTVQLnOlCzDv+TS06BtbxM6j426vG5lHf6dQntYeESB8kCTMWOv
   NvbylCfBVYTBQ9OswBwbCyLJF5PL0rJUxz1qbWWlCKGf/xgt0WHG5qRN3
   /2xEKL3+/zpNu8pVa3UnpEN4QSbTHCMOM3DfxIcO3T2rJ3MqVHX1gqTeW
   9dfcq4hG/csBPLyvrglZja2nGp0TkbSiCFg0ZvR72r4dzp0BZQcn0wfZw
   w==;
X-CSE-ConnectionGUID: 3JFRpU4RQouJnZuT6jRDgQ==
X-CSE-MsgGUID: pCwxjiWNSPSUsTcOjqgfzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="84915104"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="84915104"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:12:51 -0700
X-CSE-ConnectionGUID: wVI1fKryR+imYRoHPZzDmA==
X-CSE-MsgGUID: afyDuj5ZRYyELU+b8Vaf/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="249275249"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:12:49 -0700
Date: Wed, 3 Jun 2026 14:12:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Hans de Goede <hansg@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject: Re: [PATCH v1 06/17] ACPI: HED: Switch over to devres-based resource
 management
Message-ID: <aiAML9y6uhROqrbs@ashevche-desk.local>
References: <4739447.LvFx2qVVIh@rafael.j.wysocki>
 <7950702.EvYhyI6sBW@rafael.j.wysocki>
 <ah9UyXwsLAjIJEff@ashevche-desk.local>
 <CAJZ5v0hX_UCzmEuGYT6mhTf-L=vzN7dgoG_9FZw-Ccr=_Fo+5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hX_UCzmEuGYT6mhTf-L=vzN7dgoG_9FZw-Ccr=_Fo+5w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 12:51:20PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 3, 2026 at 12:10 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, May 21, 2026 at 04:04:03PM +0200, Rafael J. Wysocki wrote:

...

> > >  static void acpi_hed_remove(struct platform_device *pdev)
> > >  {
> > > -     struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> > > -
> > >       hed_present = false;
> > > -     acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> > > -                                    acpi_hed_notify);
> > >  }
> >
> > devm will be cleaned after this, right?
> 
> Yes.
> 
> > So, here is a window that if one tries
> > to unbind device from the driver in one thread and do the opposite in another
> > they will see the flag false while resources are still allocated for the old
> > one. It seems that hed_present should be also devm:ed?
> 
> If this is the same device, both binding and unbinding (including
> devm) take place under its device lock which will serialize all of
> that.
> 
> If they are different devices with different ACPI companions, there's
> no resource conflict.  If they are both valid HEDs (which would be a
> stretch already) and they both trigger a notification exactly at the
> "wrong" time (more stretch), worst-case stuff will be called twice in
> a row via blocking_notifier_call_chain().

Thanks for elaborating. We are good then.

-- 
With Best Regards,
Andy Shevchenko


