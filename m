From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] acpi: move thermal trip handling to generic thermal
	layer
Date: Wed, 17 Dec 2008 11:02:18 +0800
Message-ID: <1229482938.562.29.camel@rzhang-dt>
References: <20081127174813.GA24258@srcf.ucam.org>
	 <20081127174956.GB24258@srcf.ucam.org>
	 <20081203175532.GA20770@srcf.ucam.org>
	 <1228719540.7929.141.camel@rzhang-dt>
	 <20081208125904.GA31976@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26839 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996AbYLQDDd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Dec 2008 22:03:33 -0500
In-Reply-To: <20081208125904.GA31976@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Thomas, Sujith" <sujith.thomas@intel.com>

On Mon, 2008-12-08 at 20:59 +0800, Matthew Garrett wrote:
> On Mon, Dec 08, 2008 at 02:59:00PM +0800, Zhang Rui wrote:
> > On Thu, 2008-12-04 at 01:55 +0800, Matthew Garrett wrote:
> > > The ACPI code currently carries its own thermal trip handling, meaning that
> > > any other thermal implementation will need to reimplement it. Move the code
> > > to the generic thermal layer.
> > > 
> > Are these ACPI stuffs generic enough to be ported to the generic thermal
> > driver?
> > e.g. the tc1, tc2, tsp, they are mentioned in the ACPI spec, 
> > so my question is if the thermal zones than ACPI still have these
> > concepts?
> 
> They're needed if you want to implement any sort of sensible 
> implementation of passive cooling. They might not be expressed in quite 
> the same way, but the basic concept is identical.

Seeing tc1, tc2, tsp under /sys/class/thermal/ is not good because we
don't want to make the generic thermal driver too ACPI specific, before
we've really concluded some basic concepts for passive cooling.
so why not do this after we have another generic thermal user with
passive cooling support?

thanks,
rui

