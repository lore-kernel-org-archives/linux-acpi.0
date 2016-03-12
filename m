From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 0/2] Use acpi_dev_present()
Date: Sat, 12 Mar 2016 18:31:36 +0100
Message-ID: <20160312173135.GA27059@wunner.de>
References: <cover.1453060661.git.lukas@wunner.de>
 <20160119211229.GB3253@malice.jf.intel.com>
 <5367662.pAQ7mO39ru@vostro.rjw.lan>
 <20160211183157.GA15803@wunner.de>
 <CAJZ5v0gRYiWDSd-hgMPiBEAOEif8sdc-W=Ot5fibPUMv_EE+Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gRYiWDSd-hgMPiBEAOEif8sdc-W=Ot5fibPUMv_EE+Jg@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, platform-driver-x86@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Corentin Chary <corentin.chary@gmail.com>, acpi4asus-user@lists.sourceforge.net, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

I've noticed only now that the PCI core has 2 separate functions
for detecting presence of a device, pci_dev_present() which only
searches the list of enumerated devices, and pci_device_is_present(),
which tests actual presence by reading from the device's config space.

Thus it would actually be consistent to have acpi_dev_present()
(only searches namespace) and acpi_device_is_present() (calls _STA).

But I assume you still want it renamed, right? Just to clarify.

Thanks,

Lukas

On Wed, Mar 09, 2016 at 11:21:18PM +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 11, 2016 at 7:31 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > Hi Rafael,
> >
> > thanks a lot for your patience.
> >
> > On Tue, Jan 19, 2016 at 10:59:04PM +0100, Rafael J. Wysocki wrote:
> >> On Tuesday, January 19, 2016 01:12:29 PM Darren Hart wrote:
> >> > On Sun, Jan 17, 2016 at 09:49:41PM +0100, Lukas Wunner wrote:
> >> > > Hi Darren,
> >> > >
> >> > > the acpi_dev_present() API has now landed in Linus' tree.
> >> > > Thus, after Linus' tree gets merged back into yours,
> >> > > it would be possible to use the API in the pdx86 drivers
> >> > > as per the following patches.
> >> > >
> >> > > I've also pushed these to GitHub in case anyone prefers
> >> > > perusing them in a browser:
> >> > > https://github.com/l1k/linux/commits/acpi_dev_present_pdx86
> >> > >
> >> > > This is a repost of patches submitted in November, the only
> >> > > change is one line added to the commit messages to reference
> >> > > the commit which introduces the API:
> >> > > http://thread.gmane.org/gmane.linux.alsa.devel/147414/focus=8004
> >> > > http://thread.gmane.org/gmane.linux.alsa.devel/147414/focus=8005
> >> >
> >> > Who's tree did the API make it in through? That would likely be the best tree to
> >> > pull these 2 patches in from.
> >> >
> >> > Robert, Lv, Rafael? Would one of you prefer to take these 2 patches using the
> >> > new API?
> >>
> >> It was my tree and I can take these patches, but in that case I'd like the
> >> function's name to be changed as discussed elsewhere.
> >>
> >> Executive summary is that we have acpi_dev_present() and acpi_device_is_present()
> >> now and they serve different purposes which is kind of confusing.  Moreover,
> >> acpi_dev_present() doesn't check if the device is actually present, so
> >> I would like it to be renamed to acpi_device_found() or similar.
> >
> > There are 4 users of acpi_dev_present in linux-next (3 in sound/soc/intel/,
> > 1 in include/linux/apple-gmux.h). I expect 1 other user to appear in i915.
> >
> > I've created a patch (based on linux-next and included below as an RFC)
> > to rename acpi_dev_present to acpi_dev_found in the function declaration
> > as well as at all call sites. I've also rebased the 2 pdx86 patches onto
> > this and pushed the branch to GitHub:
> > https://github.com/l1k/linux/commits/acpi_dev_found
> >
> > My plan is currently to wait until all users are merged into 4.6,
> > then rebase my branch onto Linus' tree and post the resulting patches.
> > This will be either late during the 4.6 merge window or immediately
> > after it has closed. You could then either pick up the patches for
> > 4.6 or 4.7, whichever you prefer.
> >
> > If you'd prefer a different way of moving forward or would like
> > something changed in the patch below, please let me know and
> > I will be happy to adjust accordingly.
> 
> Thanks for doing this!
> 
> Your plan seems workable to me, so please go ahead with it.
> 
> Thanks,
> Rafael
