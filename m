From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 15/16] platform/x86: wmi-mof: New driver to expose
 embedded WMI MOF metadata
Date: Mon, 5 Jun 2017 15:14:56 -0700
Message-ID: <20170605221456.GA27270@fury>
References: <cover.1495862272.git.dvhart@infradead.org>
 <27758381c6cb77efab75a266e21243a964cce0ba.1495862272.git.dvhart@infradead.org>
 <201705271314.16241@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201705271314.16241@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, May 27, 2017 at 01:14:15PM +0200, Pali Rohár wrote:
> Hi! Note that in WMI is stored binary MOF (BMOF; .bmf file; compiled 
> MOF), not ordinary MOF data which are plain text. So maybe it could make 
> sense to include "B" into name of sysfs entry? Or not? (Just suggestion)

Did some digging, and .... yeah, you're right.

I've replaced with MOF with Binary MOF or bmof throughout the patch. Will resend
in a v2. Thanks.

> 
> On Saturday 27 May 2017 07:31:29 Darren Hart wrote:
> > From: Andy Lutomirski <luto@kernel.org>
> > 
> > Quite a few laptops (and maybe servers?) have embedded WMI MOF
> 
> Not "a few", but "lots of" :-)

I'll just use "Many" and save us continued debate :-)

> 
> > metadata. I think that Samba has tools to interpret it, but there is
> > currently no interface to get the data in the first place.
> 
> No, there is no non-ms-windows tool for interpreting those binary MOF 
> (BMF) data yet.

Good point. Updated.

> 
> > +	priv->mofdata = wmidev_block_query(wdev, 0);
> > +	if (!priv->mofdata) {
> > +		dev_warn(&wdev->dev, "failed to read MOF\n");
> > +		return -EIO;
> > +	}
> > +
> > +	if (priv->mofdata->type != ACPI_TYPE_BUFFER) {
> > +		dev_warn(&wdev->dev, "MOF is not a buffer\n");
> > +		ret = -EIO;
> > +		goto err_free;
> > +	}
> 
> Are not those problems fatal for driver and therefore dev_err() better?
> 

Yes, agreed. Updated.

> > +	sysfs_bin_attr_init(&priv->mof_bin_attr);
> > +	priv->mof_bin_attr.attr.name = "mof";
> > +	priv->mof_bin_attr.attr.mode = 0400;
> 
> 0400 means to be readable only by root? Is there then reason why normal 
> user should not be able to read it?
> 

We can always open access up, harder to lock it down later. Let's start with
this and adjust if necessary.

-- 
Darren Hart
VMware Open Source Technology Center
