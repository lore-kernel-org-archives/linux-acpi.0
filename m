From: tmc@dreamcraft.com.au (Tomasz Ciolek)
Subject: Re: [ACPI] [PATCH 1/2] 2.6: use scaling_available_freqs in
	acpi-cpufreq-ioport driver
Date: Wed, 25 Feb 2004 08:00:40 +1100
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040224210040.GA8166@dreamcraft.com.au>
References: <20040220083149.GA10215@dominikbrodowski.de>
	<20040224125628.GA438@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20040224125628.GA438@elf.ucw.cz>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: Pavel Machek <pavel@ucw.cz>
Cc: acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

 have a loook at the "userpace frequency governer" under 2.6.x 

 TMC

On Tue, Feb 24, 2004 at 01:56:28PM +0100, Pavel Machek wrote:
> Hi!
> 
> > Export an array of supported frequencies in sysfs
> > [scaling_available_frequencies]
> 
> Would it be possible to export [frequency/voltage] pairs, and allow
> user to change it?
> 								Pavel
> 
> 
> 
> -- 
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]
> 
> 
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

-- 
Tomasz M. Ciolek	
*******************************************************************************
 tmc at dreamcraft dot com dot au or tmc at goldweb dot com dot au 	
*******************************************************************************
	GPG Key ID: 0x41C4C2F0  Key available on www.pgp.net	
*******************************************************************************
  Everything falls under the law of change;	
  Like a dream, a phantom, a bubble, a shadow,
  like dew of flash of lightning.
  You should contemplate like this. 
