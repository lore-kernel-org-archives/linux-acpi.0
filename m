From: Tim Dijkstra <newsuser-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org>
Subject: Re: Acer TM636 won't wakeup after S3, USB, i8042
Date: Mon, 14 Feb 2005 23:53:01 +0100
Message-ID: <20050214235301.4ff45705@commensaal.drs.p>
References: <20050111003537.13142400@bonenpikster.drs.p>
	<20050117153245.GA1481@elf.ucw.cz>
	<20050214223939.77016065@commensaal.drs.p>
	<20050214215149.GJ12235@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050214215149.GJ12235-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: vojtech-AlSwsSmVLrQ@public.gmane.org, ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 14 Feb 2005 22:51:49 +0100
Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org> wrote:

> Hi!
> 
> > > Tim :
> > > > Reading some positive reports on S3 on a travelmate 632, I gave
> > > > it another try with my 636. .....
> > > > the resume process ends with:
> > > > 
> > > > i8042.c: Can't read CTR while initializing i8042.
> > > > resume failed: i8042.c (Not sure about this line, typing it from
> > > > memory)
> > > > 
> > > > 
> > > > Is there anything I can do to help to debug this? I attached
> > > > lspci-vvv, if there's any other log I can send, just ask.
> > > 
> > > Remove keyboard support and see what happens?
> > 
> > OK, I finally had some time to test this a bit. Indeed removing
> > atkbd from the kernel seems to work! My notebook resumed fro S3 the
> > first time in its life! Also compiling it in as a module won't hang
> > the resume phase, it will unfortunately not (re)load on resume,/
> > 
> > So (one of) my problems with resume seems to come from atkbd. Should
> > I report a bug some where? I do unfortunately don't have the time to
> > become a kernel hacker and fix it myself at the moment ;(
> 
> Vojtech Pavlik (cc-ed) is good person to talk about inputs...
> 								Pavel

Hmm, now it even works with atkbd compiled in ... In trying to get S3 to
work I more or less disabled everything. So the problem isn't solely
atkbd, but a combination of atkbd and/or i8042 with some other driver.
I'll try enabling some drivers and see what combinations generates the
problem, but not very soon, this free evening is over for me...

grts Tim


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
