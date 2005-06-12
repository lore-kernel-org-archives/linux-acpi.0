From: "Jason Dagit" <dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was:
 Re: Resume from Suspend to RAM))
Date: Sun, 12 Jun 2005 16:19:20 -0700
Message-ID: <87k6kzi2o7.fsf@www.codersbase.com>
References: <200506061531.41132.stefandoesinger@gmx.at>
	<200506122255.38020.chefturner@web.de>
	<878y1fjltd.fsf@www.codersbase.com>
	<200506130101.20005.chefturner@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200506130101.20005.chefturner-S0/GAf8tV78@public.gmane.org> (Christoph Tavan's
 message of "Mon, 13 Jun 2005 01:01:19 +0200")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Christoph Tavan <chefturner-S0/GAf8tV78@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Christoph Tavan <chefturner-S0/GAf8tV78@public.gmane.org> writes:

> When I boot it with init=/bin/bash without the patch, it also seems to suspend 
> and resume fine except for the display which stays black. Everything else 
> seems to work: I can type "reboot" and the machine reboots properly!

I want to try this on my laptop.  When I add init=/bin/bash, /sys and
/proc are empty.  How do I initiate suspend?  I used to use either
echo mem >/sys/power/state or echo 3 >/proc/acpi/sleep.

Thanks,
Jason


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
