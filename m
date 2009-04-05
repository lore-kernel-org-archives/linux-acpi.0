From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [Acpi4asus-user] [PATCH 1/1] cpufreq: eeepc 900 frequency scaling
	driver
Date: Sun, 5 Apr 2009 09:43:40 +0200
Message-ID: <71cd59b00904050043u44d1cd2eu4b8d3aee9027ea17@mail.gmail.com>
References: <1227454026.7262.59.camel@localhost> <492A7632.4040106@compton.nu>
	 <200811241613.25557.trenn@suse.de> <200811241736.53067.trenn@suse.de>
	 <1227567739.6421.44.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:55002 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbZDEHnp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Apr 2009 03:43:45 -0400
In-Reply-To: <1227567739.6421.44.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cristiano Prisciandaro <cristiano.p@solnet.ch>
Cc: Thomas Renninger <trenn@suse.de>, Dave Jones <davej@redhat.com>, acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, Tom Hughes <tom@compton.nu>, linux acpi <linux-acpi@vger.kernel.org>, Francesco Lattanzio <f.lattanzio@simail.it>, Matthew Garrett <mjg59@srcf.ucam.org>, Grigori Goronzy <greg@chown.ath.cx>

>> Could it happen that upcoming machines provide this interface (the two ACPI
>> functions) and also can do real CPU frequency/volt switching, e.g. via
>> acpi-cpufreq?
>
> Probably this interface is a solution specific to machines based on the
> celeron M: I don't even know if other 'old' models provide the same
> interface.

Hi,
We I just received another patch for that (adding a cpufv file in
sysfs) and I don't really know what to do.

As Grigori Goronzy said, using cpufreq in not a good idea:

> 1) dynamic governors like "ondemand" or "conservative" are not suitable
> for SHE. It's possible to avoid usage of these by specifying a long
> (e.g. UINT_MAX) transition latency. However, the fallback governor is
> "performance" which isn't a good idea either, because it'll use the
> overclock setting always. For SHE, the default should be the "normal",
> non-overclocked frequency.
>
> 2) The SHE ACPI interface doesn't expose the clock frequencies. I'm
> using 750 / 1000 / 1500 KHz at the moment, but that's hacky. cpufreq
> does not support performance points with names, such as "powersave",
> "normal", "performance", etc.
>
> 3) It looks like it is impossible to use more than one cpufreq driver
> per CPU. This effectively means you can either use the regular ACPI
> frequency scaling, which switches between multipliers, or SHE. That's
> unacceptable. SHE is not intended to replace the regular frequency
> scaling, but to complement it.

But adding another specific file for eeepc seems ugly too.
Does someone have a great idea to solve that ?

Thanks
-- 
Corentin Chary
http://xf.iksaif.net
