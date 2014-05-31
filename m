From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/10] ACPI enumeration rework (was: Re: [PATCH V7 00/11]
 ACPI: ACPI enumeration rework)
Date: Sat, 31 May 2014 22:46:36 +0800
Message-ID: <1401547596.2426.4.camel@rzhang1-toshiba>
References: <1400781753-2682-1-git-send-email-rui.zhang@intel.com>
	 <35042328.kk6ZUUdfyN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13681 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122AbaEaOqj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 31 May 2014 10:46:39 -0400
In-Reply-To: <35042328.kk6ZUUdfyN@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, matthew.garrett@nebula.com, mika.westerberg@linux.intel.com

On Fri, 2014-05-30 at 04:20 +0200, Rafael J. Wysocki wrote:
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
> 
Applied the patch set on top of linux-pm tree linux-next branch, with
some modifications of Patch 9/10 because of the updated lpss id list,
it works as expected on an IVB Ultrabook.

Tested-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui

