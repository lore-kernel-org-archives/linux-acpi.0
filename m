From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] Resend: ACPI/CPUFREQ: Introduce hw_limit per cpu cpufreq sysfs interface
Date: Thu, 3 Sep 2009 23:42:31 +0200
Message-ID: <20090903214231.GB27880@isilmar.linta.de>
References: <200909031323.29420.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:52882 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756394AbZICVtL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Sep 2009 17:49:11 -0400
Content-Disposition: inline
In-Reply-To: <200909031323.29420.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Dave Jones <davej@redhat.com>, Len Brown <lenb@kernel.org>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org, Pallipadi Venkatesh <venkatesh.pallipadi@intel.com>

Hey,

On Thu, Sep 03, 2009 at 01:23:28PM +0200, Thomas Renninger wrote:
> I now realized that this patch somewhat clashes with
> cpufrequtils cpufreq-info --hwlimits command.
> IMO "cpufreq-info --hwlimits" is wrong here as it evaluates
> max_freq sysfs value which could also get limited by the user.

huh?

brodo@comet:~$ cpufreq-info --hwlimits
800000 2001000
brodo@comet:~$ sudo cpufreq-set --max 1.2G
brodo@comet:~$ cpufreq-info --hwlimits
800000 2001000

--hwlimits evaluates cpuinfo_{cur,min,max}_freq which are the hardware
limits. Those may be limited further by the BIOS on runtime (firmware
limits, so to speak). It seems to me that this is what you want to add with
this patch?

Best,
	Dominik
