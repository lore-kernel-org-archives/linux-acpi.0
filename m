Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB5E3542D4;
	Wed, 26 Aug 2026 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735084; cv=none; b=hBxDDf2k74bNt0n6pjzURD6dsj4zZzRwH2R7PEkbO5wnXS2OP7E28DNknfnlC0bKCs1GDvlvIEpJYnMgEGU0NS9QF9Qc5EOtfrtoJpRqQEvRDd09xx5dJWvbxScW5zE8zfGE/hv7ao1phz970VgdcEFGsvNne+fA+sPlfnB/Oa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735084; c=relaxed/simple;
	bh=IfXNrmMA/cv+Wpzmni7v9jr3O3VipieGv6mDQHETTFU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PDNN2Ftr7YuT/xT2CU2X0eKfmW+WFYrm3TJqfXGdtpZW2HqVopl8JNSKOlaJK4JIBBbd5pcFvt3j1olbURSQqJtHVk5iJNuRqlNr8b9q6MxCeCJdu1UX1wOF/Sv4ikJl/0DPtMEXvjYzsmE7HiUZlGVUFl2xI8hPwU1F35pG1jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNwUlUeU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNwUlUeU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787735082; x=1819271082;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IfXNrmMA/cv+Wpzmni7v9jr3O3VipieGv6mDQHETTFU=;
  b=dNwUlUeUXeOn8R0n/qVqp9xzcg3N9cwVn9tXjlzIAYJLJHJ2zCHcXiZO
   /ntAL92xQBgkvbGnby1WsfZEBsyQftxgeTF3nuh50bUNnGB6vHwV0uy9F
   3Zb5YerymucTA5LbFiWxWz8Gbyi5L0LtUue0FvgqPOTkCdGKi5fu7aqBw
   01qbPhTfDaIS55B32JPrGDx/VphAQJHANTfbHENwS0LmVL7EnEEdRDnid
   yu01y7r9JPm8FZFq92x0TtTn9+bitALwiM2BtIDhxLXda1MzoxDot2wiI
   zjBPL+hZjhcrlCS1RvKlUIQcdI+ylXGl5ZP4sLheir3ptOSPfGSn8Ss0i
   A==;
X-CSE-ConnectionGUID: 1d7VDQk+Qq+p2TY58y9jKQ==
X-CSE-MsgGUID: +mMXgdbMRrigTedrjMVu8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="105735840"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="105735840"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 02:04:41 -0700
X-CSE-ConnectionGUID: lSKGzLEPSXuaMgYNPyd0+Q==
X-CSE-MsgGUID: D1VVjkgZSjq8j5B0QQ+cGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="261389778"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 02:04:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 26 Aug 2026 12:04:34 +0300 (EEST)
To: Sakari Ailus <sakari.ailus@linux.intel.com>
cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, 
    linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, 
    Daniel Scally <dan.scally@ideasonboard.com>, 
    Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ACPI: Support __free() from cleanup.h for ACPI
 objects
In-Reply-To: <ao3uh2xos_1uwAgJ@kekkonen.localdomain>
Message-ID: <762e0630-1b04-6a82-69b6-ca5148e74cff@linux.intel.com>
References: <20260824211338.3583976-1-sakari.ailus@linux.intel.com> <20260824211338.3583976-4-sakari.ailus@linux.intel.com> <CAJZ5v0ieb2FcANOt0MRMsTrwtbLiUF48W_c=3z3OpNH92d=7vg@mail.gmail.com> <ao2FmNRFjSJVxhrL@kekkonen.localdomain>
 <CAJZ5v0gQVFxSkkjPbRf6bsKdgUBGduZV0M5SWrHoeB246ZLqew@mail.gmail.com> <134e9566-7913-86d7-1e8b-b2ca9ebec55c@linux.intel.com> <CAJZ5v0h4KD6Q1DeuwbFQ83U1=wKORMWUQNA2BwnFtsYAyzz_Ow@mail.gmail.com> <CAJZ5v0ggPGEu8YQTpeTC6=tVNr1zponkCbs+UQPieAH5k6ngUg@mail.gmail.com>
 <ao3uh2xos_1uwAgJ@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 25 Aug 2026, Sakari Ailus wrote:

> Hi Rafael, Ilpo,
> 
> On Tue, Aug 25, 2026 at 03:08:07PM +0200, Rafael J. Wysocki (Intel) wrote:
> > > If there is a cleanup.h "free" that can only be used with objects
> > > returned by acpi_evaluate_dsm_typed(), I'll be fine with that.
> > >
> > > Or if everyone agrees that doing
> > >
> > >     union acpi_object *out_obj __free(ACPI_FREE) = NULL;
> > >
> > > is not confusing and fine, I may just say "Hey, I don't care that much".
> > 
> > And particularly there is this paragraph in a comment in cleanup.h:
> > 
> >  * Given that the "__free(...) = NULL" pattern for variables defined at
> >  * the top of the function poses this potential interdependency problem
> >  * the recommendation is to always define and assign variables in one
> >  * statement and not group variable definitions at the top of the
> >  * function when __free() is used.
> > 
> > regarding a broken code example, so I would think that this is not a
> > made-up concern.
> 
> That's indeed a valid concern, still quite unlikely in practice but
> probably hard to find when it happens, so avoiding that is definitely
> preferred. That being said, the biggest trap in cleanup.h is probably in
> scoped_guard(), and doing __free() = NULL somewhere doesn't matter much in
> the end.

__free() = NULL is not that hard to catch during review (or even in
code already in-tree), have done that dozens of times myself by now.
Checkpatch, too, should be able to catch that easily, if it doesn't 
already.

None of those cases I've commented on had a bug, so it was just for 
teaching submitters & readers of that code the correct __free() pattern.
I think the concern is largely overblown given how rare actual bugs are 
even if the wrong pattern is used. Put that to contrast to memleaks found 
on our rollback paths, __free() looks a clear win despite very rare to 
occur caveats.

Given what I've seen, I'd say on dangerous level __free() = NULL is 
somewhere around using MAGIC_SIZE_DEFINE instead sizeof(*obj) when doing 
mem allocs. It usually isn't buggy even if we don't want to teach people 
to use it.

Besides, it was actually Rafael himself who brought the unsafe pattern 
into this discussion (I immediately noticed the problem but since it was 
not an actual patch, I didn't raise a concern). Sakari's patch did use the 
correct pattern (and if it wouldn't have done so, there would have been a 
review comment from me ;-)). In my reply to Rafael, I intentionally left 
the right side open with "= ..." to not place that NULL there.

> In this case I'll just call ACPI_FREE() sooner.

That works too in this case, yes.

-- 
 i.

