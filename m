From: Alex Chiang <achiang@canonical.com>
Subject: Re: [stable] [PATCH] pci: Ensure we re-enable devices on resume
Date: Sat, 24 Apr 2010 22:21:49 -0600
Message-ID: <20100425042149.GA3010@canonical.com>
References: <1271943051-2671-1-git-send-email-mjg@redhat.com>
 <20100422161735.28dcc8b9@virtuousgeek.org>
 <20100422234653.GA4388@canonical.com>
 <20100423000819.GA6022@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100423000819.GA6022@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg@redhat.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, stable@kernel.org
List-Id: linux-acpi@vger.kernel.org

* Greg KH <greg@kroah.com>:
> On Thu, Apr 22, 2010 at 05:46:53PM -0600, Alex Chiang wrote:
> > * Jesse Barnes <jbarnes@virtuousgeek.org>:
> > > Matthew Garrett <mjg@redhat.com> wrote:
> > > 
> > > > If the firmware puts a device back into D0 state at
> > > > resume time, we'll update its state in resume_noirq and
> > > > thus skip the platform resume code. Calling that code
> > > > twice should be safe and we ought to avoid getting to
> > > > that point anyway, so remove the check and also allow the
> > > > platform pci code to be called for D0.
> > > > 
> > > > Fixes USB not being powered after resume on recent Lenovo
> > > > machines.
> > > > 
> > > 
> > > Applied to for-linus, thanks.
> > 
> > Stable, can you please pick this up too?
> 
> When it goes into Linus's tree, yes.  Care to let me know what
> the git commit id of it is when that happens?

commit cc2893b6af5265baa1d68b17b136cffca9e40cfa

Thanks!
/ac
