From: Jason Dagit <dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org>
Subject: Re: Driver Testing
Date: Wed, 16 Mar 2005 22:27:20 -0800
Message-ID: <87br9iwzw7.fsf@www.codersbase.com>
References: <20050317024304.95595.qmail@web31402.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050317024304.95595.qmail-oqthl4G0bEevuULXzWHTWIglqE1Y4D90QQ4Iyu8u01E@public.gmane.org> (nicdev05-/E1597aS9LQAvxtiuMwx3w@public.gmane.org's
 message of "Wed, 16 Mar 2005 18:43:04 -0800 (PST)")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: nicdev05 nic <nicdev05-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

nicdev05 nic <nicdev05-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> writes:

>   So, any idea as what the resume command should be? I
> a Fedora Core-2 system.

Unfortunately I don't have the answer to this questions, but perhaps
others on the list do.  I'm a debian zealot (okay, perhaps satisfied
user is more accurate :) and I'm not (yet) very versed in the ways of
acpi.

>   Outside of resume, the suspend process works fine
> (by writing to /sys/power/state). If I press the power
> button the system seems to resume but then follows
> with a reboot...

If you reboot on resume you may be experiencing this bug:
http://bugme.osdl.org/show_bug.cgi?id=3691

Does that sound like your problem?  I'm anxiously awaiting advice from
others on this list about how to solve that bug.  I have a laptop
which I currently use swsuspend2 on, but would much, much rather
suspend to ram, at least most of the time.

Jason


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
