From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ACPI] [PATCH 1/2] 2.6: use scaling_available_freqs in
	acpi-cpufreq-ioport driver
Date: Mon, 1 Mar 2004 19:03:25 +0100
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040301180325.GA562@elf.ucw.cz>
References: <20040220083149.GA10215@dominikbrodowski.de>
	<20040224125628.GA438@elf.ucw.cz>
	<20040224210040.GA8166@dreamcraft.com.au>
	<20040224221642.GB9145@elf.ucw.cz>
	<20040226172823.GJ2869@poupinou.org>
	<20040226215006.GB397@elf.ucw.cz>
	<20040301175430.GY2869@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20040301175430.GY2869@poupinou.org>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: Tomasz Ciolek <tmc@dreamcraft.com.au>, acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

> On Thu, Feb 26, 2004 at 10:50:06PM +0100, Pavel Machek wrote:
> > On ??t 26-02-04 18:28:23, Bruno Ducrot wrote:
> > > On Tue, Feb 24, 2004 at 11:16:42PM +0100, Pavel Machek wrote:
> > 
> > > > >  have a loook at the "userpace frequency governer" under 2.6.x 
> > > > 
> > > > That's not the same. frequency governor can select frequency *from the
> > > > set provided by BIOS*. I want to override frequency/voltage table from
> > > > bios.
> > > 
> > > It need to be done IMO in a driver, definitely not in cpufreq core, and
> > > worst that may need to be adapted to the acpi perflib certainly (when
> > > all pending patches for will go to mainstream I guess).
> > 
> > Well, it still looks pretty generic to me. Having same code in k7
> > and k8 drivers does not sound right.
> 
> That can be shared by the two drivers if that is needed, but I don't
> think that part going to the cpufreq frequency tables.
> But I espected that powernow k7 and k8 are different beasts enough?
> There is no rvo, irt etc. for example in powernow-k7.

They are different, but like every other driver, they have table of
(voltage, frequency) pairs, and that table is exactly the thing user
is trying to override. [And that's probably same with all other
drivers..] 

As long as people don't want to change rvo, irt, etc, we should be
fine.

First step in that direction would be to have voltage in milivolts in
those frequency tables, so that core can print them etc... like this:

--- clean/include/linux/cpufreq.h	2004-01-09 20:24:26.000000000 +0100
+++ linux/include/linux/cpufreq.h	2004-03-01 19:02:48.000000000 +0100
@@ -316,6 +316,7 @@
 	unsigned int	index;     /* any */
 	unsigned int	frequency; /* kHz - doesn't need to be in ascending
 				    * order */
+	unsigned int	voltage;   /* mV */
 };
 
 int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,


								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
