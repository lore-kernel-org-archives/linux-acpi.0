From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: 2.6.12-rc1-mm[1-3]: ACPI battery monitor does not work
Date: Wed, 30 Mar 2005 12:05:39 +0200
Message-ID: <200503301205.40555.rjw@sisk.pl>
References: <200503291156.19112.rjw@sisk.pl> <200503301353.25492.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200503301353.25492.luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
To: luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, 30 of March 2005 07:53, Yu, Luming wrote:
> On Tuesday 29 March 2005 17:56, Rafael J. Wysocki wrote:
> > Hi,
> >
> > There is a problem on my box (Asus L5D, x86-64 kernel) with the ACPI
> > battery driver in the 2.6.12-rc1-mm[1-3] kernels.  Namely, the battery
> > monitor that I use (the kpowersave applet from SUSE 9.2) is no longer able
> > to report the battery status (ie how much % it is loaded).  It can only
> > check if the AC power is connected (if it is connected, kpowersave behaves
> > as though there was no battery in the box, and if it is not connected,
> > kpowersave always shows that the battery is 1% loaded).
> >
> > Also, there are big latencies on loading and accessing the battery module,
> > but the module loads successfully and there's nothing suspicious in dmesg.
> >
> > Please let me know if you need any additional information.
> >
> > Greets,
> > Rafael
> 
> Could you just revert ec-mode patch, then retest?

Could you please point me to it?

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
