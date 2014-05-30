From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/10] ACPI enumeration rework (was: Re: [PATCH V7 00/11] ACPI: ACPI enumeration rework)
Date: Fri, 30 May 2014 04:20:41 +0200
Message-ID: <35042328.kk6ZUUdfyN@vostro.rjw.lan>
References: <1400781753-2682-1-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57299 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754498AbaE3COg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 May 2014 22:14:36 -0400
In-Reply-To: <1400781753-2682-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, matthew.garrett@nebula.com, mika.westerberg@linux.intel.com

On Friday, May 23, 2014 02:02:22 AM Zhang Rui wrote:
> Hi, all,
> 
> Currently, PNP bus is used as the default bus for for enumerating ACPI
> devices with _HID/_CID.
> For a device that needs to be enumerated to platform bus, we need to add
> its id string to the platform scan handler white list explicitly.
> 
> This becomes a problem as more and more _HID devices need to be
> enumerated to platform bus nowadays, thus the list is continuously growing.
> 
> So, a solution that uses platform bus for _HID enumeration by default
> is preferred.
> 

OK, this has had several rounds of review already and we're really starting
to run out of time with it, so my version of this patchset follows.

It is mostly based on your patches, but reordered and with some major
changes.  Compiled only for now, so please let me know if there's any
breakage in it.  [The last patch will not apply without update of the
device list being removed, but generally this is on top of linux-next
material.]

Thanks,
Rafael

