From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: About p4-clockmod breakage/removal
Date: Wed, 14 May 2008 10:15:03 +0100
Message-ID: <20080514091503.GA28678@srcf.ucam.org>
References: <48246C3E.7010608@ceibo.fiec.espol.edu.ec> <200805132048.00653.lenb@kernel.org> <20080514005636.GA21608@srcf.ucam.org> <200805132335.33118.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:57470 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754777AbYENJeI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 May 2008 05:34:08 -0400
Content-Disposition: inline
In-Reply-To: <200805132335.33118.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: cpufreq@lists.linux.org.uk, Alex =?iso-8859-1?B?VmlsbGFj7a1z?= Lasso <avillaci@ceibo.fiec.espol.edu.ec>, linux-acpi@vger.kernel.org

On Tue, May 13, 2008 at 11:35:32PM -0400, Len Brown wrote:

> cpufreq is not designed to manage thermals, and putting p4_clockmod
> underneath it to manage thermals is a mistake.

Check processor_thermal.c. It explicitly interfaces with cpufreq in 
order to perform P state management.

> There is already a well known thermal throttling interface
> available via ACPI and it does not need p4_clockmod to run.
> Passive trip points work automatically even without cpufreq being present.
> If they do not, then we need to fix them.

You're assuming that the throttling interface is always exposed via 
ACPI. I've seen machines where this isn't the case.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
