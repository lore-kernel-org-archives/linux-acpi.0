From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: acpi/sleep/proc.c
Date: Mon, 18 Jul 2005 13:42:49 +0200
Message-ID: <20050718114249.GE1869@elf.ucw.cz>
References: <20050717191637.GA12674@elf.ucw.cz> <200507171952.52881.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200507171952.52881.dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > +		seq_printf(seq, "%4s	%4d		%s%8s\n",
> > +			   dev->pnp.bus_id, (u32) dev->wakeup.sleep_state,
> > +			   dev->wakeup.flags.run_wake ? "*" : "",
> > +			   dev->wakeup.state.enabled ? "*enabled" : "*disabled");
> 
> Do you really want to have double astericks (**enabled)?

Oops, my bad. Just delete * from *enabled and *disabled:
							Pavel

diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -374,7 +374,7 @@ acpi_system_wakeup_device_seq_show(struc
 		seq_printf(seq, "%4s	%4d		%s%8s\n",
 			   dev->pnp.bus_id, (u32) dev->wakeup.sleep_state,
 			   dev->wakeup.flags.run_wake ? "*" : "",
-			   dev->wakeup.state.enabled ? "*enabled" : "*disabled");
+			   dev->wakeup.state.enabled ? "enabled" : "disabled");
 		spin_lock(&acpi_device_lock);
 	}
 	spin_unlock(&acpi_device_lock);


-- 
teflon -- maybe it is a trademark, but it should not be.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
