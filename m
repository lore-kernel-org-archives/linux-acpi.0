From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Fri, 21 Jul 2017 14:01:31 -0300
Message-ID: <20170721140131.40079805@vento.lan>
References: <20170718060007.GB8736@nazgul.tnic>
 <1500407379.2042.21.camel@hpe.com>
 <20170718181545.32bd9181@vento.lan>
 <1500481869.2042.29.camel@hpe.com>
 <20170720043344.GC14367@nazgul.tnic>
 <1500579646.2042.37.camel@hpe.com>
 <20170721133441.GB5036@nazgul.tnic>
 <20170721104001.3cd2b884@vento.lan>
 <20170721134715.GC5036@nazgul.tnic>
 <1500649162.2042.43.camel@hpe.com>
 <20170721151317.GA13424@nazgul.tnic>
 <1500650732.2042.45.camel@hpe.com>
 <20170721124401.5f94aba9@vento.lan>
 <1500654661.2042.49.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500654661.2042.49.camel@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Em Fri, 21 Jul 2017 16:40:20 +0000
"Kani, Toshimitsu" <toshi.kani@hpe.com> escreveu:

> On Fri, 2017-07-21 at 12:44 -0300, Mauro Carvalho Chehab wrote:
> > Em Fri, 21 Jul 2017 15:34:50 +0000
> > "Kani, Toshimitsu" <toshi.kani@hpe.com> escreveu:
> >   
> > > On Fri, 2017-07-21 at 17:13 +0200, Borislav Petkov wrote:  
> > > > On Fri, Jul 21, 2017 at 03:08:41PM +0000, Kani, Toshimitsu
> > > > wrote:    
> > > > > Yes, that is correct.  Corrected errors are reported to the OS
> > > > > when they exceeded the platform's threshold.    
> > > > 
> > > > Are those thresholds user-configurable?    
> > > 
> > > I suppose it'd depend on vendors, but I do not think users can do
> > > it properly unless they have depth knowledge about the hardware.
> > >   
> > > > If not, what are you telling users who want to see *every*
> > > > corrected error for measuring DIMM wear and so on...?    
> > > 
> > > Corrected errors are normal and expected to occur on healthy
> > > hardware.  They do not need user's attention until they repeatedly
> > > occurred at a same place.  
> > 
> > Yes, they're expected to happen. Still, some sys admins have their
> > own measurements about what's "normal" for their scenario, and want
> > to monitor every single corrected error, running their own
> > algorithm to warn if the number of corrected errors is above their
> > "normal" rate.  
> 
> I suppose these admins had to do it because their platforms reported
> all corrected errors.  It addresses such administrators' burden.

I see the value of having a threshold in BIOS, provided that it is
well documented, and whose value can be adjusted, if needed.

One of the things I wanted to implement in ras-daemon were an
algorithm that would be doing such threshold in software.
The problem is that it would require field experience. So,
I talked with a few vendors, to see if they could help doing
it, but, on that time, none rised their hands :-)

The thing with a BIOS threshold is that the user has no way to
audit the algorithm. So, when BIOS start reporting such errors,
it may be already too late: the systems may be in the verge of 
losing data (or some data was already lost).

That's critical on cluster systems with thousands of machines:
while the impact of disabling a cluster node to do some maintainance
is marginal, the impact of an uncorrected error on a single
machine may compromise weeks of expensive processing.

That's why some users prefer to monitor every single corrected
error, and compare with the probability distribution they
know that the risk of uncorrected errors is acceptable.

Thanks,
Mauro
