From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: why use acpi for cpufreq?
Date: Tue, 31 Oct 2006 19:04:42 +0100
Message-ID: <20061031180442.GA4297@isilmar.linta.de>
References: <454684D9.1080805@blakeley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.239.214.66]:57229 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1422840AbWJaSEo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Oct 2006 13:04:44 -0500
Content-Disposition: inline
In-Reply-To: <454684D9.1080805@blakeley.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michael Blakeley <mike@blakeley.com>
Cc: linux-acpi@vger.kernel.org

Hi,

On Mon, Oct 30, 2006 at 03:03:53PM -0800, Michael Blakeley wrote:
> I've recently been bitten by 
> http://bugzilla.kernel.org/show_bug.cgi?id=7157 - I also have an HP 
> nc6400, with bios F.05, and can't downgrade to F.03 because my CPU only 
> became supported in F.05. While I'm waiting to see if HP will fix this 
> problem in a future bios rev, I wondered why cpufreq needs any bios 
> information in the first place?
> 
> This is all well outside my technical expertise, so I'm sure that I'm 
> misunderstanding the problem - but that's why I'm asking. Basically my 
> question is: why can't cpufreq interrogate the CPU directly, in order to 
> find out what sort of cpu frequency scaling it supports (SpeedStep in 
> various flavors, PowerNow, and whatever else is out there in the wild)? 
> Wouldn't that be more robust than relying on the bios to get it right?

Unfortunately, no -- it is not only a matter of the processor on whether CPU
frequency and voltage scaling is supported, but also a matter of the
motherboard. Not all combinations of frequencies and voltages which run
stable on one notebook may run well on a different notebook with the same
CPU. Therefore, such hardcoded table-based approaches are only available in
rare cases.

	Dominik
