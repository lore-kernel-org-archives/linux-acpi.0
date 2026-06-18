Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633BF7083C;
	Thu, 18 Jun 2026 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781793344; cv=none; b=Dm0yxq8y53YmCPEz0O6dXuawDF0XsLvY2PgzmtYP1GXVHmNOJ5KvjNQ7kaso3JiAtXoVQ23C1qrzUiRT2qqvEtxz5qL5jMdIzbuGwbbpNDE9NfGFTd+RRnyqiSNc1FkRYM8ulcU1UpSYDsxtRlryz7qpvmtJ4Ak+Ax5QRYo6ufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781793344; c=relaxed/simple;
	bh=kVHfUD93RvfEA7BmVDBVrF/bYpCdo5oI+DYTs0tAtQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjW71Ea+mPtQUXwOaO5ZFq5UqAS9Y0p8IPhCtQCkshQJwJwpdrLJ41WSx5e2z5tEvU2IZFSCWeXoxMdWTOFT/Likz0q6ve3b4dtujbtDJ1k2SS8WB6Giz23Kvo/BIXp22ti2E18EObmkDdgjpC7n+E/mqk6lzeBeVSA8/7PtWoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RmX6SHOQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RmX6SHOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781793342; x=1813329342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kVHfUD93RvfEA7BmVDBVrF/bYpCdo5oI+DYTs0tAtQM=;
  b=RmX6SHOQYLOVqPayZ0rMJlKKb/vcxHqlm7Mlym1Ev6GmDYMEN5lXC0u/
   sle13oUskF+5XjMi3iEW1gA/NldzXbssU8sDKGT6MaFZ+4+bUXSivxnxz
   t0TBD8ecFhwIrlfDjXEu7WCAP7Fz7NlawZWk1VSOSdLfz77AcPeRwqTFq
   I4WaFpSiwC1WfaHD0FAlkqy56yftKe8zqo1Cl4I/zz9kYovFjvaWI15+2
   S8nEPDcs1lnlDU1dcU4hb3mRxRkrsT+R9UpluxtTqg4oefmv49BA6UFln
   u/GKDcYpq3rAcloLY07kMgWCWt9qkTrN+9hfaZfc0mv9MUE9Famsk/Vur
   Q==;
X-CSE-ConnectionGUID: V0gEkznDTdKa4yS1AUdxeA==
X-CSE-MsgGUID: H4ap7M/cQ5KwqSUQhzHZ0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="86307649"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="86307649"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 07:35:42 -0700
X-CSE-ConnectionGUID: 9K9r9iE4SCmtMKo9i0YFGg==
X-CSE-MsgGUID: Z3yArv3LQi+D/Co2Dv2bYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="246008600"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.10])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 07:35:39 -0700
Date: Thu, 18 Jun 2026 17:35:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Basavaraj Natikar <bnatikar@amd.com>
Cc: Marco Scardovi <scardracs@disroot.org>, w_armin@gmx.de, brgl@kernel.org,
	linusw@kernel.org, linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com, westeri@kernel.org
Subject: Re: [PATCH v2 0/1] gpiolib: acpi: Add quirk for ASUS ROG Strix G16
 G614 series
Message-ID: <ajQCOQzWEmNkzCVc@ashevche-desk.local>
References: <0e6ea9d5-68ac-4d18-b40a-25e70216b288@gmx.de>
 <20260617231428.96076-1-scardracs@disroot.org>
 <b259a3a3-0440-4da6-a3bb-d840f5242ce2@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b259a3a3-0440-4da6-a3bb-d840f5242ce2@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 18, 2026 at 06:46:28PM +0530, Basavaraj Natikar wrote:
> On 6/18/2026 4:44 AM, Marco Scardovi wrote:
> > On Wed, Jun 17, 2026 at 10:33 PM, Armin Wolf wrote:

...

> > I have extracted and decompiled the ACPI tables (DSDT and SSDTs) from acpidump.
> > You can find the raw acpidump.out and the decompiled ASL tables in the
> > following Google Drive folder:
> > https://drive.google.com/drive/folders/1aTqLAnUhrTsPdpA8tfOFyRopG3P3DGnc?usp=drive_link
> > 
> > As far as I can see/understand there is no _DSM method defined under the
> > GPIO controller device (AMDI0030) or the \_SB.GPIO scope.
> > 
> > Under the _AEI method (defined in SSDT9 line 188-193), pin 21 (0x15) and
> > pin 24 (0x18) are defined as:
> > 
> > GpioInt (Edge, ActiveBoth, ExclusiveAndWake, PullNone, 0x0000,
> >      "\\_SB.GPIO", 0x00, ResourceConsumer, ,
> >      )
> >      {
> >          0x0015 // Pin 21 (Touchpad attention line)
> >      }
> > 
> > When triggered, they evaluate the _EVT method which calls:
> > Case (0x15)
> > {
> >      \_SB.PCI0.SBRG.HNC0 (0x15, Zero)
> > }
> > 
> > Since Arg1 is Zero, HNC0 executes the Else branch, invoking M009 and ATKM/ADTM,
> > which stalls synchronously for ~36 seconds when executed during the probe path at
> > boot time.
> 
> I traced the _EVT for pin 21 through the dumps:
> 
> _EVT(0x15) → \_SB.PCI0.SBRG.HNC0(0x15, Zero). With Arg1==0 it takes the Else branch:
> M009(), then Notify(^^GPP0.PEGP, 0x81) "Information Change" to the dGPU, then
> ATKM(0xC0)/ADTM().
> 
> So this _AEI event is dGPU/graphics‑related (it notifies PEGP), not the touchpad —
> the earlier "touchpad" characterization is incorrect. The touchpad
> (TPD0, _HID "ASUE1416", _CID "PNP0C50") has its own GpioInt() in its _CRS on a
> different line (pin 0x08, Level/ActiveLow).
> 
> The ~36 s stall is consistent with these synchronous MMIO reads + dGPU notify
> \running in the boot probe path while the GPU isn't ready
> (no explicit Sleep in the path; a trace_method_name on HNC0/M049 would
> confirm the exact blocking access).
> Either way, running this AML synchronously at boot is the firmware issue
> the no_edge_events_on_boot quirk works around.
> 
> Could you update the commit message accordingly — in particular, drop the
> "touchpad" wording, since pin 21's _AEI event is the dGPU notify path, not the touchpad?

Thanks for the details! The crucial and most important question here, is AMD
going to push OEM(s) to fix firmware accordingly?

-- 
With Best Regards,
Andy Shevchenko


