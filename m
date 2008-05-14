From: Thomas Renninger <trenn@suse.de>
Subject: Re: About p4-clockmod breakage/removal
Date: Wed, 14 May 2008 14:49:18 +0200
Message-ID: <1210769358.21269.21.camel@queen.suse.de>
References: <48246C3E.7010608@ceibo.fiec.espol.edu.ec>
	 <200805132048.00653.lenb@kernel.org> <20080514005636.GA21608@srcf.ucam.org>
	 <1210764974.29724.181.camel@queen.suse.de>
	 <20080514114215.GA31135@srcf.ucam.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:57744 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761791AbYENMtU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 08:49:20 -0400
In-Reply-To: <20080514114215.GA31135@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, cpufreq@lists.linux.org.uk, Alex =?ISO-8859-1?Q?Villac=ED=ADs?= Lasso <avillaci@ceibo.fiec.espol.edu.ec>, linux-acpi@vger.kernel.org

On Wed, 2008-05-14 at 12:42 +0100, Matthew Garrett wrote:
> On Wed, May 14, 2008 at 01:36:14PM +0200, Thomas Renninger wrote:
> 
> > Also there is another interface via mce:
> > arch/x86/kernel/cpu/mcheck/therm_throt.c
> > 
> > AFAIK this should be implemented in (all?) P4s, but Intel people should
> > know for sure.
> 
> Hm. The MCE interface is only for reporting, rather than control. Do you 
> know if it's possible to set the temperature at which the CPU will start 
> its own throttling? That would potentially be more straightforward.

AFAIK there is not much to control from OS side.
All you get is an event, or better an exception, that BIOS detected too
high temperatures on the CPU and that your CPU is currently not running
at full speed.
The p4 parts seem to sit here:
arch/x86/kernel/cpu/mcheck/p4.c

You might find a hack to modify this, by reading P4 (this seem to sit in
the CPU itself?) or chipset specs. But again, is it worth it for a P4
where no power saving capabilities are present anyway?

  Thomas

