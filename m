From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ACPI] [PATCH 1/2] 2.6: use scaling_available_freqs in
	acpi-cpufreq-ioport driver
Date: Tue, 24 Feb 2004 23:16:42 +0100
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040224221642.GB9145@elf.ucw.cz>
References: <20040220083149.GA10215@dominikbrodowski.de>
	<20040224125628.GA438@elf.ucw.cz>
	<20040224210040.GA8166@dreamcraft.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20040224210040.GA8166@dreamcraft.com.au>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: Tomasz Ciolek <tmc@dreamcraft.com.au>
Cc: acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

Hi!

>  have a loook at the "userpace frequency governer" under 2.6.x 

That's not the same. frequency governor can select frequency *from the
set provided by BIOS*. I want to override frequency/voltage table from
bios.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
