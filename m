Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632B93CE497;
	Fri, 27 Mar 2026 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603713; cv=none; b=OekaOX9koaLC1RDj7I0D4fDxx50B51d7xxYVCXfgtuaLbBKWWm85F0JtBcls0wEli1JPPh71oNncvI3eLwXklGCM1r3UAFm5pKOCHcaX+R4cDpBcjxwVLJfTZzYobg0n+WNNrdiuBN3EP9K2XFkVvsKM95SgwaeFC4XL/ODpEOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603713; c=relaxed/simple;
	bh=RHdRErJ4hF4/KqB488JgMjZDt35iAVLAc9ubaLUHyyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKPHfEav6dYEtU+V2O9CRAt9qA7jcXcGQi/Q9nAjVzYNHuj4G2QTTbvKoTpDkkyKAoqiQhbp7Q6j0ZP5MwBK2mJTf7AH1Vp/o++gefFyDNhrGUL9mkKAgrpKn/Fy4bilRVcxnJ9zYx81Vu8vq1V0Qp8SjKwSI/RQ9U+HNSCbc3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DrorG5hv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DrorG5hv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774603711; x=1806139711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RHdRErJ4hF4/KqB488JgMjZDt35iAVLAc9ubaLUHyyI=;
  b=DrorG5hvuSSvBqpWCH1gDbWzm6ajlYmXOSfHg9W/nU9BrShRxiLL+bVP
   bD1+78dmZeCZl2WVrPSrPVeiCDx/Z+QvRR9jmHon7pN41tlnBNOt4phUN
   ZQRwGIiqb24DtZ21F7vQf7/6CP3V+nCb/gfJVdPSrULHzqyDMoI5nPJNE
   DpRmy1EMC9gd4uIHXl3x/2t+gBJWiUzamuu/F8VG+FnWM9T+9ZyEcB0P0
   VMx1ZlpHN1IEBgexGd/P8ebb0oBjet2baVHKWtYp47H6S6/iDGO3k1/lS
   sPG0W6s5KVMQ16ogY7OrHTL94KVAGfa2lnSo6SEsWinqm+4oC7qF1S/81
   A==;
X-CSE-ConnectionGUID: 8hOwmbBWRXSuTzS6C8lQNw==
X-CSE-MsgGUID: OkOZ/XGnTH6f3CFr+M0tLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79532719"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="79532719"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:28:30 -0700
X-CSE-ConnectionGUID: lzfcOEGCQiy65HeIW202dQ==
X-CSE-MsgGUID: KAtiGO4HRoOib/QBLo9sPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="229742915"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:28:28 -0700
Date: Fri, 27 Mar 2026 11:28:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: david.laight.linux@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next] ACPICA: AML Parser: Remove spurious precision from
 format used to dump parse trees
Message-ID: <acZNuoRmQ5BrfPPd@ashevche-desk.local>
References: <20260326201830.3938-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326201830.3938-1-david.laight.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 08:18:30PM +0000, david.laight.linux@gmail.com wrote:

> The debug code in acpi_ps_delete_parse_tree() uses ("%*.s", level * 4, " ")
> to indent traces.
> POSIX requires the empty precision be treated as zero, but the kernel treats
> is as 'no precision specified'.
> Change to ("%*s", level * 4, "") since there is additional whitespace and no
> reason to indent by one space when level is zero.

This is cross-platform code. Does the same applies to MS VC compiler, for
example?

-- 
With Best Regards,
Andy Shevchenko


