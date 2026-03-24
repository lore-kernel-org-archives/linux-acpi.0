Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084493F9F28;
	Tue, 24 Mar 2026 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355462; cv=none; b=sNF9O0JH0Gl3HDmm8VNG32lYR+NujL02oEzJC0/I9+IhemfSOc5Be8g9yj9gNiUxcq2MWjC8E1/RMqT8wd0SLxiPY7J+NJePu8m0Zf+b13EVS2RSOEcXCb2f7AJTbheo0ICtDZ8c7dwxGFys8mph/KdilzDggLCsvupPmLv9lOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355462; c=relaxed/simple;
	bh=zMO1+9mbs7EoV8l2A6BMnY27sQegLkbm4+N4wUJDzIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abEfMUuCuCd3XQT6Wa0FY02qLS4TyfxMlSC86lgHjc13NHnirODd6tZkluH/xrF5AcyHE3QvUd0jPz7E43PDcQy+OsStkMedn+kMbQ8tF75arpIIUXeThyAdFfVdqbsq+6501cQrHlcfI+SnCPX/FgQJ9NRpXEu73uNg0FtMu10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4ESjIiG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4ESjIiG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774355461; x=1805891461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zMO1+9mbs7EoV8l2A6BMnY27sQegLkbm4+N4wUJDzIQ=;
  b=P4ESjIiGl6OcMNig0ue4h3nztAJDr9DJyVC9V/dMxQbXwfxiyQvmdrV2
   GVIf+42ypk+e3ekApHESHmPOltHiTGVDPOsIscYkEEARxQoWsT556xiCq
   ijRtpcl+gzf2yk2w8BMu/t6ouT/2qEDMvha7yK7i1GfPFEV+VPqnPzq9E
   +x7mCMHfdOwzswyZEskLNz2+EwDQ3E2mxOP0k7ScudXe2n3Hb5viVw+4U
   YcptJefUMw8dcwpy76Of5XWRhZCNe5L9eT9KpD4W6x6EvPcuDgv0XOmNp
   6nwdnLY7+m/rAdKedowcvk9TPc5Wlk1os5/5Hi4dhUtd8tBpofz81Seu+
   g==;
X-CSE-ConnectionGUID: bHF0Ix38R+if2gBToR2vrA==
X-CSE-MsgGUID: quDZS1UrSyWQjcybofOIZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86443199"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86443199"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 05:31:00 -0700
X-CSE-ConnectionGUID: XJ3MSu5bRki0X3r5PcHnbg==
X-CSE-MsgGUID: 1uynBQlAQSGKSdEW4lsSyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224340401"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 05:30:57 -0700
Date: Tue, 24 Mar 2026 14:30:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH 2/4] software node: allow passing reference args to
 PROPERTY_ENTRY_REF
Message-ID: <acKD_vzk_8bX17ZT@ashevche-desk.local>
References: <20260323-property-gpio-fix-v1-0-9cb46e5fe7df@gmail.com>
 <20260323-property-gpio-fix-v1-2-9cb46e5fe7df@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-property-gpio-fix-v1-2-9cb46e5fe7df@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 23, 2026 at 05:39:38PM -0700, Dmitry Torokhov wrote:
> When dynamically creating software nodes and properties for subsequent
> use with software_node_register() current implementation of
> PROPERTY_ENTRY_REF is not suitable because it creates a temporary
> instance of struct software_node_ref_args on stack which will later
> disappear, and software_node_register() only does shallow copy of
> properties.

Isn't that the problem and we should take into account how to dup the reference
inside property core?

> Fix this by allowing to pass address of reference arguments structure
> directly into PROPERTY_ENTRY_REF(), so that caller can manage lifetime
> of the object properly.

-- 
With Best Regards,
Andy Shevchenko


