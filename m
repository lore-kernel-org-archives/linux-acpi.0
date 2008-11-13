From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH 21/21] ACPI: EC: make kernel messages more
	useful when GPE storm is detected
Date: Thu, 13 Nov 2008 13:46:24 -0800
Message-ID: <20081113214624.GA15628@kroah.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org> <200811072315.25227.rjw@sisk.pl> <20081111212322.GA6123@kroah.com> <200811130034.53634.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33735 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756469AbYKMWO2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Nov 2008 17:14:28 -0500
Content-Disposition: inline
In-Reply-To: <200811130034.53634.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, stable@kernel.org, Len Brown <len.brown@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Thu, Nov 13, 2008 at 12:34:52AM +0100, Rafael J. Wysocki wrote:
> On Tuesday, 11 of November 2008, Greg KH wrote:
> > On Fri, Nov 07, 2008 at 11:15:24PM +0100, Rafael J. Wysocki wrote:
> > > On Friday, 7 of November 2008, Greg KH wrote:
> > > > On Fri, Nov 07, 2008 at 02:54:24PM +0100, Rafael J. Wysocki wrote:
> > > > > On Friday, 7 of November 2008, Alan Jenkins wrote:
> > > > > > Len Brown wrote:
> > > > > > > From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> > > > > > >
> > > > > > > Make sure we can tell if the GPE storm workaround gets activated,
> > > > > > > and avoid flooding the logs afterwards.
> > > > > > >
> > > > > > > http://bugzilla.kernel.org/show_bug.cgi?id=11841
> > > > > > > "plenty of line "ACPI: EC: non-query interrupt received,
> > > > > > >  switching to interrupt mode" in dmesg"
> > > > > > >
> > > > > > > Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> > > > > > > Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> > > > > > > Signed-off-by: Len Brown <len.brown@intel.com>
> > > > > > >   
> > > > > > I see the EC patches that cause this issue are part of 2.6.27-stable. 
> > > > > > So I think this patch should also be applied to the -stable tree.
> > > > > 
> > > > > Good point, it should.
> > > > 
> > > > Ok, what is the git commit id that should be added to the .27-stable
> > > > tree?
> > > 
> > > Not yet in the Linus' tree, I'll let you know when it's merged.
> > 
> > Thank you for doing this.
> 
> Here:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f8248434e6a11d7cd314281be3b39bbcf82fc243
> 
> The other EC patches in this merge are also regarded as -stable material,
> but let's wait a couple of days to avoid possible regressions (although Alex
> thinks there sould be none ;-)).

Now applied.

If there's other git ids that should also be added, please let me know
what they are.

thanks,

greg k-h
