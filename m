From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH]: cpufreq: pcc-cpufreq: don't load driver if get_freq
 fails during init.
Date: Wed, 9 Mar 2011 08:27:23 -0800
Message-ID: <20110309162723.GA31459@suse.de>
References: <20110309135906.6554.54389.sendpatchset@nchumbalkar.americas.hpqcorp.net>
 <201103091709.40464.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201103091709.40464.trenn@suse.de>
Sender: cpufreq-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Naga Chumbalkar <nagananda.chumbalkar@hp.com>, Dave Jones <davej@codemonkey.org.uk>, linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 09, 2011 at 05:09:40PM +0100, Thomas Renninger wrote:
> Good catch.
> 
> On Wednesday, March 09, 2011 03:02:49 PM Naga Chumbalkar wrote:
> > 
> > Return 0 on failure. This will cause the initialization of the driver
> > to fail and prevent the driver from loading if the BIOS cannot handle
> > the PCC interface command to "get frequency". Otherwise, the driver
> > will load and display a very high value like "4294967274" (which is
> > actually -EINVAL) for frequency:
> > 
> > # cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
> > 4294967274
> > 
> > Signed-off-by: Naga Chumbalkar <nagananda.chumbalkar@hp.com>
> Reviewed-by: Thomas Renninger <trenn@suse.de>
> 
> While this is not a regression, it's an easy fix.
> It should make sense to add:
> CC: stable@kernel.org
> ?

Yes you should :)

thanks,

greg k-h
