From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ACPI] Re: [PATCH 2.6] update passive cooling algorithm
Date: Thu, 15 Jan 2004 13:18:33 +0100
Sender: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
Message-ID: <20040115121833.GB12963@elf.ucw.cz>
References: <20040111211255.GA31105@dominikbrodowski.de>
	<20040112154611.GH14031@poupinou.org>
	<20040112173922.GA6154@dominikbrodowski.de>
	<20040112191122.GK14031@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20040112191122.GK14031@poupinou.org>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: Ducrot Bruno <ducrot@poupinou.org>
Cc: acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > [Len, could you test and verify this patch, and push it to Linus, please?]
> > > > 
> > > > The current algorithm used by Linux ACPI for passive thermal management has
> > > > two shortcomings:
> > > 
> > > ...
> > > 
> > > > +/* If a passive cooling situation is detected, primarily CPUfreq is used, as it
> > > > + * offers (in most cases) voltage scaling in addition to frequency scaling, and
> > > > + * thus a cubic (instead of linear) reduction of energy. Also, we allow for
> > > > + * _any_ cpufreq driver and not only the acpi-cpufreq driver.
> > > > + */
> > > 
> > > Just a stupid question:
> > > 
> > > What is best if processor heat issues (apart turning on the fan)?
> > > 
> > > Reducing voltage of the processor, but still allowing it to run execution
> > > at 100% (which is the case if the processor is heating), or reduce
> > > amount of time allowed for the processor to execute?
> > 
> > voltage scaling. It offers a much better (quadratic) saving than clock
> > modulation (linear saving). Doing both [and you need to do it, as the CPU
> > won't run with fewer volts at the same frequency] gives you cubic savings.
> 
> Yes I know.  But does it offer more 'cooling'?

Of course.

If you eat less power, you create less heat. CPU is basically fancy
"turn-electricity-into-heat" device.

[Have you seen that "first use of PentiumPro in house appliances"
picture?]

									Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
