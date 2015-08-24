From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Ignore 10ms delay for Braswell and Baytrail
Date: Mon, 24 Aug 2015 12:44:55 +0300
Message-ID: <20150824094455.GP30005@lahna.fi.intel.com>
References: <1440090968-17728-1-git-send-email-srinidhi.kasagar@intel.com>
 <20150820123805.GG30005@lahna.fi.intel.com>
 <20150821121152.GA26813@intel-desktop>
 <20150821063641.GK30005@lahna.fi.intel.com>
 <20150821132015.GN30005@lahna.fi.intel.com>
 <20150824125147.GA23677@intel-desktop>
 <20150824085959.GO30005@lahna.fi.intel.com>
 <20150824170920.GA32764@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58875 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834AbbHXJo7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Aug 2015 05:44:59 -0400
Content-Disposition: inline
In-Reply-To: <20150824170920.GA32764@intel-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Cc: linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com, Kumar P Mahesh <mahesh.kumar.p@intel.com>, Heikki Krogerus <heikki.krogerus@intel.com>

On Mon, Aug 24, 2015 at 10:39:21PM +0530, Kasagar, Srinidhi wrote:
> Ok, then we have two options:
> 
> Let's drop LPSS_NO_D3_DELAY for BYT and duplicate the common devices which
> are shared between Braswell and BYT & keep LPSS_NO_D3_DELAY only for BSW.

That sounds the safest option for now.

> OR
> Use the cpu id to detect the platform which I believe not a good idea..
> 
> Because of few devices, I do not think it make sense to compromise on
> the significant reduction in the resume delay.

I agree.
