Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D77D48D890;
	Mon, 28 Sep 2026 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589942; cv=none; b=u80mRCiq1FL1JWaDYRI0nrwQc9MWFIcWTgtQFiMLuFI1dLDyfgXlRGzpeMPpiSEHi7/RuhdgslAfTDf//ixkAqQtdzqJoEV6HQ2HSkgN+rwqW5PSEI0YjNcyStQMqCRkXYOYU4m0p+95PkhliHS2+a9xYb5st6q3SPBlI03JhJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589942; c=relaxed/simple;
	bh=DbOusftimddsgE8f0FZAtzebevz2Qk3DbogdBudWLZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/ZAKobKc+s1Njlm/Lz15WabbQJWF3/7819HjiZWMkWmbI2/GkDuBlrgQENgHfzJXVD0dvWzN2l2JBgxO/kcruCMImd//IZLPNhM1dErtHbGZ1Ne5EdcuTTh9X9h0tSa1GNIPjL3I7+t/K4aP1jesklBMUWpZTjWm0M02acodwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiSNT6CK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiSNT6CK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790589940; x=1822125940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DbOusftimddsgE8f0FZAtzebevz2Qk3DbogdBudWLZw=;
  b=RiSNT6CKDtrkIuX6WVYXPytuFo2vtjOihkTGtDJFbIZn5vX5aQUcbLsJ
   lDg/hqjYeSh/r8TE6xd75HSN33opI4M+Ei/CMOFVsH5IZydCqJQtPj0ps
   NqGhLMRTK3FCZZI3Kdgp8I4RU5kacP/jJvmmqOHvh9Zmimvs+OzXkZuEf
   Upj80DUG55XRrXv6woqIyrnpqtY+ZT/RKY7KWlpRXqfWrYQLCz7aOTmCe
   7RKKkR7jzvlJ38fMVzZ4nFyHl4OJrFRwJeXEEmsCSTx7121gyzAtGePYH
   pOld2BsAqPoAxoJoQwTkKgWz5yjNAJUrsg1M/eL4oatv8l4Ru5gJbcBq9
   A==;
X-CSE-ConnectionGUID: zvnOj5vTQTif7hqidUBISA==
X-CSE-MsgGUID: ALX4+1b1RPOTzWuCb28aXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90189872"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90189872"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 03:05:39 -0700
X-CSE-ConnectionGUID: aBy4UDDwRbqx33zxPrbdvQ==
X-CSE-MsgGUID: /9PeS/vcTWSUu3n5v+YZtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="273149675"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 03:05:37 -0700
Date: Mon, 28 Sep 2026 13:05:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bartu Alev <bartualev@gmail.com>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Ignore AC adapter wakeup on ASUS FA507
Message-ID: <aro77qeVeSdWfZ7N@ashevche-desk.local>
References: <20260927014212.302743-1-bartualev@gmail.com>
 <20260928094156.GG106095@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928094156.GG106095@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 28, 2026 at 11:41:56AM +0200, Mika Westerberg wrote:
> On Sun, Sep 27, 2026 at 04:42:12AM +0300, Bartu Alev wrote:
> > The ASUS TUF Gaming A15 FA507 wakes from s2idle whenever the AC
> > adapter is plugged in or unplugged.
> > 
> > In the CPMGPIO0 SSDT, GPIO pin 23 (0x0017) is declared in the
> > \_SB.GPIO._AEI resource template as:
> > 
> >     GpioInt (Edge, ActiveBoth, ExclusiveAndWake, PullNone, 0x0000,
> >              "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
> >              { 0x0017 }
> > 
> > and the corresponding \_SB.GPIO._EVT handler issues a device wake
> > notification for the AC adapter on pin 23 events:
> > 
> >     Case (0x17)
> >     {
> >         Notify (\_SB.ACAD, 0x02) // Device Wake
> >         Sleep (0x05)
> >         Notify (\_SB.ACAD, 0x80) // Status Change
> >     }
> > 
> > Both AC plug and unplug transitions therefore trigger a spurious
> > wakeup from s2idle. Add an ignore_wake quirk for this pin.
> 
> I would think this is by design like that.

Yep, we don't have quirks for AC adapter events, touch pad and USB are
the majority of misbehaving cases.

With that being said, I defer this patch (you can discuss more and if
the conclusion is to include, it may be done in the next release).

> What is the issue? You unplug the device from AC with lid closed and it
> wakes up? Userspace should put it back to sleep in these cases. In Windows
> and ChromeOS there is something called "dark resume" that deals with this
> but I'm not sure if generic distros have that yet.

-- 
With Best Regards,
Andy Shevchenko


