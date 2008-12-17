From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH] acpi: move thermal trip handling to generic thermal layer
Date: Wed, 17 Dec 2008 03:12:15 +0000
Message-ID: <20081217031215.GC19430@srcf.ucam.org>
References: <20081127174813.GA24258@srcf.ucam.org> <20081127174956.GB24258@srcf.ucam.org> <20081203175532.GA20770@srcf.ucam.org> <1228719540.7929.141.camel@rzhang-dt> <20081208125904.GA31976@srcf.ucam.org> <1229482938.562.29.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36094 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbYLQDMW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Dec 2008 22:12:22 -0500
Content-Disposition: inline
In-Reply-To: <1229482938.562.29.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Thomas, Sujith" <sujith.thomas@intel.com>

On Wed, Dec 17, 2008 at 11:02:18AM +0800, Zhang Rui wrote:
> On Mon, 2008-12-08 at 20:59 +0800, Matthew Garrett wrote:
> > They're needed if you want to implement any sort of sensible 
> > implementation of passive cooling. They might not be expressed in quite 
> > the same way, but the basic concept is identical.
> 
> Seeing tc1, tc2, tsp under /sys/class/thermal/ is not good because we
> don't want to make the generic thermal driver too ACPI specific, before
> we've really concluded some basic concepts for passive cooling.
> so why not do this after we have another generic thermal user with
> passive cooling support?

They're not exposed in /sys/class, and I don't think doing so is a 
sensible thing to do. If you know values for the hardware in question 
then they should be supplied by the firmware. But even so, the generic 
thermal layer needs a way of implementing passive cooling. Doing so 
involves deriving a formula to describe the behaviour of the system 
around the passive trip level, and the best used implementation of that 
in Linux at the moment is the one described in the ACPI spec. I don't 
see any real need to generate new terms to describe well documented 
concepts, even if other implementations don't use ACPI.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
