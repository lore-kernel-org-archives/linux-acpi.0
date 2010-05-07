From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] pci: Ensure we re-enable devices on resume
Date: Fri, 7 May 2010 13:43:38 -0700
Message-ID: <20100507204338.GA29461@kroah.com>
References: <1271943051-2671-1-git-send-email-mjg@redhat.com>
 <20100422161735.28dcc8b9@virtuousgeek.org>
 <20100422234653.GA4388@canonical.com>
 <20100423000819.GA6022@kroah.com>
 <20100425042149.GA3010@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:50276 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756356Ab0EGVK6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 May 2010 17:10:58 -0400
Content-Disposition: inline
In-Reply-To: <20100425042149.GA3010@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@canonical.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg@redhat.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, sta

On Sat, Apr 24, 2010 at 10:21:49PM -0600, Alex Chiang wrote:
> * Greg KH <greg@kroah.com>:
> > On Thu, Apr 22, 2010 at 05:46:53PM -0600, Alex Chiang wrote:
> > > * Jesse Barnes <jbarnes@virtuousgeek.org>:
> > > > Matthew Garrett <mjg@redhat.com> wrote:
> > > > 
> > > > > If the firmware puts a device back into D0 state at
> > > > > resume time, we'll update its state in resume_noirq and
> > > > > thus skip the platform resume code. Calling that code
> > > > > twice should be safe and we ought to avoid getting to
> > > > > that point anyway, so remove the check and also allow the
> > > > > platform pci code to be called for D0.
> > > > > 
> > > > > Fixes USB not being powered after resume on recent Lenovo
> > > > > machines.
> > > > > 
> > > > 
> > > > Applied to for-linus, thanks.
> > > 
> > > Stable, can you please pick this up too?
> > 
> > When it goes into Linus's tree, yes.  Care to let me know what
> > the git commit id of it is when that happens?
> 
> commit cc2893b6af5265baa1d68b17b136cffca9e40cfa

Now queued up.

thanks,

greg k-h
