Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3F73271EA;
	Fri, 24 Apr 2026 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777044760; cv=none; b=GihnQwZ8nr5qogdyFSGG6X3sE8tRwE86ThUZi9VtRpaJ+dGMo334gbQN/vyCjNfV5YS4F/raoiV5OnMF9+8X9dVGirnhQeqBvoDg9JlhOBE+rW9PEorlny12W5Ira4APzutvj0IJN5lWjy/RhmJRneFn37rh4usKu1Jonc4ssxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777044760; c=relaxed/simple;
	bh=cXfvpMfbUty6WH27pMRJg1yoB1H9Izvgfx98Du8Quj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grERnDTgLmIXmS9gwTpzDGhaEV48MbGbgGBuGxqPNNFtjb6uGY+VArr4o/czqDv43LjUxSLxUD5UGAL5k2EGR0GBxOBRzz6mpCAYWsHBNCfN6qosJ54IKb0Pf5HmAPqTa0VBbc2R+/W1FkIMsfhJRj5cF7zO40NZBRDkYJuYR7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azIYX67U; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azIYX67U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777044759; x=1808580759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cXfvpMfbUty6WH27pMRJg1yoB1H9Izvgfx98Du8Quj0=;
  b=azIYX67UGdMCQ/GcGEDOK/iTMx3holln8wjLZbFGdEvVKTh+KTqZB1qC
   8kzjE1mFnzpu6OJbE3kO+W5nwc62KWkg85SY9sEcHetthiLUqJfqBOFsU
   oXErC2AF0BCpXuvrOeD0ZfxAhSkXMto1EgE9rPBHxU5o90Mz9MiZDytXV
   2y9IZ9x4TzmTelVHrpcQ44qyAqjaKtc5yvCvaDUwEuvQjE/tYGC/52H9H
   wknJ8Thd+2TFZK3conI04XPDU/d2RU+244IJGrlbbH8Dj5id6AwF6xYu/
   yEirFwWT7noqLxBoAhSUbu64s/EgzPyRLY7VxuyxZEtUr82t3vfIuBvCL
   g==;
X-CSE-ConnectionGUID: cVFW7LoKT6y1RFDiwAxLlw==
X-CSE-MsgGUID: /V24NvC3TmmZaiy5kt7OIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="100680151"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="100680151"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 08:32:39 -0700
X-CSE-ConnectionGUID: aZXW0m3cQlG7JtpWyq/65Q==
X-CSE-MsgGUID: qvq93lBjT1ayP5Bwdw6pUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="236952003"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 08:32:36 -0700
Date: Fri, 24 Apr 2026 18:32:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] software node: provide wrappers around kobject_get/put()
Message-ID: <aeuNEYymSicUcMyZ@ashevche-desk.local>
References: <20260424124250.92890-1-bartosz.golaszewski@oss.qualcomm.com>
 <aetxEcjE8wD4-ZyV@ashevche-desk.local>
 <CAMRc=Mem3m8JZXafL9xrUvWZWuFaCofkNEdVYLNMgC+3N0i21g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mem3m8JZXafL9xrUvWZWuFaCofkNEdVYLNMgC+3N0i21g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 24, 2026 at 03:43:39PM +0200, Bartosz Golaszewski wrote:
> On Fri, Apr 24, 2026 at 3:33 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Apr 24, 2026 at 02:42:50PM +0200, Bartosz Golaszewski wrote:

...

> > Isn't a pattern to return the object itself so the code can bump the reference
> > in a single statement (if appropriate)?
> 
> Typically yeah but nobody here would use it right now. I can change it
> if you prefer it.

I showed below the example (it's now cut from the context).

...

> > >       list_for_each_entry(child, &swnode->children, entry) {
> > >               if (!strcmp(childname, kobject_name(&child->kobj))) {
> > > -                     kobject_get(&child->kobj);
> > > +                     swnode_get(child);
> >
> > Becomes inconsistent with kobject_name()...
> 
> What do you mean?
> 
> > >                       return &child->fwnode;
> > >               }
> > >       }

The same piece of code uses kobj and child either way of this conversion happen
or not. To be fully consistent we need something like swnode_match_name() or
alike instead of that strcmp().

...

> > >               swnode = kobj_to_swnode(k);
> > >               if (parent == swnode->node->parent && swnode->node->name &&
> > >                   !strcmp(name, swnode->node->name)) {
> > > -                     kobject_get(&swnode->kobj);
> > > +                     swnode_get(swnode);
> >
> > Also not sure. Maybe use 'k'?
> 
> I'm not following either, please rephrase.

                     kobject_get(k);

should also work. And here I referred to the fact that we already have a kobject
instance available. Yes, my counter example is just to reveal inconsistency,
I kinda agree that using swnode specific API might be clearer approach.

-- 
With Best Regards,
Andy Shevchenko


