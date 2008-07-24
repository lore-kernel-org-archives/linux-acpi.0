From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: hwapci-0142 error
Date: Thu, 24 Jul 2008 09:04:12 +0800
Message-ID: <1216861452.1831.4.camel@yakui_zhao.sh.intel.com>
References: <20080720001417.GA22429@eorbit.net>
	 <20080720023327.GA6026@eorbit.net> <200807231256.05113.trenn@suse.de>
	 <20080723231734.GA29832@eorbit.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47266 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbYGYFbm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Jul 2008 01:31:42 -0400
In-Reply-To: <20080723231734.GA29832@eorbit.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Collins <chris@eorbit.net>
Cc: linux-acpi@vger.kernel.org, trenn@suse.de

On Wed, 2008-07-23 at 16:17 -0700, Chris Collins wrote:
> Hello,
> 
> On Wed, Jul 23, 2008 at 12:56:04PM +0200, Thomas Renninger wrote:
> 
> > This machine/BIOS is rather old?
> > You should better stay with ACPI switched off.
I agree with what Thomas said. Maybe the bios is too old and can't
support ACPI.
>From the dmesg log it seems that the system fails in switch from legacy
mode to ACPI mode.
   > ACPI: setting ELCR to 0200 (from 0e20)
   > ACPI Error (hwacpi-0142): Hardware did not change modes [20070126]
   > ACPI Error (evxfevnt-0086): Could not transition to ACPI mode
[20070126]
   > ACPI Warning (utxface-0139): AcpiEnable failed [20070126]

Had better confirm whether the ACPI is supported on Windows.
Thanks.
> I believe there are no newer updates for this BIOS.
> 
> I will try to test this with a Windows installation. 
> Is it the case that this BIOS which clearly has
> some kind of an ACPI capability should be written off.
> 
> How can I test the capabilities, or seek help in 
> solving of the kinks or idiosyncrasies of this 
> BIOS.  Is Award/Phoenix represented on this forum?
> Do they support the work of making ACPI function
> on Linux?
> 
> Thanks,
> 
> --Chris
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

