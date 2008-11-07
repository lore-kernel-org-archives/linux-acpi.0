From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [stable] [PATCH 21/21] ACPI: EC: make kernel messages more useful when GPE storm is detected
Date: Fri, 7 Nov 2008 23:15:24 +0100
Message-ID: <200811072315.25227.rjw@sisk.pl>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org> <200811071454.25304.rjw@sisk.pl> <20081107184926.GC2320@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38394 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009AbYKGWKq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Nov 2008 17:10:46 -0500
In-Reply-To: <20081107184926.GC2320@kroah.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-acpi@vger.kernel.org, stable@kernel.org, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>

On Friday, 7 of November 2008, Greg KH wrote:
> On Fri, Nov 07, 2008 at 02:54:24PM +0100, Rafael J. Wysocki wrote:
> > On Friday, 7 of November 2008, Alan Jenkins wrote:
> > > Len Brown wrote:
> > > > From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> > > >
> > > > Make sure we can tell if the GPE storm workaround gets activated,
> > > > and avoid flooding the logs afterwards.
> > > >
> > > > http://bugzilla.kernel.org/show_bug.cgi?id=11841
> > > > "plenty of line "ACPI: EC: non-query interrupt received,
> > > >  switching to interrupt mode" in dmesg"
> > > >
> > > > Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> > > > Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> > > > Signed-off-by: Len Brown <len.brown@intel.com>
> > > >   
> > > I see the EC patches that cause this issue are part of 2.6.27-stable. 
> > > So I think this patch should also be applied to the -stable tree.
> > 
> > Good point, it should.
> 
> Ok, what is the git commit id that should be added to the .27-stable
> tree?

Not yet in the Linus' tree, I'll let you know when it's merged.

Thanks,
Rafael
