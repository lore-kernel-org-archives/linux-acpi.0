From: Len Brown <lenb@kernel.org>
Subject: Re: About p4-clockmod breakage/removal
Date: Wed, 14 May 2008 11:18:37 -0400
Message-ID: <200805141118.38324.lenb@kernel.org>
References: <48246C3E.7010608@ceibo.fiec.espol.edu.ec> <200805132335.33118.lenb@kernel.org> <20080514091503.GA28678@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35844 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbYENWm1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 18:42:27 -0400
In-Reply-To: <20080514091503.GA28678@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: cpufreq@lists.linux.org.uk, Alex =?iso-8859-1?q?Villac=ED=ADs_Lasso?= <avillaci@ceibo.fiec.espol.edu.ec>, linux-acpi@vger.kernel.org

On Wednesday 14 May 2008, Matthew Garrett wrote:
> On Tue, May 13, 2008 at 11:35:32PM -0400, Len Brown wrote:
> 
> > cpufreq is not designed to manage thermals, and putting p4_clockmod
> > underneath it to manage thermals is a mistake.
> 
> Check processor_thermal.c. It explicitly interfaces with cpufreq in 
> order to perform P state management.

The hook above is so that ACPI thermal throttling
does not invoke T-states until the more  efficient
P-states have already been exhausted.

It doesn't imply the presence of thermal awareness
anywhere in the cpufreq sub-system.

It also doesn't imply that running cpufreq on top
of T-states is a good idea.  Cpufreq as implemented,
say by the ondemand governor, is based
on the assumption that it is running on top of
P-states.  Deeper P-states result in
more efficient operation  (less energy/instruction)
due to their lower voltage, because energy varies with voltage^2.
T-states violate that assumpion and provide
all the performance cost with none of the efficiency
gains of P-states, because energy varies directly
with frequencey -- but so does performance cost.

> > There is already a well known thermal throttling interface
> > available via ACPI and it does not need p4_clockmod to run.
> > Passive trip points work automatically even without cpufreq being present.
> > If they do not, then we need to fix them.
> 
> You're assuming that the throttling interface is always exposed via 
> ACPI. I've seen machines where this isn't the case.

Please show me those machines.

thanks,
-Len



