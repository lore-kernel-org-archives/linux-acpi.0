From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Ignore 10ms delay for Braswell and Baytrail
Date: Thu, 27 Aug 2015 11:30:50 +0300
Message-ID: <20150827083050.GC28428@lahna.fi.intel.com>
References: <20150821121152.GA26813@intel-desktop>
 <20150821063641.GK30005@lahna.fi.intel.com>
 <20150821132015.GN30005@lahna.fi.intel.com>
 <20150824125147.GA23677@intel-desktop>
 <20150824085959.GO30005@lahna.fi.intel.com>
 <20150824170920.GA32764@intel-desktop>
 <20150824094455.GP30005@lahna.fi.intel.com>
 <20150827143953.GA5095@intel-desktop>
 <20150827071414.GB28428@lahna.fi.intel.com>
 <20150827161321.GA9886@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:55821 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbbH0Iax (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Aug 2015 04:30:53 -0400
Content-Disposition: inline
In-Reply-To: <20150827161321.GA9886@intel-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Cc: linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com, Kumar P Mahesh <mahesh.kumar.p@intel.com>, Heikki Krogerus <heikki.krogerus@intel.com>

On Thu, Aug 27, 2015 at 09:43:21PM +0530, Kasagar, Srinidhi wrote:
> >From 970c704dbb05aa8392b6e1090ceaf9ed76b6436b Mon Sep 17 00:00:00 2001
> From: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
> Date: Thu, 27 Aug 2015 21:30:55 +0530
> Subject: [PATCH] ACPI / LPSS: Ignore 10ms delay for Braswell
> 
> LPSS devices in Braswell does not need the default 10ms
> d3_delay imposed by PCI specification. Removing this
> unnecessary delay significantly reduces the resume time
> approximately upto 200ms on this platform.
> 
> Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>

Looks good now, thanks!

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
