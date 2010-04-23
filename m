From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] pci: Ensure we re-enable devices on resume
Date: Thu, 22 Apr 2010 17:08:20 -0700
Message-ID: <20100423000819.GA6022@kroah.com>
References: <1271943051-2671-1-git-send-email-mjg@redhat.com>
 <20100422161735.28dcc8b9@virtuousgeek.org>
 <20100422234653.GA4388@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:41028 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754178Ab0DWAOp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Apr 2010 20:14:45 -0400
Content-Disposition: inline
In-Reply-To: <20100422234653.GA4388@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@canonical.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg@redhat.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, sta

On Thu, Apr 22, 2010 at 05:46:53PM -0600, Alex Chiang wrote:
> * Jesse Barnes <jbarnes@virtuousgeek.org>:
> > On Thu, 22 Apr 2010 09:30:51 -0400
> > Matthew Garrett <mjg@redhat.com> wrote:
> > 
> > > If the firmware puts a device back into D0 state at resume time, we'll
> > > update its state in resume_noirq and thus skip the platform resume code.
> > > Calling that code twice should be safe and we ought to avoid getting to
> > > that point anyway, so remove the check and also allow the platform pci
> > > code to be called for D0.
> > > 
> > > Fixes USB not being powered after resume on recent Lenovo machines.
> > > 
> > > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> > 
> > Applied to for-linus, thanks.
> 
> Thanks Jesse. 
> 
> Stable, can you please pick this up too?

When it goes into Linus's tree, yes.  Care to let me know what the git
commit id of it is when that happens?

thanks,

greg k-h
