From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ACPI] [PATCH 1/2] 2.6: use scaling_available_freqs in
	acpi-cpufreq-ioport driver
Date: Fri, 12 Mar 2004 21:01:34 +0100
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040312200134.GB2153@openzaurus.ucw.cz>
References: <20040220083149.GA10215@dominikbrodowski.de>
	<20040224125628.GA438@elf.ucw.cz>
	<20040224210040.GA8166@dreamcraft.com.au>
	<20040224221642.GB9145@elf.ucw.cz>
	<20040226172823.GJ2869@poupinou.org>
	<20040226215006.GB397@elf.ucw.cz>
	<20040301175430.GY2869@poupinou.org>
	<20040301180325.GA562@elf.ucw.cz>
	<20040303162255.GK2869@poupinou.org>
	<20040312145244.GD4813@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20040312145244.GD4813@dominikbrodowski.de>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: Bruno Ducrot <ducrot@poupinou.org>, Pavel Machek <pavel@ucw.cz>, Tomasz Ciolek <tmc@dreamcraft.com.au>, len.brown@intel.com, acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

Hi!

+0100, Bruno Ducrot wrote:
> > > --- clean/include/linux/cpufreq.h	2004-01-09 20:24:26.000000000 +0100
> > > +++ linux/include/linux/cpufreq.h	2004-03-01 19:02:48.000000000 +0100
> > > @@ -316,6 +316,7 @@
> > >  	unsigned int	index;     /* any */
> > >  	unsigned int	frequency; /* kHz - doesn't need to be in ascending
> > >  				    * order */
> > > +	unsigned int	voltage;   /* mV */
> > >  };
> > 
> > Well, why not?
> 
> Four reasons:
> 
> 1.) not all cpufreq drivers which use frequency table helpers know the
> voltage
> 
> 2.) most cpufreq drivers don't need to know the voltage -- they need to know
> a value [==index] to be written to some sort of register [msr/io/whatever].
> 
> 3.) sizeof(struct cpufreq_table_entry)
> 
> 4.) the overrides discussed for k{7,8} are very driver-specific and do
> neither belong into the cpufreq core nor into the cpufreq frequency table
> helpers. 

After seeing k7 table that contains specific parameters (settle time etc)
for each state, I have to agree that what I suggested is bad idea.


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         
