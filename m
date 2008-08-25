From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] Give ACPI hwmon thermal devices a name if BIOS
	provides one
Date: Mon, 25 Aug 2008 10:15:02 +0800
Message-ID: <1219630502.24775.35.camel@rzhang-dt>
References: <20080821174852.0689681d@hyperion.delvare>
	 <1219615897-21130-3-git-send-email-trenn@suse.de>
	 <200808250020.41626.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33627 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810AbYHYCPm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Aug 2008 22:15:42 -0400
In-Reply-To: <200808250020.41626.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: khali@linux-fr.org, linux-acpi@vger.kernel.org

On Mon, 2008-08-25 at 06:20 +0800, Thomas Renninger wrote:
> On Monday 25 August 2008 12:11:37 am Thomas Renninger wrote:
> > On a HP tx2500z laptop one thermal device provides this function:
> >             Name (REGN, "Processor Thermal Zone")
> 
> I wonder what we can do to get this added to the ACPI spec or to make
> vendors use the same function for this.

> What about trying for above "REGN" as it already exists on HPs.
> Also try for _NAM (or similar), document that we do this and tell
> vendors that it's a good thing to provide a sane string/name for
> thermal_zones on Linux.

> On ACPI everything that does not start with "_" means unspecified
> and the function should only be used internally and not by the OS...

Sounds good. But I guess it's not easy to push this the vendors, is it?

thanks,
rui

