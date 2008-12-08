From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] acpi: move thermal trip handling to generic thermal layer
Date: Mon, 8 Dec 2008 12:59:04 +0000
Message-ID: <20081208125904.GA31976@srcf.ucam.org>
References: <20081127174813.GA24258@srcf.ucam.org> <20081127174956.GB24258@srcf.ucam.org> <20081203175532.GA20770@srcf.ucam.org> <1228719540.7929.141.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60398 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbYLHM7S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 07:59:18 -0500
Content-Disposition: inline
In-Reply-To: <1228719540.7929.141.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Thomas, Sujith" <sujith.thomas@intel.com>

On Mon, Dec 08, 2008 at 02:59:00PM +0800, Zhang Rui wrote:
> On Thu, 2008-12-04 at 01:55 +0800, Matthew Garrett wrote:
> > The ACPI code currently carries its own thermal trip handling, meaning that
> > any other thermal implementation will need to reimplement it. Move the code
> > to the generic thermal layer.
> > 
> Are these ACPI stuffs generic enough to be ported to the generic thermal
> driver?
> e.g. the tc1, tc2, tsp, they are mentioned in the ACPI spec, 
> so my question is if the thermal zones than ACPI still have these
> concepts?

They're needed if you want to implement any sort of sensible 
implementation of passive cooling. They might not be expressed in quite 
the same way, but the basic concept is identical.
