From: Thomas Renninger <trenn@suse.de>
Subject: Re: annoying fan problem
Date: Wed, 22 Feb 2006 21:03:21 +0100
Message-ID: <200602222103.21942.trenn@suse.de>
References: <43FA58FE.80700@tzi.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:17816 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751404AbWBVUDY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Feb 2006 15:03:24 -0500
In-Reply-To: <43FA58FE.80700@tzi.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Janosch Machowinski <scotch@tzi.de>
Cc: linux-acpi@vger.kernel.org

On Tuesday 21 February 2006 01:04, Janosch Machowinski wrote:
> Hey folks,
> I got an annoying problem with my fan, when I boot the system,
> it is allways on, with full speed. If I start compiling some stuff,
> or use BurnP6 to get the CPU over 65 degrees, the fan starts
> to behave right and goes into passive mode on cooldown.
> The notebook is an Asus M68Ne and has the latest bios installed.
> cat trip_points shows :
> critical (S5):           105 C
> passive:                 100 C: tc1=2 tc2=10 tsp=100 devices=0xc14d5ea0
> 
> cat cooling_mode
> <setting not supported>
> cooling mode:   passive
> 
There are  more people out there with different kind of fan problems.

1. Does grep _WDG /proc/acpi/dsdt matches?
2. Is this only when resuming from a suspend?
3. Do you get semaphore/mutex errors in the latest 2.6.16-rc3 or higher
   kernels?

Best is you grep bugzilla.kernel.org for fan problems assigned to the ACPI
component. Search for a related one and add your info (dmesg and acpidmp output
of a recent kernel) or open a new one if you think it's unrelated. Please CC me.

       Thomas
