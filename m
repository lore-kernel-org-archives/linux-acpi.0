From: Pavel Machek <pavel@suse.cz>
Subject: Re: [ACPI] [PATCH 1/2] 2.6: use scaling_available_freqs in
	acpi-cpufreq-ioport driver
Date: Wed, 25 Feb 2004 11:26:54 +0100
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040225102654.GB214@elf.ucw.cz>
References: <20040220083149.GA10215@dominikbrodowski.de>
	<20040224125628.GA438@elf.ucw.cz>
	<20040224144318.GA9702@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20040224144318.GA9702@dominikbrodowski.de>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: len.brown@intel.com, acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > Export an array of supported frequencies in sysfs
> > > [scaling_available_frequencies]
> > 
> > Would it be possible to export [frequency/voltage] pairs, and allow
> > user to change it?
> 
> IMO, NO! While this might be a necessity for powernow-k7, the generic acpi-io
> driver should stay clean of such overrides et al. If you need to modify the
> ACPI tables, there are other ways.

Well, I know k7 machines that apparently needed override, and I know
k8 machines that definitely need one. Buggy bioses seem to be quite
common...

I do not know how buggy tables on intel machines are, but it seems to
me that overrides should be generic.

[Otoh... that would need tables to contain voltages in some known
units, probably milivolts. Again that would be good for printouts...]

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
