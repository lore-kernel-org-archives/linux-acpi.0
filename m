From: Jeremy Moles <jeremy-9vekgGPT+OA7YuNMryXyOw@public.gmane.org>
Subject: Re: ACPI+Userspace
Date: Sun, 19 Jun 2005 14:08:14 -0400
Message-ID: <1119204494.4337.15.camel@localhost>
References: <1118705856.3814.6.camel@localhost>
	 <1119204330.4337.13.camel@localhost>
Reply-To: jeremy-9vekgGPT+OA7YuNMryXyOw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-hcPYikvjaCvGQXO3JpWF"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1119204330.4337.13.camel@localhost>
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
List-Id: linux-acpi@vger.kernel.org


--=-hcPYikvjaCvGQXO3JpWF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here's the package.

On Sun, 2005-06-19 at 14:05 -0400, Jeremy Moles wrote:
> Well, spent some time Friday night and went ahead and did it. README
> included, along with some stuff in the source which may/may not be
> correct. :/ In particular, the sscanf may be hackish... I do mostly C++
> and python code, so I'm not that good C string stuff. All comments are
> welcome.
> 
> P.S. The Makefile has "make in" and "make out" targets. Any OS that lets
> you type "make out" at a commandline--and then do something
> interesting--is just fine by me. :)
> 
> On Mon, 2005-06-13 at 19:37 -0400, Jeremy Moles wrote:
> > Hello all--quick question.
> > 
> > As bad as it may seem, I was wondering if it is possible to generate
> > ACPI events in userspace? That is: propogate any arbitrary "string" up
> > through the ACPI subsystem, eventually getting dumped
> > to /proc/acpi/event which, in our case, is being watched and acted on by
> > the userspace util ACPID.
> > 
> > The obvious answer is: "Call /etc/acpi/hander with your string!"--which
> > is always an option--but I'd like to know if it's possible simply to use
> > for testing/debugging. I could write a driver supporting ioctls to pass
> > stuff via acpi_bus_generate_event (I think?), but that's wayyy too much
> > work for what I'm wanting this for. I'm sure there are reasons this
> > isn't a good idea, and I'd be glad to hear those too (to increase my
> > understanding of ACPI!).
> > 
> > Anyway--thanks ahead of time. Weee.
> > 
> > 
> > 
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
> > a projector? How fast can you ride your desk chair down the office luge track?
> > If you want to score the big prize, get to know the little guy.  
> > Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

--=-hcPYikvjaCvGQXO3JpWF
Content-Disposition: attachment; filename=acpievgen.tbz2
Content-Type: application/x-bzip; name=acpievgen.tbz2
Content-Transfer-Encoding: base64

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


--=-hcPYikvjaCvGQXO3JpWF--



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
