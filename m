From: Jeremy Moles <jeremy-9vekgGPT+OA7YuNMryXyOw@public.gmane.org>
Subject: Re: strange buzzing sound after the 2.6.10 patch
Date: Thu, 24 Feb 2005 16:21:47 -0500
Message-ID: <1109280107.12887.30.camel@localhost>
References: <f11de95f050223183134a74bda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <f11de95f050223183134a74bda-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Try this:

edit /usr/src/linux/include/asm/param.h and change HZ to 100 (instead of
1000). Other folks here can perhaps comment on the side-effects, though
I've noticed few I couldn't handle. Perhaps a divide by 0 warning with
some programs that "guess" at the HZ, but other than that...

You'll find it only happens when the processor ACPI module is loaded. Go
figure.

On Wed, 2005-02-23 at 21:31 -0500, Jing Su wrote:
> Hello,
> 
> I vaguely remember someone else mentioning this problem on the list
> before, but I don't recall if there were any answers to the solution.
> 
> I'm running a vanilla 2.6.10 kernel patched with the acpi-2005-01-25 patch.  
> 
> When running the patched kernel, I noticed that my laptop makes a very
> strange and faint buzzing sound.  I've determined that the buzzing
> sound is somewhat related to CPU and HD load.  When the CPU load is
> heavy, or when the HD is busy, the buzzing stops.  But when the system
> idles, the buzzing continues.  I've also tried forcing the HD to go
> into suspension using hdparm, but the buzzing continues.
> 
> Any hints or clues?
> If this problem hasn't been encountered before, I'd appreciate it if
> someone could give hints for how I can best go about isolating the
> problem.
> 
> -Jing
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
