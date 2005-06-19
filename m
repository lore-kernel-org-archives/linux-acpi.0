From: Jeremy Moles <jeremy-9vekgGPT+OA7YuNMryXyOw@public.gmane.org>
Subject: Re: ACPI+Userspace
Date: Sun, 19 Jun 2005 14:05:30 -0400
Message-ID: <1119204330.4337.13.camel@localhost>
References: <1118705856.3814.6.camel@localhost>
Reply-To: jeremy-9vekgGPT+OA7YuNMryXyOw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1118705856.3814.6.camel@localhost>
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

Well, spent some time Friday night and went ahead and did it. README
included, along with some stuff in the source which may/may not be
correct. :/ In particular, the sscanf may be hackish... I do mostly C++
and python code, so I'm not that good C string stuff. All comments are
welcome.

P.S. The Makefile has "make in" and "make out" targets. Any OS that lets
you type "make out" at a commandline--and then do something
interesting--is just fine by me. :)

On Mon, 2005-06-13 at 19:37 -0400, Jeremy Moles wrote:
> Hello all--quick question.
> 
> As bad as it may seem, I was wondering if it is possible to generate
> ACPI events in userspace? That is: propogate any arbitrary "string" up
> through the ACPI subsystem, eventually getting dumped
> to /proc/acpi/event which, in our case, is being watched and acted on by
> the userspace util ACPID.
> 
> The obvious answer is: "Call /etc/acpi/hander with your string!"--which
> is always an option--but I'd like to know if it's possible simply to use
> for testing/debugging. I could write a driver supporting ioctls to pass
> stuff via acpi_bus_generate_event (I think?), but that's wayyy too much
> work for what I'm wanting this for. I'm sure there are reasons this
> isn't a good idea, and I'd be glad to hear those too (to increase my
> understanding of ACPI!).
> 
> Anyway--thanks ahead of time. Weee.
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
> a projector? How fast can you ride your desk chair down the office luge track?
> If you want to score the big prize, get to know the little guy.  
> Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
