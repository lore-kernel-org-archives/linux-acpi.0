From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: cpufreq frequencies off for Core 2 Duo E6600 "Conroe"
Date: Wed, 25 Oct 2006 22:49:21 -0400
Message-ID: <20061026024921.GA18459@dominikbrodowski.de>
References: <1160440863.4575.69.camel@mhcln03>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.239.214.66]:44180 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1422879AbWJZDIg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Oct 2006 23:08:36 -0400
Content-Disposition: inline
In-Reply-To: <1160440863.4575.69.camel@mhcln03>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Hentges <oe@hentges.net>
Cc: linux-acpi@vger.kernel.org

Hi,

On Tue, Oct 10, 2006 at 02:41:03AM +0200, Matthias Hentges wrote:
> I'm the happy user of a shiny new C2D E6600 CPU. While cpufreq works, it
> only offers support for the lowest possible frequency (1596MHz)

That's probably because the BIOS only exposes the lowest and the highest
frequency.

> There is another thing bugging me with cpufreq:
> +root@mhcln01:../system/cpu/cpu0/cpufreq >cat scaling_cur_freq 
> 1596000
> +root@mhcln01:../system/cpu/cpu0/cpufreq >cat cpuinfo_cur_freq 
> 1596000
> 
> Since the machine is overclocked to FSB301 (2.7GHz), the output above is
> clearly wrong (should read 6 x 301 = 1806MHz). I wonder if it would be
> possible to replace the output with the real frequency, not some
> hard-wired frequency/vcore value?

Not easily.

	Dominik
