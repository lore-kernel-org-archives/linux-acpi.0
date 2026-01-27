Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1EB3491D5;
	Tue, 27 Jan 2026 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521797; cv=none; b=RPIfGeCaHknAsX55GSuK9/q0MSJFf0oPT94aixde4icCPlW6xSUJspiffIsjERMh3gp8WHzPg8bMUesZxwzLaYkP8SZrfUZjvc8nfZNbvwforxFsbHhtwesbhdMfkCbpUplZlNSMMVsRGv3DfxyVMdz6aSzR7B5vddos0HSzBfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521797; c=relaxed/simple;
	bh=M+dntcc6sYA+irrxrwpFM1qTzSJ8RSVOJfJn/7W1E90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHfvMCJcJ0LOSzFjctKj9X+Z5C0BSquG3cHcMOOrCYLCsk9D+Iy5LmptWr6CBA6Fu5S9IIx8ILTsxE1aCGrN1QMYJn+4wBWrbHh0GJnvlAM+PzlbIN/HNQZaj6abHVgJqF9tLMlWT0qhleUalyga0KpAL+gzKgmj45rJFtsZy5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mS1kKkdO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mS1kKkdO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769521796; x=1801057796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M+dntcc6sYA+irrxrwpFM1qTzSJ8RSVOJfJn/7W1E90=;
  b=mS1kKkdOdFVRd/D56SEMRqzEuQK7Flm2BunWnIEBjmlHhnnAHu7x7VvI
   tF87Kdr3WvPlC+EnzbEAH/x099+spahFeEMyt3Aca3axljpztQqeuckAU
   TdBvUhQTFbjBv6RDFICNk92iTA7SiNWuIJTIEpVOO2bIHg6UHpUeUeeuu
   uVxOY/BrRm+tQ+T6bg427cBSARxWPpkmTHPINg9uaoWpgZkIVitQU6KkW
   eQ1HhkV3FpzUqeNuQ3OLH6oao+j5xfAzefDCIWBjQtz7UUUq/1sRXt0eV
   IypwDTlpHVgGrXOW5wZ7eQwHLAoV6uaGEw0S7ENZZ6SoY0bl23fO8zuSN
   w==;
X-CSE-ConnectionGUID: pZlaA0WwQ7aGG7y53w50Qg==
X-CSE-MsgGUID: tAYOHCmnTGys5YpVOTjb4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81437888"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="81437888"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 05:49:55 -0800
X-CSE-ConnectionGUID: O3mC/LOUSky0uH6P4wzQMA==
X-CSE-MsgGUID: WohwQGcRQRmvV4OB2swYuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="212841383"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 05:49:53 -0800
Date: Tue, 27 Jan 2026 15:49:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mika Westerberg <westeri@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Subject: Re: [PATCH v2 1/1] gpiolib: acpi: Fix potential out-of-boundary left
 shift
Message-ID: <aXjCfwnnASFZ1Ghh@smile.fi.intel.com>
References: <20260127110824.4020130-1-andriy.shevchenko@linux.intel.com>
 <20260127134300.GK2275908@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127134300.GK2275908@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 02:43:00PM +0100, Mika Westerberg wrote:
> On Tue, Jan 27, 2026 at 12:06:30PM +0100, Andy Shevchenko wrote:
> > GPIO Address Space handler gets a pointer to the in or out value.
> > This value is supposed to be at least 64-bit, but it's not limited
> > to be exactly 64-bit. When ACPI tables are being parsed, for
> > the bigger Connection():s ACPICA creates a Buffer instead of regular
> > Integer object. The Buffer exists as long as Namespace holds
> > the certain Connection(). Hence we can access the necessary bits
> > without worrying. On the other hand, the left shift, used in
> > the code, is limited by 31 (on 32-bit platforms) and otherwise
> > considered to be Undefined Behaviour. Also the code uses only
> > the first 64-bit word for the value, and anything bigger than 63
> > will be also subject to UB. Fix all this by modifying the code
> > to correctly set or clear the respective bit in the bitmap constructed
> > of 64-bit words.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Perfect, thanks!

> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thank you!

Bart, since you picked up the patch in the same lines of code, feel free to
take this one on top (I think it's your gpio/for-current branch).

-- 
With Best Regards,
Andy Shevchenko


