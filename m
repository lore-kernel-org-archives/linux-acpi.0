From: Len Brown <lenb@kernel.org>
Subject: Re: About p4-clockmod breakage/removal
Date: Tue, 13 May 2008 23:35:32 -0400
Message-ID: <200805132335.33118.lenb@kernel.org>
References: <48246C3E.7010608@ceibo.fiec.espol.edu.ec> <200805132048.00653.lenb@kernel.org> <20080514005636.GA21608@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43061 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755650AbYENDfx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 May 2008 23:35:53 -0400
In-Reply-To: <20080514005636.GA21608@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: cpufreq@lists.linux.org.uk, Alex =?iso-8859-1?q?Villac=ED=ADs_Lasso?= <avillaci@ceibo.fiec.espol.edu.ec>, linux-acpi@vger.kernel.org

On Tuesday 13 May 2008, Matthew Garrett wrote:
> On Tue, May 13, 2008 at 08:48:00PM -0400, Len Brown wrote:
> 
> > Assuming this is a laptop with a batter,
> > I'd certainly be interested if you could run BLTK
> > and measure any benefit to p4-clockmod (I've never
> > been able to)
> 
> The most plausible benefit to p4-clockmod is its utility in throttling 
> the CPU if it would otherwise cause the system to overheat. From that 
> point of view, I think it's worth keeping around - especially since not 
> all machines expose T states via ACPI.

Matthew,
I'm delighted in your efforts to make Linux better, I really am.
So I'm sorry that for the 3rd message in a row I have to
completely disagree with you.

cpufreq is not designed to manage thermals, and putting p4_clockmod
underneath it to manage thermals is a mistake.

There is already a well known thermal throttling interface
available via ACPI and it does not need p4_clockmod to run.
Passive trip points work automatically even without cpufreq being present.
If they do not, then we need to fix them.

p4-clockmod should have been removed from the tree over a year ago.

-Len

