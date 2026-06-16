Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BEC3B14B4;
	Tue, 16 Jun 2026 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607854; cv=none; b=iVexEDh4vqW7T/SCUpJ3jYOsCWIvBWB1RuC9o8MZa0U22+X9RnGJoLdrZPK0cHZkCk4OOgeC7Lro4mXNqN2OXZQn+f961D2T8MtpFOIo1B2EfJlv01ai352+mK9swtSa+yH0KESA8CRZ5IkZd6RenxfaTvMSMMeACB0RgaWF7Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607854; c=relaxed/simple;
	bh=7td9oyVqq4KVwcA91yxIBjG/9UjL2QNndvtDwPnUyeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEfPOwtUBCntuIcFtv+IQTeEfw+Ai3RaIilD8U/rphGFX5yGJWHNBoZUc1Ic1fyh8t1eD3Uqw15HACCqMR09w9A82Q//48p5tnzi8QtpBU3JGzT9l1Bw/5zmIxAioaQwRDwC2zym62bQLoESG5Mi4Z/P2/HrPZ14dU6aBQmSQQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fMYUu00M; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMYUu00M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781607853; x=1813143853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7td9oyVqq4KVwcA91yxIBjG/9UjL2QNndvtDwPnUyeI=;
  b=fMYUu00MVvmdspJL0/XnXzs9uqTCyYxCYXJzz9HGnHybyilVW48uLiB/
   RLPc6MedU85wmXwZtO0pqm/fw6wE9FSLUwWZRgJfRmwCcYoPfRNxBnp4r
   6Mt4MGfWEd9avGyV6g9fUOHiRQQHlUJ3+UOKwMDp/W+h4ssY8ZC/7WAxG
   O0TFfLShNTOTBM4d/+LAajg97sycmPk0hDRaC6AMSLN88yhFHG0iYKD1e
   LKn9yXDVbckpv59QoQPsNVVoHG/RHe+l0vUDSiSY3B7N397LewIlu6YQJ
   RVw12JzdZrRc/2Ec3e5ilf7vK0IkoJvr7VsGa/lp9oc9PsuCxX4/P5smu
   A==;
X-CSE-ConnectionGUID: XzVGZkgaSZmL7CDl/rT92A==
X-CSE-MsgGUID: gO3V0ebRS9mkqmHb9mm8tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82412916"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82412916"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 04:04:12 -0700
X-CSE-ConnectionGUID: NIAbqJzIR0eT+y3nlewToQ==
X-CSE-MsgGUID: EUoUokVTRvO40ktpl6ZVvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="251661719"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 04:04:07 -0700
Date: Tue, 16 Jun 2026 14:04:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marco Scardovi <scardracs@disroot.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add quirk for ASUS ROG Strix G614 series
Message-ID: <ajEtpY101OpZdtaF@ashevche-desk.local>
References: <20260616090824.5967-1-scardracs@disroot.org>
 <ajEeLL5u3hf7lvWD@ashevche-desk.local>
 <20260616102451.GC2990@black.igk.intel.com>
 <KW1oy3-UQRW73tAAP5-cWQ@disroot.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KW1oy3-UQRW73tAAP5-cWQ@disroot.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 12:58:31PM +0200, Marco Scardovi wrote:
> On Tue, Jun 16, 2026 at 12:24:51 +0200, Mika Westerberg wrote:
> > On Tue, Jun 16, 2026 at 12:58:04PM +0300, Andy Shevchenko wrote:
> > > Mika, do you see any problems with disabled (deferred?) interrupt for
> > > this type of event? I think it might break the suspend-resume (on
> > > touchpad event). Also do you remember if we ever had touchpad event to
> > > be ActiveBoth?
> > 
> > For starters, why this is ACPI event in the first place? The AML is not
> > supposed to use the touchpad.
> > 
> > Touchpad should be using just regular GpioInt(). Does it still work after
> > this patch? If yes then I think this is definitely okay.
> 
> Yes, the touchpad continues to work perfectly after this patch (even the
> suspend/resume you asked about).
> 
> The touchpad itself is initialized and driven by the i2c-hid driver using a 
> standard GpioInt() resource defined in the touchpad device's _CRS method. 
> The ACPI event handler (pin 21) registered under the GPIO controller's _AEI 
> is distinct from this.
> 
> The DMI quirk (.no_edge_events_on_boot = true) only prevents the initial 
> boot-time trigger of this ACPI event handler when the line is asserted low 
> during initialization. It does not prevent the touchpad driver from 
> requesting and receiving its interrupts.
> 
> Furthermore, unlike using the "gpiolib_acpi.ignore_interrupt=AMDI0030:00@21" 
> workaround (which would completely disable the ACPI handler), this patch still 
> keeps the ACPI event handler registered. If any edge events occur on this pin 
> post-boot (for example, if the BIOS needs to toggle touchpad states or track 
> device status), the handler will still run normally, avoiding any potential 
> breakage of runtime ACPI functionality.

Okay, perhaps this all needs to be elaborated and summarized in the commit message.

> Sidenote
> Personally I'd wait for Mario for further info: after all it's him the
> maintainer for AMD side and surely knows more than me.

Sure, I am with you on this.

-- 
With Best Regards,
Andy Shevchenko


