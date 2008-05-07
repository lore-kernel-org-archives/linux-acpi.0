From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Vs: Re: Acer Aspire 9813WKMI fan runs all the time after
	suspend to ram
Date: Wed, 07 May 2008 14:32:30 +0800
Message-ID: <1210141950.3648.10.camel@rzhang-crestline.sh.intel.com>
References: <27920691.1210137673091.JavaMail.apache@eni-cpps16.sth.basefarm.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42114 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757005AbYEGGej (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 May 2008 02:34:39 -0400
In-Reply-To: <27920691.1210137673091.JavaMail.apache@eni-cpps16.sth.basefarm.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: v-j-m@suomi24.fi
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>


On Wed, 2008-05-07 at 07:21 +0200, JM wrote:
> >
> >Perhaps it would be worth experimenting instead with OSI when booting and see 
> >what happens then? e.g.
> >
> >acpi_osi="!Windows 2006"
> >
> >(Perhaps OSYS also triggers an SMI trap which does or doesn't do it? Worth a 
> >shot at least).
> >
> acpi_osi="!Windows 2006"
> acpi_osi="!Windows 2001 SP2"
> acpi_osi="!Windows 2001 SP1"
> acpi_osi="!Windows 2001"
> It is same with all. On cold boot fan stop ~1-2 seconds after Grub (Scope PR INI) and never stop after suspend.
> 
> >> Best you create a bug for that at bugzilla.kernel.org (and add me to CC
> >> or post the bug no).
> >> Full (or none) fan is a real blocker bug that should generally be
> >> resolved.
> >
> >I've also had a report from a user the other day that hit the same bug on an 
> >Aspire 5710 series (which seems to have the same root cause, from glancing 
> >over the DSDT):
> >
> >http://aceracpi.googlecode.com/svn/trunk/dsdt/acer/aspire/5710.dsl
> >
> >> Does this BIOS expose an ACPI fan device correctly? 
> >
> >Acer BIOS's never expose the fan, AFAIK (and it's not available through WMI 
> >either).
> >
> Is this kernel bug or not?
Is the temperature ever updated after s3?
It seems that we have some similar bug reports for this problem.
Please refer to bug
http://bugzilla.kernel.org/show_bug.cgi?id=9754
http://bugzilla.kernel.org/show_bug.cgi?id=9167

thanks,
rui
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

