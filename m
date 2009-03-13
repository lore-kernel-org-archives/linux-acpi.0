From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: patch for video.c driver
Date: Fri, 13 Mar 2009 20:52:56 +0000
Message-ID: <20090313205256.GA5854@srcf.ucam.org>
References: <20090312154741.GA1055@hygelac> <1236910092.2807.103.camel@rzhang-dt> <20090313030030.GA23571@srcf.ucam.org> <20090313173604.GB13342@hygelac> <20090313174726.GA2888@srcf.ucam.org> <20090313175812.GE13342@hygelac> <20090313180646.GA3171@srcf.ucam.org> <20090313204544.GR16754@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46137 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbZCMUxG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Mar 2009 16:53:06 -0400
Content-Disposition: inline
In-Reply-To: <20090313204544.GR16754@hygelac>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Fri, Mar 13, 2009 at 03:45:44PM -0500, Terence Ripperda wrote:

> NVIF methods implement both notification and query commands. so it's required
> for generating the event and querying the firmware's preferred set of enabled
> outputs.

Ok, got you. In that case the best approach would be for you to add an 
input device to the kernel component of your driver which listens for 
the notification and then generates KEY_SWITCHVIDEOMODE. The right level 
of integration for the preferred set of screens would be to extend the 
video output class to support listing the outputs as well as just 
performing the switches, then register with that if the platform doesn't 
support DGS and co. We're trying to deprecate the proc interfaces, and 
in general platform-specific drivers should hook into generic interfaces 
rather than overloading the functionality of the existing ACPI drivers.

Do you have any examples of machines that have this requirement?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
