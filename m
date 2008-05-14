From: Len Brown <lenb@kernel.org>
Subject: Re: About p4-clockmod breakage/removal
Date: Wed, 14 May 2008 11:28:08 -0400
Message-ID: <200805141128.08893.lenb@kernel.org>
References: <48246C3E.7010608@ceibo.fiec.espol.edu.ec> <1210764974.29724.181.camel@queen.suse.de> <20080514114215.GA31135@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35852 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752778AbYENWmi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 18:42:38 -0400
In-Reply-To: <20080514114215.GA31135@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, cpufreq@lists.linux.org.uk, Alex =?iso-8859-1?q?Villac=ED=ADs_Lasso?= <avillaci@ceibo.fiec.espol.edu.ec>, linux-acpi@vger.kernel.org

On Wednesday 14 May 2008, Matthew Garrett wrote:
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

No. this is hardware invoked thermal trottling, and the software
here is just trying to gracefully explain to you the reason
that your machine is running abnormally slow.

Software can not change the trip point for hardware thermal throttling.
It is set at the factory.  It is basically a hardware fail-safe mechanism,
and thus the trip point is set higher than that for ACPI thermal
throttling.

-Len
