Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C8B3033FB;
	Tue, 18 Aug 2026 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787037318; cv=none; b=ipLJBgZzGffFMm/kh26sgCf+kk0DfJmkDDGe4TcaAJpQ6xPHbjjTFGbrErct/MW7X1C1Lcko8Iq8KdBx11xUHkmJMCSGA6n+i+1xGzFDLZOK6lAzsKqrgjYIyn6J0QG2hjXiDIcGtG3CrlN66owWqSDEo2CtEllxvAXMUyRpZjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787037318; c=relaxed/simple;
	bh=MGaCb2b5SaoM0qVdDeVL0y3QV9RpA+lwoSEDpssw9JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i56o4vbvodhw/Ks00N/uglUOJkH9xf00SEa8HZUqJt3ReINDMpscCSUSOmyRD/e0H46EvUVatcI9HQAFXbfKYjQ8oToXCNH35PbrLkAVOwsjx3o4i5DfG+09yky7PwUoeyzFcim6fTg57rYkUlius4pCmrk/5BjJVjKN0I1HrHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcliKUO4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcliKUO4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787037315; x=1818573315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MGaCb2b5SaoM0qVdDeVL0y3QV9RpA+lwoSEDpssw9JA=;
  b=TcliKUO4TDSRQJA198fdNddLVZxci6UYc1RmRa8o/5UkoWQPMPSYaIWv
   OvxxIDKYfaOzAFu7tStdmLXMBBpROvDEvKEVsm3alt20dH2Xm8Uzn5WmG
   6HsOVnU/9Cp/5SSGaesQBAvIlLZBfCPGIetAKDiJS2r6FtoBHTfhmFyhf
   WAsffl/+Jd4n1BZCvOTLb9TtR/DxbTVDqqIc9wjfoiOr4tZLIOybQXvtf
   0Nh/ElLYK7WgZovKOgm5pW4RRLGAjIlYliPsu20HOqUPWRFow2ToLLbGK
   CPR1atu5Bvp+ek8hxbWybCKXaLdEO3JJDuAIK39MywewGYQEQbAHGAdOL
   A==;
X-CSE-ConnectionGUID: xMCDLghgSMm64oXahP99uQ==
X-CSE-MsgGUID: 9ADgX8VhReieCLtwPM4oqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98675523"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="98675523"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:15:15 -0700
X-CSE-ConnectionGUID: CsapwNuUSoiHldl7q94VWA==
X-CSE-MsgGUID: eU3dG3LcTuuLOqChKKAh9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="262516853"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:15:09 -0700
Date: Tue, 18 Aug 2026 10:15:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/4] driver core, net: handle fw_devlink for
 class devices and PHY packages
Message-ID: <aoQGeg0VGcNZXqXX@ashevche-desk.local>
References: <20260818-submit-phy-package-fwdevlink-v1-v3-0-40a905ea16b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-submit-phy-package-fwdevlink-v1-v3-0-40a905ea16b6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 12:58:56AM -0600, James Hilliard wrote:
> Managed device links normally advance through probe and removal alongside
> a device driver. Driverless class devices are added directly, so their
> links do not currently receive equivalent transitions. A class supplier
> can leave its consumers dormant, while sync-state-only links from a class
> consumer can indefinitely prevent suppliers from receiving sync_state().
> Removal also does not unbind consumers of a class supplier.
> 
> Ethernet PHY packages expose both sides of this problem. A package node
> describes resources shared by member PHYs, but is a container rather than
> a device. fw_devlink preserves that topology and temporarily represents
> those dependencies through the closest device, which for OF MDIO is the
> driverless MDIO bus class device. Its proxy links previously remained
> after the real PHY had probed and kept the package suppliers from reaching
> sync_state().
> 
> Handle the generic class-device lifecycle in the driver core. Put
> driverless class devices into the probing state while device_add()
> publishes them, complete their incoming and outgoing managed links after
> class interfaces run, and apply the corresponding unbind and cleanup
> transitions during device_del(). This supports class devices as either
> suppliers or consumers and keeps descendant firmware links available for
> devices created later. Keep inferred links to probing and registered class
> suppliers out of no-driver fallback paths, and recognize class-backed
> nodes when refreshing dependencies after firmware-tree overlays.
> 
> Keep generic firmware parsing faithful to the described topology. Add a
> helper through which a subsystem can copy a container node's direct
> supplier links onto the firmware node for a real child device, then use it
> from PHY registration before device_add(). The ordinary fw_devlink path
> consequently creates each managed PHY link at the normal
> device-registration stage.
> 
> Finally, defer supplier sync-state callbacks across OF MDIO bus
> registration and child population. This closes the interval between
> completion of the bus class device and installation of the member PHY
> links without adding an MDIO-specific device-link state transition.
> 
> This was found while validating an X-Powers AC300 package whose input
> clock is supplied by PWM. Before the fix, the PWM driver reported that
> sync_state() was pending due to stmmac-0 after the PHY had probed.
> 
> The complete series was tested on an Allwinner H616 board with an X-Powers
> AC300 PHY package. All five package-derived supplier links targeted the
> member PHY and no proxy link remained on the driverless MDIO bus. The PWM
> supplier reached state_synced while continuing to generate the PHY clock.
> These properties remained true after unbinding and rebinding the MAC, and
> the PHY renegotiated a 100 Mbps full-duplex link. Both before and after
> that lifecycle test, 8 MiB transfers in each direction compared correctly
> and 100 consecutive pings completed without loss.
> 
> Validation also included:
> 
>   - a full arm64 defconfig Image and modules build with W=1;
>   - KUnit tests for class supplier/consumer transitions, inferred-link
>     preservation, and fwnode supplier copying and device-link conversion;
>     and
>   - strict per-patch checkpatch and whitespace checks.
> 
> Assisted-by: Codex:gpt-5.6-sol

Seems the commit messages are also copy'n'pasted from AI. Please, make sure
that it's clear, straight to the point and not a saga with unneeded details
and obvious explanations.

-- 
With Best Regards,
Andy Shevchenko


