From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Tue, 18 Jul 2017 18:15:45 -0300
Message-ID: <20170718181545.32bd9181@vento.lan>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
        <20170717215912.26070-4-toshi.kani@hpe.com>
        <20170718060007.GB8736@nazgul.tnic>
        <1500407379.2042.21.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:58740
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751500AbdGRVPz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Jul 2017 17:15:55 -0400
In-Reply-To: <1500407379.2042.21.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "tony.luck@intel.com" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

Em Tue, 18 Jul 2017 19:58:54 +0000
"Kani, Toshimitsu" <toshi.kani@hpe.com> escreveu:

> On Tue, 2017-07-18 at 08:00 +0200, Borislav Petkov wrote:
> > On Mon, Jul 17, 2017 at 03:59:12PM -0600, Toshi Kani wrote:  
> > > The ghes_edac driver was introduced in 2013 [1], but it has not
> > > been enabled by any distro yet.  This driver obtains error info
> > > from firmware interfaces, which are not properly implemented on
> > > many platforms, as the driver always emits the messages below:
> > > 
> > >  This EDAC driver relies on BIOS to enumerate memory and get error
> > > reports.  Unfortunately, not all BIOSes reflect the memory layout
> > > correctly  So, the end result of using this driver varies from
> > > vendor to vendor  If you find incorrect reports, please contact
> > > your hardware vendor  to correct its BIOS.
> > > 
> > > To get out from this situation, add a platform type check to
> > > selectively enable the driver on the platforms that are known to
> > > have proper firmware implementation.  Platform vendors can add
> > > their platforms to the list when they support ghes_edac.  
> > 
> > So maintaining whitelists for things has always been a PITA and we
> > should try to avoid it, if possible. (We can always do it if nothing
> > saner comes along.)  
> 
> Agreed.
> 
> > Now, below is a dirty patch converting ghes_edac to a normal module.
> > On systems where we have GHES, the firmware generally disables the
> > detection of the presence of ECC hardware, thus preventing the
> > platform EDAC driver from loading.  
> 
> I have HPE Haswell and Skylake test systems with GHES, but they do not
> hide IMCs from the OS.  So, the sb_edac and skx_edac drivers get
> attached on these systems when ghes_edac is disabled.
> 
> > Let me clarify: I have an AMD HP box which, when GHES is enabled in
> > the BIOS, says that ECC is disabled in the memory controller and the
> > amd64_edac driver doesn't load for that memory controller.  
> 
> Hmm... what's the platform name of this box?  I can look into this case
> if you need.
> 
> > And I think we should try this first: have the firmware disable
> > detection methods so that the platform drivers don't load.  
> 
> I do not think we can rely on this method.
> 
> > Then, ghes_edac can be a simple module and no other driver would
> > attempt loading.  
> 
> I like the use of notifier chain, which is much cleaner.
> 
> > The question is: does the platform do this disabling now?  
> 
> Unfortunately, that is not the case today.  The IMCs cannot be hidden
> with the Device Hide registers for Skylake at least.

We had a similar discussion several years ago when I wrote this driver.
On that time, I talked with Red Hat, HP, Dell, Intel people and with
some customers with large clusters.

The way it is, ghes_edac is a poor man's driver. What it hopefully
provide is a detection that an error happened, without really telling
the user what component should be replaced.

Ok, on machines with their own error reporting mechanism (like
HP servers), a sys admin can look on some proprietary software
(or bios), in order to identify what happened.

Yet, BIOS doesn't provide any glue about what's the memory architecture,
as it maps memory as if it was a single DIMM memory:

(from ghes_edac_register)

	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
	layers[0].size = num_dimm;
	layers[0].is_virt_csrow = true;

So, even on systems where the BIOS actually knows how the memory
cards are wired, it will mask the memory controller data.

Now, the EDAC driver can also be used to identify what
channels are used. That helps the sys admin to know if the
memories are connected in a way that it will be using multiple
channels, or not, helping to setup the machine to obtain
the maximum possible performance.

So, for example, on my Intel-based HP server, I can check
such info with:

$ ras-mc-ctl --mainboard
ras-mc-ctl: mainboard: HP model ProLiant ML350 Gen9
$ ras-mc-ctl --layout
       +-----------------------------------------------------------------------+
       |                mc0                |                mc1                |
       | channel0  | channel1  | channel2  | channel0  | channel1  | channel2  |
-------+-----------------------------------------------------------------------+
slot2: |     0 MB  |     0 MB  |     0 MB  |     0 MB  |     0 MB  |     0 MB  |
slot1: |     0 MB  |     0 MB  |     0 MB  |     0 MB  |     0 MB  |     0 MB  |
slot0: |  16384 MB  |     0 MB  |  16384 MB  |  16384 MB  |     0 MB  |  16384 MB  |
-------+---------------------------------------------------------------------------+

So, I know that both CPUs will be connected to my memories, and,
on both, it is using 2 channels.

If I was using the ghes driver, that information would be hidden.

So, due to all problems with ghes, it is enabled only if there are no
better solution, e. g. on systems where there's no way to talk directly
to the hardware (like on E7 Xeon machines, where the memory controller
is actually on a separate chip that are controlled only by the BIOS).

Thanks,
Mauro
