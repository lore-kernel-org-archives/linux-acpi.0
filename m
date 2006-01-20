From: Karol Kozimor <sziwan@hell.org.pl>
Subject: Re: wake-on-lan
Date: Fri, 20 Jan 2006 06:16:35 +0100
Message-ID: <20060120051635.GA30662@hell.org.pl>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CECE@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hell.org.pl ([62.233.239.4]:36370 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S1161314AbWATFQu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jan 2006 00:16:50 -0500
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CECE@hdsmsx401.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Joseph Dunn <jdunn14@hotpop.com>, linux-acpi@vger.kernel.org

Thus wrote Brown, Len:
> >When I halt the machine (shutdown -h) I cannot
> >wake it.  However, if the machine is unplugged, then plugged back in,
> >*then* I can wake it. 
> 
> WOL can be done a couple of ways.
> 
> If it is implemented using ACPI GPE's, then
> you need to find a string (unfortunately, they're arbitrary)
> in /proc/acpi/wakeup that looks like your device and echo that
> string into the file to toggle between enabled and disabled.
> 
> Only Power/Sleep/LID buttons are enabled for wakeup by default.
> 
> Note that this I/F is temporary -- the ability of
> a device to wake the system should really be a property
> of that device in the /sys tree.

Note also that there are very few explicit calls to pci_enable_wake() in
the whole tree. Linux doesn't set the PME-Enable bit properly, which
apparently results in WOL either working or not working. My understanding
is that the final outcome depends on what BIOS does to the card during
POST. Please see http://bugme.osdl.org/show_bug.cgi?id=3801 for a weird 
example.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
