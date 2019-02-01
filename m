From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] nfit: add Hyper-V NVDIMM DSM command set to white list
Date: Fri, 1 Feb 2019 09:29:27 -0800
Message-ID: <CAPcyv4haUouYs_Vfju2SMvjcwc7rqY06zqT8NJ-3uakGMZSu0w@mail.gmail.com>
References: <PU1P153MB01690EDA138D3ABDE5B4A482BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4jD1oRWzA4ZiMYZm1uxsbOdgqzbb9raH70-HBDqapcE_g@mail.gmail.com> <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Dexuan Cui <decui@microsoft.com>
Cc: Ross Zwisler <zwisler@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Josh Poulson <jopoulso@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>, KY Srinivasan <kys@microsoft.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 1, 2019 at 9:14 AM Dexuan Cui <decui@microsoft.com> wrote:
>
> > From: Dan Williams <dan.j.williams@intel.com>
> > Sent: Tuesday, January 29, 2019 10:24 PM
> > On Mon, Jan 28, 2019 at 4:56 PM Dexuan Cui <decui@microsoft.com> wrote:
> > >
> > >
> > > Add the Hyper-V _DSM command set to the white list of NVDIMM command
> > > sets.
> > >
> > > Thanks Dan Williams <dan.j.williams@intel.com> for writing the
> > > comment change.
> > > ---
> > > Changes in v2:
> > >     Updated the comment and changelog (Thanks, Dan!)
> > >     Rebased to the tag libnvdimm-fixes-5.0-rc4 of the nvdimm tree.
> >
> > Thanks for the re-spin, applied.
>
> Hi Dan,
> Unluckily it looks this commit causes a regression on
> https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/log/?h=libnvdimm-pending
>
> With the patch, "ndctl list" shows nothing, and /dev/pmem0 can't appear.
> If I revert the patch, it will be back to normal.
>
> I attached the config/logs. In the bad case, "dmesg" shows a line
> [    5.259017] nd_pmem namespace0.0: 0x0000000000000000, too small must be at least 0x1000
>
> Any idea why this happens? I'm digging into the details and I appreciate your insights.

Looks like it is working as expected. The regression you are seeing is
the fact that the patch enables the kernel to enable
nvdimm-namespace-label reads. Those reads find a namespace index block
and a label. Unfortunately the label has the LOCAL flag set and Linux
explicitly ignores pmem namespace labels with that bit set. The reason
for that is due to the fact that the original definition of the LOCAL
bit from v1.1 of the namespace label implementation [1] explicitly
limited the LOCAL flag to "block aperture" regions. If you clear that
LOCAL flag I expect it will work. To my knowledge Windows pretends
that the v1.1 definition never existed.

The UEFI 2.7 specification for v1.2 labels states that setting the
LOCAL flag is optional when "nlabel", number of labels in the set, is
1. Linux makes that mandatory as LOCAL is redundant when nlabel is 1.

That said, the Robustness Principle makes a case that Linux should
tolerate the bit being set. However, it's just a non-trivial amount of
work to unwind the ingrained block-aperture assumptions of that bit.

[1]: http://pmem.io/documents/NVDIMM_Namespace_Spec.pdf
