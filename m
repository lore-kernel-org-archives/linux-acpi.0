From: Alex Chiang <achiang@canonical.com>
Subject: Re: [PATCH] pci: Ensure we re-enable devices on resume
Date: Thu, 22 Apr 2010 17:46:53 -0600
Message-ID: <20100422234653.GA4388@canonical.com>
References: <1271943051-2671-1-git-send-email-mjg@redhat.com>
 <20100422161735.28dcc8b9@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100422161735.28dcc8b9@virtuousgeek.org>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Matthew Garrett <mjg@redhat.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, stable@kernel.org
List-Id: linux-acpi@vger.kernel.org

* Jesse Barnes <jbarnes@virtuousgeek.org>:
> On Thu, 22 Apr 2010 09:30:51 -0400
> Matthew Garrett <mjg@redhat.com> wrote:
> 
> > If the firmware puts a device back into D0 state at resume time, we'll
> > update its state in resume_noirq and thus skip the platform resume code.
> > Calling that code twice should be safe and we ought to avoid getting to
> > that point anyway, so remove the check and also allow the platform pci
> > code to be called for D0.
> > 
> > Fixes USB not being powered after resume on recent Lenovo machines.
> > 
> > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> 
> Applied to for-linus, thanks.

Thanks Jesse. 

Stable, can you please pick this up too?

The original commit that introduced the thinko was 4a865905.

achiang@aspen:~/kernels/linux-2.6$ git describe --contains 4a865905
v2.6.30-rc1~609^2~4

which looks like it was introduced in 2.6.30, but I'd be happy with
just hitting v2.6.32, since this is what just about every distro
has settled on these days.

Thanks,
/ac
