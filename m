From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Linux ACPI processor driver patch: user-definable power state
 limit
Date: 05 Nov 2004 20:01:23 -0500
Message-ID: <1099702882.15333.1824.camel@d845pe>
References: <F7DC2337C7631D4386A2DF6E8FB22B3001A193B6@hdsmsx401.amr.corp.intel.com>
	 <200410112335.19159.jos.delbar@ugent.be>
	 <1099683907.13837.1353.camel@d845pe>
	 <200411060021.49794.jos.delbar@ugent.be>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200411060021.49794.jos.delbar-Cru1EgDzd7c@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jos Delbar <jos.delbar-Cru1EgDzd7c@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, James P Ketrenos <james.p.ketrenos-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-11-05 at 18:21, Jos Delbar wrote:

> 
> Also, if you have both a blacklist and an option to change the limit
> at runtime, there has to be some logic to prevent a module from
> lifting a limit imposed by the blacklist.

the logic could be in the user of the API to simply check
the limit first and be sure that it only lowers and doesn't raise it.
yeah, no guarantees here, but for the users at hand, maybe sufficient.

i'll think about this when i merge on top of andy's patch.  maybe keep
the blacklist limit as a hard limit.  But frankly I'm not sure it is
worth a single byte more of code b/c it is the beginning of the
over-designed workaround slippery slope;-)

> Your patch just came in while I was writing this, I'll be sure to try
> it later today. I'm not sure if the idle handler should be concerned
> with handling the limit though, but it does make the code simpler.

since we had to handle a limit change on the fly i did it that way, and
then i realized that maybe on-the-fly checking is sufficient.

-Len




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
