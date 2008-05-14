From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: About p4-clockmod breakage/removal
Date: Wed, 14 May 2008 12:42:15 +0100
Message-ID: <20080514114215.GA31135@srcf.ucam.org>
References: <48246C3E.7010608@ceibo.fiec.espol.edu.ec> <200805132048.00653.lenb@kernel.org> <20080514005636.GA21608@srcf.ucam.org> <1210764974.29724.181.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:60562 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbYENLmp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 May 2008 07:42:45 -0400
Content-Disposition: inline
In-Reply-To: <1210764974.29724.181.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, cpufreq@lists.linux.org.uk, Alex =?iso-8859-1?B?VmlsbGFj7a1z?= Lasso <avillaci@ceibo.fiec.espol.edu.ec>, linux-acpi@vger.kernel.org

On Wed, May 14, 2008 at 01:36:14PM +0200, Thomas Renninger wrote:

> Also there is another interface via mce:
> arch/x86/kernel/cpu/mcheck/therm_throt.c
> 
> AFAIK this should be implemented in (all?) P4s, but Intel people should
> know for sure.

Hm. The MCE interface is only for reporting, rather than control. Do you 
know if it's possible to set the temperature at which the CPU will start 
its own throttling? That would potentially be more straightforward.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
