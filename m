Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956DF3B42CC;
	Tue,  8 Sep 2026 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862592; cv=none; b=N7F5DYHhPdXTfZB8DwuckxhtAwLA0vG+yyBz2P75lx/gz+JUo/W0xCC0MEbBDiheu0jHxi3pnGzzsgUf0Lz/R/+76kXZwRbWn2wY6vMpevl0zSXjlW1HK3uBU99u2neljZTTrcx5pCYnmv4qizZKIzs9mETSA3hNr5EE5cuTq1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862592; c=relaxed/simple;
	bh=6ZDF6BvFjRrVCmNe1T/nrJwJHX5eyVvY8yrUe5Mpnv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9LqBqMoEYXOGJec7bjTOexjGihlYIbAI2ZG4SQaaD71U+USIIdqL4Oc95J04LABM6aqJi3PiEBW2LHBwbEXTRpg3bCFLwgqBDPs1iwGOKas2/4a7eVSGFJMuM2JbbesTfo53KnCe4YYg8CLSJPQYxEQ7mdy4Y7IBBxEF6E5noo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RokYxy9P; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RokYxy9P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788862590; x=1820398590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ZDF6BvFjRrVCmNe1T/nrJwJHX5eyVvY8yrUe5Mpnv4=;
  b=RokYxy9PkYXmQj3CO2icf8zlxaY/jmtBrlSVFvcwKnr8vQMNoIlxSrwA
   ZvCQMvnjal5xnPdbkgDjr743q355eKWqT5uOfGCKymW67FKOMy+/L2M+/
   ltc8BDUVN49f+rKUJ6fOk7HrV+v63s1R5JurMWfK4s4ENEPcXce0J2xdl
   O4H+fT20OBLzfRtjLho/4WgRBWqOp893QbWfOPCGN6CvS9SwhvRFh24X8
   Hm62Pr3m4RlQksddXiOD5JfOyousADcgCHIs7EObCj0C3EjtcYhhDT/3A
   jFD806vWxvmV1a4/tKDiW7FT0pm9IxFsC4i+/CNt1qI8zk+15KC4CwkdU
   Q==;
X-CSE-ConnectionGUID: 5vcN/jHLRDKSHKF7ZOVcZA==
X-CSE-MsgGUID: /NQEnrhpSYGKrPPOJZfb9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="88409716"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="88409716"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:16:29 -0700
X-CSE-ConnectionGUID: 09hOmw7JR+OwUxFcnAoEMQ==
X-CSE-MsgGUID: YzqNsZEVSh6ELt/OA5ZJNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="267277130"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.92])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:16:28 -0700
Date: Tue, 8 Sep 2026 13:16:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] ACPI: glue: Reduce debug noise from
 acpi_device_notify()
Message-ID: <ap_gelE3wOjHj4pS@ashevche-desk.local>
References: <12989369.O9o76ZdvQC@rafael.j.wysocki>
 <6325978.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6325978.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 06, 2026 at 05:51:23PM +0200, Rafael J. Wysocki wrote:

> When debug is enabled in the ACPI glue code that handles binding
> devices to ACPI companions, acpi_device_notify() produces a lot of
> message noise related to devices that have no ACPI companions.

Indeed, seems better with this patch.

> Reduce that noise by checking the most obvious case, ACPI device
> objects, directly and returning from acpi_device_notify() in that
> case without printing any debug messages.  Also avoid printing a
> debug message when there is no matching ACPI bus type definition for
> the given device, which is the case for the vast majority of devices.
> 
> Additionally, make the debug messages that get printed more informative.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


