Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52FF331EBB;
	Tue, 25 Aug 2026 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659665; cv=none; b=JSDy5g+ihOtwOdPYefs2opIXy685h8XUphfA19ngKfjL50Rh4XXPB5NRYJxn7U89yLOmbxTZxdg5yo4zZ1PkrIhh97R5CC0P03DHQDIZdzoH7qluqfZjwITW4C7TeJ07GV9zwwWvBxCNgBARfGBLXYzd/pTCxCfOqoMhtDyZYyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659665; c=relaxed/simple;
	bh=FpXJLOnjCg4pDN0knSp9lYxnhTUVgLVUjMapNt5oa38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBPV5xtktFE4wieZQ3a4I5zA4NSsTVIBf1j+6VnXV1XIvw+ezLGcyprLzCAKFgj82i3RSsmm6ghR2lvibVChcEx5qx11+vgVYeoqGcVEAVAf7+l1sczKcUVedEcs3XsUBFWb4L/I6NGX58zva1epWckNVYL4+9rlRNLQnjyB9z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d4lm1DhX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4lm1DhX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787659664; x=1819195664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FpXJLOnjCg4pDN0knSp9lYxnhTUVgLVUjMapNt5oa38=;
  b=d4lm1DhX9qJOui9ZQmW153GHudXTKcSkvYToszgc6euogyBUo35xCaWv
   iaprThAy/ma/4kayRXB3hZWkxAnUu2XoDuMU4dKJdTzKyNCx5pLUJlatM
   ViRkO4C2Cx0C+n5xq/lAiiv09YYWbbTij7Rwoy6FprGhH+swoxjaTLrJO
   a6Xi1UeIAeKirq0vEtj05GpLAY26QP0y+13+/8o3F7avg2eUkGHTBWeZy
   evd5p8EMQR87Je5ZnytiH7qAufCgodCkKGbZM6hkKct7umTFB3OW1InNy
   V5Q/edqXr67yiu3F96xu5XAnTMQYX08ZtRf9U3pcCIVLiK3XsnWGNEbXE
   w==;
X-CSE-ConnectionGUID: 9ZuG3QAYSEGqgbfhAniq2Q==
X-CSE-MsgGUID: GgvkZDVBRCahvycKB4TCcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87888696"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="87888696"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 05:07:44 -0700
X-CSE-ConnectionGUID: /5L24Rc4TJ2RPNC8xzskgQ==
X-CSE-MsgGUID: m/zcJPpCRuyVmHg1FJwrvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="269216424"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.50])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 05:07:41 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 534A6121BE0;
	Tue, 25 Aug 2026 15:07:52 +0300 (EEST)
Date: Tue, 25 Aug 2026 15:07:52 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ACPI: Support __free() from cleanup.h for ACPI
 objects
Message-ID: <ao2FmNRFjSJVxhrL@kekkonen.localdomain>
References: <20260824211338.3583976-1-sakari.ailus@linux.intel.com>
 <20260824211338.3583976-4-sakari.ailus@linux.intel.com>
 <CAJZ5v0ieb2FcANOt0MRMsTrwtbLiUF48W_c=3z3OpNH92d=7vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ieb2FcANOt0MRMsTrwtbLiUF48W_c=3z3OpNH92d=7vg@mail.gmail.com>

Hi Rafael,

On Tue, Aug 25, 2026 at 01:51:18PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Mon, Aug 24, 2026 at 11:13 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Use DEFINE_FREE() to allow ACPI objects to be released automatically.
> 
> But at least some of them are allocated by ACPICA functions like
> acpi_evaluate_object() and so they have no proper constructors.

You could still assign the return buffer to a local variable. It's not
ideal API-wise though.

I'm not quite sure what was the point you wanted to make but I reckon this
wasn't an ack. :-)

-- 
Regards,

Sakari Ailus
