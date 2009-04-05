From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [Acpi4asus-user] [PATCH 1/1] cpufreq: eeepc 900 frequency scaling driver
Date: Sun, 5 Apr 2009 11:20:57 +0100
Message-ID: <20090405102057.GA14089@srcf.ucam.org>
References: <1227454026.7262.59.camel@localhost> <492A7632.4040106@compton.nu> <200811241613.25557.trenn@suse.de> <200811241736.53067.trenn@suse.de> <1227567739.6421.44.camel@localhost> <71cd59b00904050043u44d1cd2eu4b8d3aee9027ea17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49476 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758474AbZDEKVL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Apr 2009 06:21:11 -0400
Content-Disposition: inline
In-Reply-To: <71cd59b00904050043u44d1cd2eu4b8d3aee9027ea17@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Cristiano Prisciandaro <cristiano.p@solnet.ch>, Thomas Renninger <trenn@suse.de>, Dave Jones <davej@redhat.com>, acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, Tom Hughes <tom@compton.nu>, linux acpi <linux-acpi@vger.kernel.org>, Francesco Lattanzio <f.lattanzio@simail.it>, Grigori Goronzy <greg@chown.ath.cx>

On Sun, Apr 05, 2009 at 09:43:40AM +0200, Corentin Chary wrote:
> >> Could it happen that upcoming machines provide this interface (the two ACPI
> >> functions) and also can do real CPU frequency/volt switching, e.g. via
> >> acpi-cpufreq?
> >
> > Probably this interface is a solution specific to machines based on the
> > celeron M: I don't even know if other 'old' models provide the same
> > interface.
> 
> Hi,
> We I just received another patch for that (adding a cpufv file in
> sysfs) and I don't really know what to do.
> 
> As Grigori Goronzy said, using cpufreq in not a good idea:

I'm not sure I agree. It's clear that ondemand and conservative aren't 
sensible choices with the driver, but beyond that...

> > 3) It looks like it is impossible to use more than one cpufreq driver
> > per CPU. This effectively means you can either use the regular ACPI
> > frequency scaling, which switches between multipliers, or SHE. That's
> > unacceptable. SHE is not intended to replace the regular frequency
> > scaling, but to complement it.

I don't think there's a terribly good reason to use the SHE methods if 
the CPU supports speedstep. 945 will automatically drop the frontside 
bus in the deepest P states. I'd be surprised if it gave any real world 
benefits on the atom based systems.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
