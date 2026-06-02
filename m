Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172BC2C029D;
	Tue,  2 Jun 2026 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387076; cv=none; b=svCPTJWnXjvGkni+WVWBgh52X/2XllAA4IopZO6h6Na6xKF2C6d4idfJ64PxR7WF/f1OYFLkOnJ0GcdI3jWi7EVHYeZKVeDW1dncM38RAUnDM4VhXx6qjI3uD8rqeuJgqMTGvq05yTDjTcxGI3UYCTg09kXaV8rNgbxzc9GiZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387076; c=relaxed/simple;
	bh=bBKiNNyBzJltkvW3PgKnrj2O7lyxZd1trFgrP36YX1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qy6/o3BLXfXvqztxdZHAtCpEyTdVa/e9deNcwWvXrEpw1UVbrkbnHq5VPzOkwIJwldIT7xNbLBIwUhHQ7ZzdrKlp3XloCrDkYhxYmA3t2SQGEGVMOOK6CUlD6wVUqpG1Pa07U+I2MOKw+FrlkNq6+TNXI2x0mLutbcGGIqWn+Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2aF08p8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2aF08p8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780387075; x=1811923075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bBKiNNyBzJltkvW3PgKnrj2O7lyxZd1trFgrP36YX1g=;
  b=l2aF08p8q0r8oGLw3XjKKKSVrP/Ti0BmhVSqWRio7/i73Q42TzbEQsl1
   RtYk0bpbzmXMmDGFqDdDu1/0jNRuMR9UQ+0nBXqUYsP6i4O47zOnq8uM/
   YQUGPG8cn6hODmeS5NbyRNZX69+A1uu3LVGat/R9qNPrRy5HPqimBpBVK
   mWgfTj31Gal2kHuQa/gnChnUyIcSQP6imDPkAaf1SpoM98A4+r9NoBNa9
   5mZ91EpkhdHLD+gPMr6W4WG8S3i47G7NPbZ0WpeBylpmfHacttP3o7yoe
   Ith/WAcx06PJ20USwfi8rK1YmL8kVqLb+Lzp3VY6bGGp0YfrNX21AxqH3
   A==;
X-CSE-ConnectionGUID: FvPG1bzdS56vpA3RgDskjA==
X-CSE-MsgGUID: 2U8EU18rS7mEfpVmIOTcQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="91851443"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="91851443"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 00:57:54 -0700
X-CSE-ConnectionGUID: 84CDJKt4QuCgWYlI8dEZiw==
X-CSE-MsgGUID: pEMs7etkRPOv3y7vAyLIgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="239666291"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 00:57:52 -0700
Date: Tue, 2 Jun 2026 10:57:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Marco Scardovi <scardracs@disroot.org>,
	Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
Subject: Re: [PATCH v4 2/4] gpiolib: acpi: fix resource leak in OpRegion
Message-ID: <ah6M_vEIREG0w_mV@ashevche-desk.local>
References: <20260531120816.17255-1-scardracs@disroot.org>
 <20260531120816.17255-3-scardracs@disroot.org>
 <20260601121815.GS3102@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601121815.GS3102@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 01, 2026 at 02:18:15PM +0200, Mika Westerberg wrote:
> On Sun, May 31, 2026 at 02:03:09PM +0200, Marco Scardovi wrote:

...

> This is really complex solution to a problem I'm not sure that even exists.

The problem that potentially may have an attack vector is the malicious ACPI tables
(via SSDT overlay, for example). So some of the validations (like pin index in the
pin list) would be somewhat useful.

-- 
With Best Regards,
Andy Shevchenko


