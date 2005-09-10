From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: Re: C states on AMD SMP
Date: Sat, 10 Sep 2005 19:08:08 +0200
Message-ID: <20050910170808.GA683@tangens.sinus.cz>
References: <1126178956.24699.42.camel@localhost.localdomain> <43202621.9080600@tzi.de> <1126182374.4397.8.camel@localhost.localdomain> <43215F09.7030909@tzi.de> <1126339733.22979.2.camel@localhost.localdomain> <4322A06D.8050804@tzi.de> <1126343826.4766.29.camel@localhost.localdomain> <20050910100113.GA2582@tangens.sinus.cz> <1126349195.4766.48.camel@localhost.localdomain>
Reply-To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1126349195.4766.48.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Erik Slagter <erik-KW7PGP3XNp7a5EbDDlwbIw@public.gmane.org>
Cc: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>, Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > I did, just to see what it
> > does. There is a plenty of registers accessed, bits set/cleared from them,
> > simply something, which is not present in plain processor_idle.c.
> 
> a) mostly for the amd760 chipset (as opposed to amd768)
But which chipset is in my machine, when for example lspci shows:
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 04)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04)
Is it a compbination of 760/768 ? If the important part is in the first line, 
does it mean that it cannot work that simple as a "pure" 768 ?
> b) some registers are already set by default or by bios
But when the bios forbids PM, takes it enough care to put them to the correct 
state ?
> c) some registers enable some extra savings
Another reason for a specialized driver.
> 
> >  I'm also using amd76x_pm and it's really wonderful, the CPUs cool down to 45C
> > from 75C, I can even stop the fans and the temp doesn't go above 60C if the
> > CPUs are idling.
> 
> See above. It doesn't do the right thing, especially not using bus
> mastering (like video capturing cards).
Probably not, but for example the previous version of the driver with C3 enabled
(the current version seems not to contain C3 support) entered C3 in my case
regularly (less than C2, but my machine is running a lot of daemons keeping CPU
load at 0.2 or more so maybe it didn't had enough time to enter it so often).
> 
                                        With regards, Pavel Troller



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
