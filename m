From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [BKPATCH] ACPI for 2.6.10
Date: 05 Dec 2004 22:36:16 -0500
Message-ID: <1102304175.2312.25.camel@d845pe>
References: <1101945436.8026.392.camel@d845pe>
	 <Pine.LNX.4.61.0412031840340.19044@student.dei.uc.pt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.61.0412031840340.19044-oe7qfRrRQfcmha6Ds7sm0l6hYfS7NtTn@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Marcos D. Marado Torres" <marado-oe7qfRrRQfcmha6Ds7sm0l6hYfS7NtTn@public.gmane.org>
Cc: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-12-03 at 13:46, Marcos D. Marado Torres wrote:

> If this release is equivalent with -mm's bk-acpi.patch from
> 2.6.10-rc2-mm1 to 2.6.10-rc2-mm4,
> notice that this kernels' bk-acpi patches have the bug
> described in http://lkml.org/lkml/2004/11/16/263 , so I wouldn't
> really like to
> see this pull done to 2.6.10 until the problem is solved...
> 
> If you want, I can try this patch to see if it acts like
> bk-acpi.patch, but I guess it does...

Please try 2.6.10-rc3, which includes this set of patches.

Yes, this set of patches includes most of what was in -mm, but not
everything.  Note also, that it includes some more recent patches,
including a poweroff fix, that was not in the -mm patches above.

If your system still fails I'll be very interested to figure out exactly
what we did to make it stop working.

thanks,
-Len




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
