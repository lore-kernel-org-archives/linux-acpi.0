From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Power usage in S3
Date: Mon, 28 Feb 2005 20:45:28 +0100
Message-ID: <200502282045.30429.stefandoesinger@gmx.at>
References: <20050228141701.4dc95eec@orfeo.nikhef.nl> <422355D2.8040709@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <422355D2.8040709-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
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
Cc: Vernon Mauery <vernux-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Tim Dijkstra <newsuser-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Am Montag, 28. Februar 2005 18:33 schrieb Vernon Mauery:
> Tim Dijkstra wrote:
> > Hi,
> >
> > Since a couple of weeks I have S3 working on my laptop (yeah!), but then
> > I stared wondering how long I can walk around with my laptop suspended.
> >
> > By keeping it suspended for a night and extrapolating the measured power
> > usage I concluded it can stay suspended (starting with batteries fully
> > loaded) for about 2.5 days. That doesn't seem awfully long to me...
> > Especially if you take into account the fact one usually suspends
> > after using it for while when it's at, say, 20%.
> >
> > So now I wonder, what usage do other people see?
>
> I finally got the power issues resolved on my Thinkpad T40 too.  It can
> only sleep in S3 for about 2 days too.  But, with a new high-capacity
> battery, it could probably go for 4 days.  My wife's Thinkpad R40p can go
> for about a week, but it has a new battery and the FireGL T2 graphics card
> rather than the Radeon 7500.  And it didn't need the radeon power stuff --
> it only needed acpi_sleep=s3_bios.  But, I am sure we can do better than
> 2-2.5 days... *But*, I am very pleased that we have come this far.  For
> almost a year, I was using swsusp2 every night going home from work.  As
> nice as that is, it still is too slow for an overnight sleep.
My Acer Travelmate 803 looses ~20% battery power in 12 hours in S3 with Linux. 
Under Windows it dropped from 50% to 5% withhin 5h. Sounds strange, but at 
least the Linux value can be reproduced. I can't test with Windows again 
because it had to go to satisfy my disk space needs :-)

I think we're not so bad off with 2 days suspend time. On my old notebook I 
experienced that an empty battery(Notebook powered itself down in full use) 
can keep the device running in Suspend for ~2 hours. That was a NiMH battery, 
I don't have any experiance with my new Lithium-Ion batteries. I only know 
that it's bad if they are discharged that low.

With a secoundary battery I get 8 to 9 hours battery uptime with agressive 
power management settings(extrapolation done by klaptopdaemon, I didn't test 
it).

Stefan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
