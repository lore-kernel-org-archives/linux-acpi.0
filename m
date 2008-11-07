From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH 21/21] ACPI: EC: make kernel messages more
	useful when GPE storm is detected
Date: Fri, 7 Nov 2008 10:49:26 -0800
Message-ID: <20081107184926.GC2320@kroah.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org> <be11b915c297a6ccea17356d689d60734967f5f6.1226032677.git.len.brown@intel.com> <491407F4.4090404@tuffmail.co.uk> <200811071454.25304.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:57308 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752612AbYKGUMx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Nov 2008 15:12:53 -0500
Content-Disposition: inline
In-Reply-To: <200811071454.25304.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-acpi@vger.kernel.org, stable@kernel.org, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>

On Fri, Nov 07, 2008 at 02:54:24PM +0100, Rafael J. Wysocki wrote:
> On Friday, 7 of November 2008, Alan Jenkins wrote:
> > Len Brown wrote:
> > > From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> > >
> > > Make sure we can tell if the GPE storm workaround gets activated,
> > > and avoid flooding the logs afterwards.
> > >
> > > http://bugzilla.kernel.org/show_bug.cgi?id=11841
> > > "plenty of line "ACPI: EC: non-query interrupt received,
> > >  switching to interrupt mode" in dmesg"
> > >
> > > Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> > > Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> > > Signed-off-by: Len Brown <len.brown@intel.com>
> > >   
> > I see the EC patches that cause this issue are part of 2.6.27-stable. 
> > So I think this patch should also be applied to the -stable tree.
> 
> Good point, it should.

Ok, what is the git commit id that should be added to the .27-stable
tree?

thanks,

greg k-h
