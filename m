From: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: FW: [RFC/Patch 0/12] ACPI based root bridge hot-add
Date: Fri, 18 Mar 2005 14:34:10 -0800
Message-ID: <20050318143410.A1753@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I just sent out a series of acpi based root bridge hot-add
patches. I realized that I didn't send the explanation to
all the mailing lists, sorry.

Rajesh

----- Forwarded message from Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> -----

> Date: Fri, 18 Mar 2005 13:38:57 -0800
> From: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> To: gregkh-l3A5Bk7waGM@public.gmane.org
> Cc: linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
>         pcihpd-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [RFC/Patch 0/12] ACPI based root bridge hot-add
> 
> Here is a series of patches to support ACPI hot-add of a root
> bridge hierarchy. The added hierarchy may contain other p2p 
> bridges and end/leaf I/O devices too. The root bridge itself is
> assumed to have been assigned resource ranges, but the p2p
> bridges and end devices are not required to be initialized by
> firmware. Most of the code changes are to make the existing code
> flows suitable for such a hierarchy of bridges & devices.
> 
> This code supports hot-add on ia64 only for now.It does not yet
> support I/O APIC hot-add, which is needed to make this fully
> functional.  The patches are against 2.6.11-mm4 (plus the patch 
> needed for ia64 to boot). I've tested to make sure this does not 
> break end/leaf device hotplug on the hotplug capable ia64 box I have.
> 
> Thanks,
> Rajesh

----- End forwarded message -----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
