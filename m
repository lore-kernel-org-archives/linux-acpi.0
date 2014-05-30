From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/10] ACPI enumeration rework (was: Re: [PATCH V7 00/11] ACPI: ACPI enumeration rework)
Date: Fri, 30 May 2014 14:17:18 +0200
Message-ID: <2623762.V0pfhTNL2O@vostro.rjw.lan>
References: <1400781753-2682-1-git-send-email-rui.zhang@intel.com> <35042328.kk6ZUUdfyN@vostro.rjw.lan> <20140530083325.GB1645@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52082 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751115AbaE3MAM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 May 2014 08:00:12 -0400
In-Reply-To: <20140530083325.GB1645@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, matthew.garrett@nebula.com

On Friday, May 30, 2014 11:33:25 AM Mika Westerberg wrote:
> On Fri, May 30, 2014 at 04:20:41AM +0200, Rafael J. Wysocki wrote:
> > On Friday, May 23, 2014 02:02:22 AM Zhang Rui wrote:
> > > Hi, all,
> > > 
> > > Currently, PNP bus is used as the default bus for for enumerating ACPI
> > > devices with _HID/_CID.
> > > For a device that needs to be enumerated to platform bus, we need to add
> > > its id string to the platform scan handler white list explicitly.
> > > 
> > > This becomes a problem as more and more _HID devices need to be
> > > enumerated to platform bus nowadays, thus the list is continuously growing.
> > > 
> > > So, a solution that uses platform bus for _HID enumeration by default
> > > is preferred.
> > > 
> > 
> > OK, this has had several rounds of review already and we're really starting
> > to run out of time with it, so my version of this patchset follows.
> > 
> > It is mostly based on your patches, but reordered and with some major
> > changes.  Compiled only for now, so please let me know if there's any
> > breakage in it.  [The last patch will not apply without update of the
> > device list being removed, but generally this is on top of linux-next
> > material.]
> 
> The series looks good to me now.
> 
> You can add
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> to all the patches if you like.

I will, thanks! :-)

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
