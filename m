From: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [RFC/Patch 0/12] ACPI based root bridge hot-add
Date: Mon, 21 Mar 2005 11:14:49 -0800
Message-ID: <20050321111449.A5052@unix-os.sc.intel.com>
References: <20050318133856.A878@unix-os.sc.intel.com> <pan.2005.03.19.13.50.15.938352@yahoo.com>
Reply-To: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2005.03.19.13.50.15.938352-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>; from i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org on Sat, Mar 19, 2005 at 03:50:16PM +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Mar 19, 2005 at 03:50:16PM +0200, Paul Ionescu wrote:
> 
> Does this mean that when it will be ported for i386, I will be able to
> really use my Docking Station ?

No. The current patches only trigger when a _root_ bridge is
hot-added, not a PCI to PCI bridge (which is what the docking 
station is). The code to support p2p bridge hotplug will benefit
from these patches but more code is needed to support that.

> Does it rescan the DSDT to find new additions to ACPI devices ?
> 
It scans the ACPI namespace under the root bridge that was added.
Any pci devices underneath are scanned and added, but there isn't
any code to look for non-PCI devices there.

Rajesh


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
