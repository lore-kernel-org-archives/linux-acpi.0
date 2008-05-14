From: Pavel Troller <patrol@sinus.cz>
Subject: Re: About p4-clockmod breakage/removal
Date: Wed, 14 May 2008 13:18:17 +0200
Message-ID: <20080514111817.GA21186@tangens.sinus.cz>
References: <48246C3E.7010608@ceibo.fiec.espol.edu.ec>
	<200805132048.00653.lenb@kernel.org>
	<20080514005636.GA21608@srcf.ucam.org>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20080514005636.GA21608@srcf.ucam.org>
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=m.gmane.org+glkc-cpufreq=m.gmane.org@lists.linux.org.uk
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: cpufreq@lists.linux.org.uk, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

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
> 
Hi!
  I heavily used p4-clockmod having old, broken battery. Using it and
throttling the CPU frequency immediately after AC disconnection was
necessary to limit the maximum current the CPU was able to drain from
the battery. Otherwise, the battery voltage would drop below the allowed
level and the machine would either switch off or crash. Yes, in idle state,
there was no change in the CPU power consumption, but during heavy CPU
load, 75% throttle really limited the power consumption to the level
allowing operation even with that old poor battery.
  So, p4-clockmod REALLY helped me a lot in this case. I vote for keeping
it on its place!
  With regards, Pavel Troller
