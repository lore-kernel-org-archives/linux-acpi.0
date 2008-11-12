From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [stable] [PATCH 21/21] ACPI: EC: make kernel messages more useful when GPE storm is detected
Date: Thu, 13 Nov 2008 00:34:52 +0100
Message-ID: <200811130034.53634.rjw@sisk.pl>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org> <200811072315.25227.rjw@sisk.pl> <20081111212322.GA6123@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60106 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794AbYKLXaN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2008 18:30:13 -0500
In-Reply-To: <20081111212322.GA6123@kroah.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, stable@kernel.org, Len Brown <len.brown@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Tuesday, 11 of November 2008, Greg KH wrote:
> On Fri, Nov 07, 2008 at 11:15:24PM +0100, Rafael J. Wysocki wrote:
> > On Friday, 7 of November 2008, Greg KH wrote:
> > > On Fri, Nov 07, 2008 at 02:54:24PM +0100, Rafael J. Wysocki wrote:
> > > > On Friday, 7 of November 2008, Alan Jenkins wrote:
> > > > > Len Brown wrote:
> > > > > > From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> > > > > >
> > > > > > Make sure we can tell if the GPE storm workaround gets activated,
> > > > > > and avoid flooding the logs afterwards.
> > > > > >
> > > > > > http://bugzilla.kernel.org/show_bug.cgi?id=11841
> > > > > > "plenty of line "ACPI: EC: non-query interrupt received,
> > > > > >  switching to interrupt mode" in dmesg"
> > > > > >
> > > > > > Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> > > > > > Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> > > > > > Signed-off-by: Len Brown <len.brown@intel.com>
> > > > > >   
> > > > > I see the EC patches that cause this issue are part of 2.6.27-stable. 
> > > > > So I think this patch should also be applied to the -stable tree.
> > > > 
> > > > Good point, it should.
> > > 
> > > Ok, what is the git commit id that should be added to the .27-stable
> > > tree?
> > 
> > Not yet in the Linus' tree, I'll let you know when it's merged.
> 
> Thank you for doing this.

Here:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f8248434e6a11d7cd314281be3b39bbcf82fc243

The other EC patches in this merge are also regarded as -stable material,
but let's wait a couple of days to avoid possible regressions (although Alex
thinks there sould be none ;-)).

Thanks,
Rafael
