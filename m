From: Pavel Machek <pavel@suse.cz>
Subject: Re: [ACPI] Re: [PATCH 2.6] update passive cooling algorithm
Date: Thu, 15 Jan 2004 23:34:25 +0100
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040115223425.GC18488@elf.ucw.cz>
References: <20040111211255.GA31105@dominikbrodowski.de>
	<20040112154611.GH14031@poupinou.org>
	<20040112173922.GA6154@dominikbrodowski.de>
	<20040112191122.GK14031@poupinou.org>
	<20040115121833.GB12963@elf.ucw.cz>
	<20040115134229.GT14031@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces@www.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20040115134229.GT14031@poupinou.org>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces@www.linux.org.uk
To: Ducrot Bruno <ducrot@poupinou.org>
Cc: acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > voltage scaling. It offers a much better (quadratic) saving than clock
> > > > modulation (linear saving). Doing both [and you need to do it, as the CPU
> > > > won't run with fewer volts at the same frequency] gives you cubic savings.
> > > 
> > > Yes I know.  But does it offer more 'cooling'?
> > 
> > Of course.
> > 
> > If you eat less power, you create less heat. CPU is basically fancy
> > "turn-electricity-into-heat" device.
> > 
> 
> I don't like certitudes (I was wondering if better heat dissipation
> in

Sorry.

> case of throttling even if more heat generation, but that not the
> case).

I guess throttling is way too fast (in kHz range, IIRC), so there
should not be any strange effects.

> > [Have you seen that "first use of PentiumPro in house appliances"
> > picture?]
> 
> No, but I do have seen some that have burnt in a production server,
> some years ago...

There was a picture of four-plate cooker, with PPro in the middle of
each plate.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
