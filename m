From: Jan Frey <jfrey-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: ACPI throttling to death?
Date: Tue, 5 Apr 2005 18:16:30 +0200
Message-ID: <200504051816.30397.jfrey@gmx.de>
References: <200504042214.15648.jfrey@gmx.de> <20050405155910.GT2298@poupinou.org>
Reply-To: jfrey-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050405155910.GT2298-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 05 April 2005 17:59, Bruno Ducrot wrote:
> > Sometimes (I guess when the machine is getting overheated - the
> > notebook design is really bad and the fan is quite lousy) ACPI
> > temperature monitor shows >70 degrees (Celsius) and the system starts
> > throttling.
> >
> > Until here everything is fine IMO.
> > But what happens next is that the systems slows down continuously (you
> > can monitor the current throttling level going up and up) until it
> > reaches the last level (12%). Soon after that the whole machine is
> > locked up hard, display still showing the current graphics. I guess it
> > throttled to a "deathly" 0%...
>
> There isn't 0% level, so I guess the laptop stop due to overheat
> condition. Is it possible to control cpu fan in that machine?  Is there

It is possible to control the fan at two states, but I'm already drinving 
it on the "loudest" one...

> by chance support for power saving idling (at least C2)?

Hmmm, if I recall correctly it had C1/C2, but I'm not 100% sure.

> cat /proc/acpi/processor/*/power

Currently I cannot get hold of that machine, I'll send you that ASAP.

Why doesn't throttling reduce CPU temp? It seems to be stuck at about 70 
degress all the time...

"Stop due to overheat" seems to be best explanation currently...

Br
Jan

-- 
Jan Frey
jfrey-Mmb7MZpHnFY@public.gmane.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
