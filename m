From: Len Brown <lenb@kernel.org>
Subject: Re: About p4-clockmod breakage/removal
Date: Wed, 14 May 2008 13:22:26 -0400
Message-ID: <200805141322.26879.lenb@kernel.org>
References: <48246C3E.7010608@ceibo.fiec.espol.edu.ec> <20080514005636.GA21608@srcf.ucam.org> <20080514111817.GA21186@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35853 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150AbYENWmi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 18:42:38 -0400
In-Reply-To: <20080514111817.GA21186@tangens.sinus.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Troller <patrol@sinus.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, cpufreq@lists.linux.org.uk, Alex =?iso-8859-1?q?Villac=ED=ADs_Lasso?= <avillaci@ceibo.fiec.espol.edu.ec>, linux-acpi@vger.kernel.org

On Wednesday 14 May 2008, Pavel Troller wrote:
> > On Tue, May 13, 2008 at 08:48:00PM -0400, Len Brown wrote:
> > 
> > > Assuming this is a laptop with a batter,
> > > I'd certainly be interested if you could run BLTK
> > > and measure any benefit to p4-clockmod (I've never
> > > been able to)
> > 
> > The most plausible benefit to p4-clockmod is its utility in throttling 
> > the CPU if it would otherwise cause the system to overheat. From that 
> > point of view, I think it's worth keeping around - especially since not 
> > all machines expose T states via ACPI.
> > 
> Hi!
>   I heavily used p4-clockmod having old, broken battery. Using it and
> throttling the CPU frequency immediately after AC disconnection was
> necessary to limit the maximum current the CPU was able to drain from
> the battery. Otherwise, the battery voltage would drop below the allowed
> level and the machine would either switch off or crash. Yes, in idle state,
> there was no change in the CPU power consumption, but during heavy CPU
> load, 75% throttle really limited the power consumption to the level
> allowing operation even with that old poor battery.
>   So, p4-clockmod REALLY helped me a lot in this case. I vote for keeping
> it on its place!
>   With regards, Pavel Troller

Yes, we could design Linux to be optimal for this broken hardware.
But the cost is that others with actual working hardware
unnwittingly run p4-clockmod and slow down their machine with
no energy savings benefit.

Perhaps there is a different workaround (besides purchasing
a battery or running on AC) that will help you?

Does this machine export /proc/acpi/processor/*/throttling?

-Len



