From: mhf-tdrK/OAtAx2ELgA04lAiVw@public.gmane.org
Subject: Re: [Suspend2-devel] Cause of Suspend2 resume failures on Toshiba
 laptops
Date: Sun, 06 Mar 2005 17:46:01 +0100
Message-ID: <422B33C9.nailFXZ11PEDH@berlios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: suspend2-devel-g/J2nbn7YhmWn91e4EydUaxOck334EZe@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Friday 04 March 2005 18:50, Bernard Blackham wrote:
> Hi all,
>
> As some of you will know, some laptops (notably almost
> all recent Toshibas) have issues resuming with Software
> Suspend 2, resulting in a hang during "Reading caches",
> or a stream of "Unable to queue event ..." messages. If
> you try and resume enough times, occasionally it will
> make it to the end of resuming and the system will be
> perfectly usable.
>
> The attached patch more or less reverts the change in
> 2.6.9-rc1 that began this all. If you have a Toshiba or
> other laptop that's affected by this, I ask you to see if
> it helps your problems. (It hacks around the problem
> rather than fixing it, but I'm not entirely sure what
> functionality it disables).
>
> To the ACPI developers:
>
> I'm not entirely sure what this is breaking. What uses
> these GPEs? It seems the hangs are caused by one of these
> GPEs firing upon resume (though I'm not sure why it
> causes a hang - perhaps related to the low memory
> conditions during a suspend/resume cycle?)
>
> The comment above the line I changed mentions that the
> GPE enable mask is updated, but not the HW GPE itself.
> Whereabouts are these later enabled?
>
> Are the HW GPE enable masks stored in memory that might
> be replaced when resuming, with their values from
> suspend? If so, could/should GPEs be disabled before
> suspending so that they aren't enabled at an unfortunate
> moment on resume?
>
> Apologies if none of the above makes much sense - it
> doesn't make all that much sense to me yet :)
>
> Thanks,
>
> Bernard.

Hi Bernard,

I am afraid the only effect of the patch on my Toshiba L2
is that the RTC stops working, thus the rtc.ko module can
not be inserted (no such device).

Resume still hangs with the GPE out of memory failure
after restoring the orig kernel.

If you need my DSDT, let me know.

Regards
Michael



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
