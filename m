From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: [ACPI] [PATCH 1/2] 2.6: use scaling_available_freqs in
	acpi-cpufreq-ioport driver
Date: Thu, 26 Feb 2004 18:28:23 +0100
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040226172823.GJ2869@poupinou.org>
References: <20040220083149.GA10215@dominikbrodowski.de>
	<20040224125628.GA438@elf.ucw.cz>
	<20040224210040.GA8166@dreamcraft.com.au>
	<20040224221642.GB9145@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20040224221642.GB9145@elf.ucw.cz>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: Pavel Machek <pavel@ucw.cz>
Cc: Tomasz Ciolek <tmc@dreamcraft.com.au>, acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 24, 2004 at 11:16:42PM +0100, Pavel Machek wrote:
> Hi!
> 
> >  have a loook at the "userpace frequency governer" under 2.6.x 
> 
> That's not the same. frequency governor can select frequency *from the
> set provided by BIOS*. I want to override frequency/voltage table from
> bios.
> 

It need to be done IMO in a driver, definitely not in cpufreq core, and
worst that may need to be adapted to the acpi perflib certainly (when
all pending patches for will go to mainstream I guess).

For now, you can adapt with something like the powernow-k7 override
patches at http://www.poupinou.org/cpufreq/powernow-k7/ if really
needed.

Also, you should check that in fact the acpi perflib stuff will give
you more accurate results.  For the powernow-k7 case, unfortunately, it
sound like that acpi perflib whereas giving good results still could be
problematics for some acer IIRC due to a bad VID for one entry, and then
it may be usefull for them to get the override patch merged IMO.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
