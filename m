Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DC33EC6A8;
	Tue, 25 Aug 2026 12:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659465; cv=none; b=kQm54eskD7cSkcmm1PPd3G3b2fg/fghn5E8ZrRTvaPjB1eScMjw8UEYJD4Pdd/v/4EoshXwdNaF1DyoudD+MLQQB4ps4OPAX4suHRwYigPriX8QN1wNoLmByE4MqJioxZBRSd6prlzRzJY38AWgLVcXxfMdKgXp79dmycZcTcRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659465; c=relaxed/simple;
	bh=RiVHEEoHQ4sp+edZIT3R6nFNScamMbaX/2ar1R0wXIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIT6HYLj3eEr11O0s3OyIfGy5DPpwWHZ9MsQv+gepueZ+bDlq1AaJhGPfg7PGiAH9ZSyiyDfvud3epOnq9hZzSxtT1u/C0PxnpByYUY1suUeTWpHSD9P+s8CtD5a33LrW2GFa/d0wNpn2+KF1quLGdWCT7xGVfLv3ac+X2/cHSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gAOZQPCV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gAOZQPCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787659464; x=1819195464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RiVHEEoHQ4sp+edZIT3R6nFNScamMbaX/2ar1R0wXIM=;
  b=gAOZQPCVWRWzzzjtxv1CqCFiBI7LiI+p/vXlNrpZeZ22HQxa5jHbMIg6
   3qbdofOL6Q/l3s5d0gXN+2vsdFTSD/uPV8PYGTph8TM4r1B6LXH3ZdakQ
   s07rEQ2yAHgtgZrRhNrkZ58xNDKrdvlbH8N9qb/M3NSqtPTGcvICLuyRM
   PO/+zFLY04QUFvnhhtxRzFklXtwbLIVQ28atUV5I0GFJEaLJOp0sgyxX8
   0ctbAG2z54Oh4o/1MglX5wdOLRtVDOIKc4kbF2an0sq9tqBzENUhIwFBq
   b52DKEBpmLNavvcIDfY+QTZVP4AamxUbIYMxsgUUYK8AysQ4QX2clKUFU
   A==;
X-CSE-ConnectionGUID: FnjM0tGdQuy2wcTA9Ub3TA==
X-CSE-MsgGUID: /mv73rQJR9mhDRh/p6MLlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87997433"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="87997433"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 05:04:22 -0700
X-CSE-ConnectionGUID: 75X3uk0MQY69H8K2Pfxuqw==
X-CSE-MsgGUID: LlerIsl/Rh6maAYVY2Ov5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="266714700"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.50])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 05:04:21 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 45598121BE0;
	Tue, 25 Aug 2026 15:04:31 +0300 (EEST)
Date: Tue, 25 Aug 2026 15:04:31 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 4/5] platform/x86: int3472: Release ACPI objects using
 __free()
Message-ID: <ao2Ezwepo6hBCOpg@kekkonen.localdomain>
References: <20260824211338.3583976-1-sakari.ailus@linux.intel.com>
 <20260824211338.3583976-5-sakari.ailus@linux.intel.com>
 <CAJZ5v0h41GA+O3u40eaKUy5uBDGGzg_KOuRJi5GEEa1z_dh63Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h41GA+O3u40eaKUy5uBDGGzg_KOuRJi5GEEa1z_dh63Q@mail.gmail.com>

Hi Rafael,

Thank you for the review.

On Tue, Aug 25, 2026 at 01:54:28PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Mon, Aug 24, 2026 at 11:13 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Use __free() to release ACPI objects received from
> > acpi_evaluate_dsm_typed() without explicit ACPI_FREE().
> 
> Well, the benefit of doing so is not entirely clear to me.
> 
> At least there is more overhead in the new code, or am I mistaken?

It becomes possible to simplify error handling mid-function. See the 5th
patch -- perhaps squashing this with that would make this more visible?

-- 
Regards,

Sakari Ailus
