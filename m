Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984EE3D6471;
	Tue,  2 Jun 2026 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402541; cv=none; b=NUVv0J+hbK/OQZCq3hnuIISTgT97Q+Uhr+j7qcgX57bmodUYcDqyp49BFVrWXK+YxbYh4Cfx/ydBiRVhXH008dm7g7jWo+8Aj3ZzIjh+fxLVLU5MveT+B3moLgua/6ggMoUV50ZARUpPK1PG54HdqBaOxk2vbbV/3ZFW9O1twhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402541; c=relaxed/simple;
	bh=DALm11u0DP3CuOZchTDgz8esDk71Sl3LZkAYh+SokpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pt6s7aGJyccBnbxQDIPrTOsp1wF2EnGwk39IiqpK7x5FUXd65gXjlXFcpGHbad6ex2HPPLAXsbpE6MHMBgDfNWFd8sT1oLcLKdaaIoNpaodAbKmf0F61zMnjc1ptzhbEECkyPbiF0Q2wQupoQ9+ziVmQyWiI14BTEZUi5nUZXz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5IgM09v; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5IgM09v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780402539; x=1811938539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DALm11u0DP3CuOZchTDgz8esDk71Sl3LZkAYh+SokpM=;
  b=e5IgM09vZ1SjPihLp5VYKUhLMlpDphbKWJiYSnwHM+WoyCIRPBrHz+EZ
   nT2nWmu9w8R1jlTKp6hAdZLBR6FKTRwgUHGAKSdRPqI7yt/QxdZh0aGst
   0uPc0X4fv6ZobL1f/aq/l74mWVfA0fodRpP9v5AlFQbTHv0Pt4OJ+3E5+
   vhPxW7rTgyZZTLaKdqy+XRLyVROEly8UkqM+FTl/Sq9+A8jOEZp0WfkD/
   YRTt4GBeybbji+r/C6eoY6UyjmucPUI2g8GmtW0jZaYaWk2FwgForDfVu
   OSz57L/bmMAAkZ9DM/qnCWawziSWwyzUWoiv1IQqOaZfhXeNy1Pzw4Ifg
   Q==;
X-CSE-ConnectionGUID: hSR7wQmoQjCsJJXCN9IVsA==
X-CSE-MsgGUID: UMSdTBiPSNCcu7JA1EX71w==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="91491714"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="91491714"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 05:15:38 -0700
X-CSE-ConnectionGUID: jdLtT0NPTeKWIIyumi3AFg==
X-CSE-MsgGUID: RPv7fYVBTlqHnepjq+9Xcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="248177461"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 02 Jun 2026 05:15:37 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 001E995; Tue, 02 Jun 2026 14:15:35 +0200 (CEST)
Date: Tue, 2 Jun 2026 14:15:35 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Marco Scardovi <scardracs@disroot.org>
Cc: andriy.shevchenko@linux.intel.com, brgl@kernel.org, linusw@kernel.org,
	linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] gpiolib: acpi: prevent address truncation in
 OperationRegion handler
Message-ID: <20260602121535.GC2990@black.igk.intel.com>
References: <20260602113529.52570-1-scardracs@disroot.org>
 <20260602113529.52570-3-scardracs@disroot.org>
 <20260602114540.GB2990@black.igk.intel.com>
 <vzcrnFOfR861L-H21KjtDQ@disroot.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vzcrnFOfR861L-H21KjtDQ@disroot.org>

Hi,

On Tue, Jun 02, 2026 at 01:59:36PM +0200, Marco Scardovi wrote:
> Hi Mika,
> 
> On Tue, Jun 02, 2026 at 01:45:40PM +0200, Mika Westerberg wrote:
> > How in practice this can be done given that the GPIO resource has only 2
> > bytes for the index?
> 
> The 2-byte limitation is in the GPIO resource descriptor representation of the 
> pin table, not in the ACPI address space handler interface itself.
> 
> The acpi_gpio_adr_space_handler() receives the access offset as a 64-bit 
> acpi_physical_address from ACPICA. This value is generated when AML
> accesses a Field within the GPIO OperationRegion, and it is not constrained
> by the GPIO resource descriptor's pin_table_length.

Yes, but you access it from AML like this:

Field(\_SB.GPI2.GPO2, ByteAcc, NoLock, Preserve)
{
	Connection (GpioIo(Exclusive, PullUp, , , , "\\_SB.GPI2") {7}),
	STAT, 1,           // e.g. Status signal from the device
	Connection (GpioIo (Exclusive, PullUp, , , , "\\_SB.GPI2") {9}),
	RSET, 1            // e.g. Reset signal to the device
}

In other words it still uses GPIO resource descriptor (so 2 bytes per pin),
nothing else is accepted as far as I understand.

The example is here: 

https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#declaring-generalpurposeio-fields
