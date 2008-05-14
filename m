From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: About p4-clockmod breakage/removal
Date: Thu, 15 May 2008 00:11:29 +0100
Message-ID: <20080514231129.GB11960@srcf.ucam.org>
References: <48246C3E.7010608@ceibo.fiec.espol.edu.ec> <200805132335.33118.lenb@kernel.org> <20080514091503.GA28678@srcf.ucam.org> <200805141118.38324.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:47916 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbYENXLy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 May 2008 19:11:54 -0400
Content-Disposition: inline
In-Reply-To: <200805141118.38324.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: cpufreq@lists.linux.org.uk, Alex =?iso-8859-1?B?VmlsbGFj7a1z?= Lasso <avillaci@ceibo.fiec.espol.edu.ec>, linux-acpi@vger.kernel.org

On Wed, May 14, 2008 at 11:18:37AM -0400, Len Brown wrote:
> On Wednesday 14 May 2008, Matthew Garrett wrote:
> > Check processor_thermal.c. It explicitly interfaces with cpufreq in 
> > order to perform P state management.
> 
> The hook above is so that ACPI thermal throttling
> does not invoke T-states until the more  efficient
> P-states have already been exhausted.
> 
> It doesn't imply the presence of thermal awareness
> anywhere in the cpufreq sub-system.

The cpufreq sub-system itself isn't aware of thermal issues, but the 
ACPI system is. I'm not sure that the distinction's especially 
important.

> It also doesn't imply that running cpufreq on top
> of T-states is a good idea.  Cpufreq as implemented,
> say by the ondemand governor, is based
> on the assumption that it is running on top of
> P-states.  Deeper P-states result in
> more efficient operation  (less energy/instruction)
> due to their lower voltage, because energy varies with voltage^2.
> T-states violate that assumpion and provide
> all the performance cost with none of the efficiency
> gains of P-states, because energy varies directly
> with frequencey -- but so does performance cost.

Right. I'm not implying that this is a desirable situation, but the fact 
remains that some machines will reach critical shutdown temperature 
unless something is done to reduce the speed of the processor. If you 
don't have P states or ACPI-exposed T states, then p4-clockmod is about 
the best you can manage.

> > > There is already a well known thermal throttling interface
> > > available via ACPI and it does not need p4_clockmod to run.
> > > Passive trip points work automatically even without cpufreq being present.
> > > If they do not, then we need to fix them.
> > 
> > You're assuming that the throttling interface is always exposed via 
> > ACPI. I've seen machines where this isn't the case.
> 
> Please show me those machines.

http://www.google.co.uk/search?hl=en&client=firefox-a&rls=org.mozilla%3Aen-US%3Aofficial&hs=R8P&q=acpi+throttling+"<not+supported>"+-C3&btnG=Search&meta=

(a lot of false positives, but many of these are genuine)
-- 
Matthew Garrett | mjg59@srcf.ucam.org
