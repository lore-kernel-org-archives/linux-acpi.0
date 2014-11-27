From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] acpi:apd:add AMD ACPI2Platform device support for x86
 system.
Date: Thu, 27 Nov 2014 18:48:11 +0200
Message-ID: <20141127164811.GN1304@lahna.fi.intel.com>
References: <1416290291-5802-1-git-send-email-Ken.Xue@amd.com>
 <1416997898.17328.5.camel@kxue-X58A-UD3R>
 <20141127114637.GA1304@lahna.fi.intel.com>
 <2448167.LI9SjY8OTa@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:24453 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208AbaK0QsQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Nov 2014 11:48:16 -0500
Content-Disposition: inline
In-Reply-To: <2448167.LI9SjY8OTa@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ken Xue <Ken.Xue@amd.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wu, Jeff" <Jeff.Wu@amd.com>, Andriy Shevchenko <andriy.shevchenko@intel.com>

On Thu, Nov 27, 2014 at 06:06:35PM +0100, Rafael J. Wysocki wrote:
> On Thursday, November 27, 2014 01:46:37 PM Mika Westerberg wrote:
> > On Wed, Nov 26, 2014 at 06:31:38PM +0800, Ken Xue wrote:
> 
> [cut]
> 
> > > diff --git a/drivers/acpi/acpi_soc.h b/drivers/acpi/acpi_soc.h
> > > new file mode 100755
> > > index 0000000..96db30e
> > > --- /dev/null
> > > +++ b/drivers/acpi/acpi_soc.h
> > 
> > And all this belongs to drivers/acpi/internal.h.
> 
> I requested the new file.
> 
> I don't really want things specific to SoC drivers to be mixed up with ACPI core
> stuff.  It may even be good to create a separate subdir for the SoC stuff, but
> that can be done later.

I see, thanks for the explanation.
