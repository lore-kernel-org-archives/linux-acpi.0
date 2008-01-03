From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Re: [patch] hibernation: utilize ACPI hardware signature
Date: Thu, 3 Jan 2008 17:58:02 +0100
Message-ID: <200801031758.03056.rjw@sisk.pl>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com> <200801022301.45706.rjw@sisk.pl> <477C9D51.5000604@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48266 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbYACQ4I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Jan 2008 11:56:08 -0500
In-Reply-To: <477C9D51.5000604@nigel.suspend2.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nigel@nigel.suspend2.net
Cc: Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@suse.cz>

On Thursday, 3 of January 2008, Nigel Cunningham wrote:
> Hi.
> 
> Rafael J. Wysocki wrote:
> >> I suppose we can always disable this when we start to support hardware
> >> changing over hibernate (I have ideas in this direction - memory cold
> >> plugging, for a start).
> > 
> > Well, if we support such features, we won't be following ACPI any more.
> 
> Mmm. Apparently I'm not as focused on specs as you :).
> 
> I was starting to think through whether it could make for a new and much
> faster was to boot live cds - something along the lines of complete
> redetection of hardware and memory cold plugging. Of course it's only in
> the 'I wonder if this would be possible' stage at the mo, but seemed at
> least feasible - keep the e820 tables from boot, make _init routines not
> get thrown away and do something like the kexec device shutdown etc
> around an atomic restore.
> 
> I know there'd be limitations, but perhaps worth thinking about...

Well, what if the new e820 map is incompatible with the old one?

Rafael
