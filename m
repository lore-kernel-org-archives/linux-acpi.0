Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225BF4F30F3;
	Tue,  8 Sep 2026 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862614; cv=none; b=SianPTcW4Gq0ixsPpwTLButl3y/aFmGmQi/dgyo70O6JdVDoVibh7b8hAsSvQ8EZOywnaU7YHA3AM9aMe37CMQIx5y3QWULC/WbZdUQ0FCsBX6pHIRZ3aV2obEqCWaspGxhkiaMh/87yFAru7gDfKwpnPXwSKyIMnnNhkayF2fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862614; c=relaxed/simple;
	bh=IfAxMFmYNThWXFNG9Cr6lgmUGzPWDhoOAlvjNsjACFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqzPaTMZ92BSdOEy6T5FpfroLPHH7J8EeaB2qukK0yO8ibDXGJF0GauzmM8TcJ2WVCjgrtBguYPmXWxtrNTMs0QqgevVFrMCCmBB9gdyg33Q3ontIcyvcOHHVssIzrw34gHeujmssh7f36eUcnEo/O8K8Wa3X7tsEp9XV3Xj3oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDMKeL4c; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDMKeL4c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788862613; x=1820398613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IfAxMFmYNThWXFNG9Cr6lgmUGzPWDhoOAlvjNsjACFQ=;
  b=IDMKeL4cdHeai3cOnAYuYOvrHE3K8xfBja3cGAlYCFmYOkP0tvhe7xZH
   uxy1g4mRYitn2caIWYEL4d5tbI0xz6xoRyJsOgjK+jI/zKC9I1hp7AF+7
   jKF+AaXESdfqbKC3xdDOvjlwjlddSQ+mUI+x2yzfaknGKPB3ktuuvkAiS
   DfJjZ6+rxHP0MlwagXRpYe4nD7ejYlzN55R7EUfEKvoa0+A7FSKZyw7vS
   sQxUXgezlflMw6uBrFFf8PMeQwRy/lnk92I5RIAXDEAfvQaBGZD8heJED
   ith+XrcCGVpVUGHppfHPFKDd11AnNhoWOd/vX5tXAvnH1irsiL4aV3VL0
   w==;
X-CSE-ConnectionGUID: TodSKEc+T+CXzy8IyRsZOQ==
X-CSE-MsgGUID: mHJMLfdaQsmFyT4Am+wCRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="88409745"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="88409745"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:16:52 -0700
X-CSE-ConnectionGUID: tUA0IbI+T7mtVklRYUqenA==
X-CSE-MsgGUID: /AZ3/qTYRC2xAW09zrRwLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="267277176"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.92])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:16:51 -0700
Date: Tue, 8 Sep 2026 13:16:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] ACPI: glue: Rework the success message in
 acpi_device_notify()
Message-ID: <ap_gkdkbGB66d5cv@ashevche-desk.local>
References: <12989369.O9o76ZdvQC@rafael.j.wysocki>
 <2448150.ElGaqSPkdT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2448150.ElGaqSPkdT@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 06, 2026 at 05:54:10PM +0200, Rafael J. Wysocki wrote:

> Using an ACPI handle in the acpi_device_notify() success message is
> somewhat misleading because the "physical" device is not bound to an
> ACPI namespace object in that function, but to an ACPI device object
> attached to it.  Moreover, the message is outright confusing for the
> "physical" devices bound to ACPI devices without ACPI namespace
> objects (for example, fixed event buttons).
> 
> Address this by turning that message into a dev_dbg() one printed for
> the "physical" device and mentioning the name of the ACPI companion.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


