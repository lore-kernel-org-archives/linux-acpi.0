From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC] i915/acpi: add lid status notification and detection
Date: Thu, 21 May 2009 16:57:53 +0800
Message-ID: <1242896273.32574.10.camel@rzhang-dt>
References: <20090513115734.338b7d55@jbarnes-g45>
	 <1242264144.3773.415.camel@localhost.localdomain>
	 <20090519171545.GA17801@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14544 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbZEUI5S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 May 2009 04:57:18 -0400
In-Reply-To: <20090519171545.GA17801@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2009-05-20 at 01:15 +0800, Matthew Garrett wrote:
> > > There's also a policy question here.  On some machines, a lid close
> > > will cause the ACPI firmware to program the GPU, disabling the pipe
> > > associated with the panel.  Should we detect this and turn it back on
> > > at open time?  That could be dangerous if userspace has received the
> > > LVDS hotplug event and changed the config out from under us...
> > > 
> > > Comments?
> > It seems that the LID status is used to determine whether the LVDS is
> > connected.
> > It is not reliable. On some boxes the initial LID status is incorrect.
> > Maybe the LID status is open. But the ACPI returns that the LID is
> > close. In such case the LVDS is not initialized and user can't get the
> > output.
> 
> Really? I haven't seen any cases of this. They'll fail in all sorts of 
> fun ways with modern userland.
> 
This is rare, and if this happens, a bug should be filed against ACPI.
BTW: we have fixed/root caused all such kind of bugs that have been
reported.
So I think it makes sense to trust the Lid state reported by ACPI button
driver.

thanks,
rui

