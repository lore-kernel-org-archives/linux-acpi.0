From: "Matthew Brett" <matthew.brett@gmail.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
Date: Tue, 16 Jan 2007 00:39:43 +0000
Message-ID: <1e2af89e0701151639i1b3e651dne117da0e55bd666f@mail.gmail.com>
References: <E3C0BCA40296C347AF7142161DB9FC8298F74B@mssmsx411>
	 <200701151006.15790.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:32981 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164AbXAPAjt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jan 2007 19:39:49 -0500
Received: by an-out-0708.google.com with SMTP id b33so939925ana
        for <linux-acpi@vger.kernel.org>; Mon, 15 Jan 2007 16:39:48 -0800 (PST)
In-Reply-To: <200701151006.15790.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Salatiel Filho <salatiel.filho@gmail.com>, linux-acpi@vger.kernel.org

Hi,

On 1/15/07, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> On Monday 15 January 2007 06:33, Karasyov, Konstantin A wrote:
> > The fan device FAN1 defines object FN01 as its power resource. _STA
> > method of FN01 always return 0x01, i.e. resource is on
>
> Ugh.  Matthew, have you checked to see whether there are any
> BIOS updates available for your box?

Ah - my machine is so ill-supported that I was afraid to try any
what-seemed-to-be-appropriate bios updates.

> > But, _ON and _OFF methods set \_TZ.THRM.FNON object to 1 and 0
> > respectively, so, I think, it could be used as value returned by _STA
> > method. Attached patch for DSDT should solve the fan issue.

For reference, it does solve the fan issue - fan stays on during boot,
echo 0 and 3 to  /proc/acpi/fan/*/state cause the fan to switch on and
off respectively.

> But we can't expect users to apply DSDT patches.  So if there's
> no BIOS update available, don't we have to figure out a way to
> work around it?  Maybe we could notice when the BIOS reports the
> device is "on" even when we've turned it off, decide that the
> BIOS is lying, and always use force_power_state.

>From a position of extreme ignorance, a workaround does sound safer -
it's such a dangerous problem,

Best,

Matthew
