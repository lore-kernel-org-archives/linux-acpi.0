From: Zwane Mwaikambo <zwane-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 1/6]sep initializing rework
Date: Tue, 12 Apr 2005 06:07:46 -0600 (MDT)
Message-ID: <Pine.LNX.4.61.0504120558500.14171@montezuma.fsmlabs.com>
References: <1113283845.27646.424.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1113283845.27646.424.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, "Protasevich, Natalie" <Natalie.Protasevich-8PZ5lytb3wbQT0dZR+AlfA@public.gmane.org>, Ryan Harper <ryanh-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello Shaohua,

On Tue, 12 Apr 2005, Li Shaohua wrote:

> These patches (together with 5 patches followed this one) are updated
> suspend/resume SMP patches. The patches fixed some bugs and do clean up
> as suggested. Now they work for both suspend-to-ram and suspend-to-disk.
> Patches are against 2.6.12-rc2-mm3.

These patches look good and i think we should go ahead with them. I've 
also cross checked with physical hotplug cpu patches for ES7xxx from 
Natalie (added to Cc) and it does indeed look like a lot of the code will 
work for her too, but i'd appreciate it if she also does a double check. 
Obviously this won't work for other upcoming users of hotplug cpu like Xen 
(Ryan added to Cc) but i think we can abstract things later on to cover 
other special users.

Thanks Shaohua,
	Zwane



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
