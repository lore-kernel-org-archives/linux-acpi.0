From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI throttling to death?
Date: Tue, 5 Apr 2005 17:59:10 +0200
Message-ID: <20050405155910.GT2298@poupinou.org>
References: <200504042214.15648.jfrey@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200504042214.15648.jfrey-Mmb7MZpHnFY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Frey <jfrey-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 04, 2005 at 10:14:15PM +0200, Jan Frey wrote:
> Hi,
> 
> I'm observing strange behaviour with a Gericom notebook running a 2.6.9 
> vanilla kernel with custom configuration. The processor used is a P III 
> (Tualatin) with 1.2GHz (which is quite rarely used). It is *not* a mobile 
> processor (no speedstep etc.), instead it supports 16 throttling levels.

Hard to tell exactly.  Since there is 16 throttling levels the chipset
is probably not an intel one, and we weren't able to provide a speedstep
driver for chipset other than intel one for older laptops :(

> Sometimes (I guess when the machine is getting overheated - the notebook 
> design is really bad and the fan is quite lousy) ACPI temperature monitor 
> shows >70 degrees (Celsius) and the system starts throttling.
> 
> Until here everything is fine IMO.
> But what happens next is that the systems slows down continuously (you can 
> monitor the current throttling level going up and up) until it reaches the 
> last level (12%). Soon after that the whole machine is locked up hard, 
> display still showing the current graphics. I guess it throttled to a 
> "deathly" 0%...

There isn't 0% level, so I guess the laptop stop due to overheat condition.
Is it possible to control cpu fan in that machine?  Is there by chance
support for power saving idling (at least C2)?
cat /proc/acpi/processor/*/power

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
