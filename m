From: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI hotplug
Date: Thu, 13 Jan 2005 12:06:20 -0800
Message-ID: <20050113120620.A1002@unix-os.sc.intel.com>
References: <pan.2005.01.13.14.02.37.561980@yahoo.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <pan.2005.01.13.14.02.37.561980-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>; from i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org on Thu, Jan 13, 2005 at 03:02:37PM +0100
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 13, 2005 at 03:02:37PM +0100, Paul Ionescu wrote:
> Hi,
> 
> I just read that 2.6.11-rc1 does support ACPI hotplug.
> What does this really mean ?

2.6.11-rc1 now supports physical CPU hotplug and these eject files
were added to support the same. Once the cpu's are logically offlined,
they can be physically removed by echoing 1 onto the eject file
under _SB/PCI0/LSBX/CPUX/eject.


> I found some new files in /sys/firmware:
> find /sys/firmware/ | grep eject
> /sys/firmware/acpi/namespace/ACPI/_SB/PCI0/USB7/URTH/UPDK/eject
> /sys/firmware/acpi/namespace/ACPI/_SB/PCI0/USB0/URTH/UPDK/eject
> /sys/firmware/acpi/namespace/ACPI/_SB/PCI0/IDE0/SCND/MSTR/eject
> /sys/firmware/acpi/namespace/ACPI/_SB/PCI0/LPC/EC/BAT1/eject
> /sys/firmware/acpi/namespace/ACPI/_SB/PCI0/LPC/FDC/FDD0/eject

Looks like your DSDT has _EJx methods for many other types of devices,
either you can enhance these devices drivers to support user
mode eject or you can simply not create "eject" file.

> 
> But what can I do with them, and what else is there for hotplug ?
> Does it support docking stations ?

Does this "eject" file has any side effects which needs to be addressed,
please let me know.

-Anil




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
