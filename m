From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] nfit: add Hyper-V NVDIMM DSM command set to white list
Date: Fri, 1 Feb 2019 21:27:47 -0800
Message-ID: <CAPcyv4iv1dbAZ89OXizzHDucU0y254NC3CBW3pQ2hMER0gTk9Q@mail.gmail.com>
References: <PU1P153MB01690EDA138D3ABDE5B4A482BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4jD1oRWzA4ZiMYZm1uxsbOdgqzbb9raH70-HBDqapcE_g@mail.gmail.com>
 <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4haUouYs_Vfju2SMvjcwc7rqY06zqT8NJ-3uakGMZSu0w@mail.gmail.com>
 <PU1P153MB01694FCAF062E089059CD441BF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4gdWJ8qtiASU9ggz56Mkrm9OXfsO74RM9OOrXFmBw_A9Q@mail.gmail.com>
 <PU1P153MB0169D8F7C6E29C22FE122F3FBF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <PU1P153MB0169D661955195EA070E7EF0BF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4iEcCG0h+HLPkfSC0aNDLq9hdoO00XErF93PHTmEgO-TQ@mail.gmail.com> <PU1P153MB0169FBCCB5639054FC0E6DB6BF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <PU1P153MB0169FBCCB5639054FC0E6DB6BF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Dexuan Cui <decui@microsoft.com>
Cc: Josh Poulson <jopoulso@microsoft.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Haiyang Zhang <haiyangz@microsoft.com>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Ross Zwisler <zwisler@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 1, 2019 at 6:17 PM Dexuan Cui <decui@microsoft.com> wrote:
> > From: Dan Williams <dan.j.williams@intel.com>
[..]
> > Honestly, the quickest path to something functional for Linux is to
> > simply delete the _LSR support and use raw mode defined namespaces.
> > Why have labels if they are read-only and the region is sufficient for
> > defining boundaries?
>
> Just now Hyper-V team confirmed _LSW is not supported.
>
> But with Ubuntu 19.04 kernel (4.18.0-11-generic), I'm able to run the commands
> without any issue:

This is because Ubuntu is running in "label-less" mode. So all the
writes it is performing for namespace reconfiguration are just going
to the data-space of the region, not the labels.
