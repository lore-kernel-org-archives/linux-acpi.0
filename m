From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: udev broken by recent ACPI git commits
Date: Fri, 3 Nov 2006 09:22:47 +0100
Message-ID: <200611030922.47470.rjw@sisk.pl>
References: <200611010004.28483.rjw@sisk.pl> <200611030039.28762.len.brown@intel.com> <200611030858.37016.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:200 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751641AbWKCIYm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Nov 2006 03:24:42 -0500
In-Reply-To: <200611030858.37016.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Friday, 3 November 2006 08:58, Rafael J. Wysocki wrote:
> On Friday, 3 November 2006 06:39, Len Brown wrote:
> > Rafael,
> > Please send the .config that fails.
> 
> Attached.
> 
> > This failure is on your HP NX6325 laptop running SL 10.1, yes?
> 
> Yes.
> 
> > I know that an nx6125 works, so the question is what is unique about your system.
> 
> Unfortunately quite a lot, I think: SMP, different chipset, different BIOS,
> drives (SATA vs. ATA), even the thermal zones are different.
> 
> FWIW, the output of 'lspci -v' is also attached.

I'm unable to reproduce the failure on a desktop x86-64 box with an Athlon 64 X2
and ULi chipset, so the issue seems to be specific to the ATI chipset, HP BIOS
or this particular machine.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
