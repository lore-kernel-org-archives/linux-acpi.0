From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: Re: Re: ACPI buttons in 2.6.12-rc4-mm2
Date: Tue, 26 Jul 2005 22:03:03 +0200
Message-ID: <20050726200303.GA32581@tangens.sinus.cz>
References: <b6d0f5fb0505220425146d481a@mail.gmail.com> <1122407079.13241.4.camel@toshiba.lenb.intel.com>
Reply-To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1122407079.13241.4.camel-g3qfMnKXm6m1ouK1UO9oVVDQ4js95KgL@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Cameron Harris <thecwin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> I deleted /proc/acpi/button on purpose,
> did you have a use for those files?
> 
Hi Len!
  I already wrote 2 mails that I have use for the LID switch status file and
that I don't know how to handle its absence. However, they seem to be dropped
on the floor somewhere :-).
  BTW I have written a small C program which uses dev_acpi module and
evaluates an object, which I'm using to evaluade the _LID method, thus reading
the status of the switch. However, I think that this should be done by the
kernel. So at least, if the buttons allow to read their status, I'm voting for
keeping the possibility to read it.
                                  With regards, Pavel Troller


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
