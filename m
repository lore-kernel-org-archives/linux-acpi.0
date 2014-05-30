From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/10] ACPI enumeration rework (was: Re: [PATCH V7 00/11]
 ACPI: ACPI enumeration rework)
Date: Fri, 30 May 2014 11:33:25 +0300
Message-ID: <20140530083325.GB1645@lahna.fi.intel.com>
References: <1400781753-2682-1-git-send-email-rui.zhang@intel.com>
 <35042328.kk6ZUUdfyN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2927 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792AbaE3Id3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 May 2014 04:33:29 -0400
Content-Disposition: inline
In-Reply-To: <35042328.kk6ZUUdfyN@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, matthew.garrett@nebula.com

On Fri, May 30, 2014 at 04:20:41AM +0200, Rafael J. Wysocki wrote:
> On Friday, May 23, 2014 02:02:22 AM Zhang Rui wrote:
> > Hi, all,
> > 
> > Currently, PNP bus is used as the default bus for for enumerating ACPI
> > devices with _HID/_CID.
> > For a device that needs to be enumerated to platform bus, we need to add
> > its id string to the platform scan handler white list explicitly.
> > 
> > This becomes a problem as more and more _HID devices need to be
> > enumerated to platform bus nowadays, thus the list is continuously growing.
> > 
> > So, a solution that uses platform bus for _HID enumeration by default
> > is preferred.
> > 
> 
> OK, this has had several rounds of review already and we're really starting
> to run out of time with it, so my version of this patchset follows.
> 
> It is mostly based on your patches, but reordered and with some major
> changes.  Compiled only for now, so please let me know if there's any
> breakage in it.  [The last patch will not apply without update of the
> device list being removed, but generally this is on top of linux-next
> material.]

The series looks good to me now.

You can add

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

to all the patches if you like.
