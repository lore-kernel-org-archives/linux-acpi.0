From: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI hotplug
Date: Thu, 13 Jan 2005 12:06:45 -0800
Message-ID: <20050113120644.A911@unix-os.sc.intel.com>
References: <pan.2005.01.13.14.02.37.561980@yahoo.com>
Reply-To: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 13, 2005 at 03:02:37PM +0100, Paul Ionescu wrote:
> 
> I just read that 2.6.11-rc1 does support ACPI hotplug.
> What does this really mean ?
> I found some new files in /sys/firmware:
> find /sys/firmware/ | grep eject
> /sys/firmware/acpi/namespace/ACPI/_SB/PCI0/USB7/URTH/UPDK/eject
> /sys/firmware/acpi/namespace/ACPI/_SB/PCI0/USB0/URTH/UPDK/eject
> /sys/firmware/acpi/namespace/ACPI/_SB/PCI0/IDE0/SCND/MSTR/eject
> /sys/firmware/acpi/namespace/ACPI/_SB/PCI0/LPC/EC/BAT1/eject
> /sys/firmware/acpi/namespace/ACPI/_SB/PCI0/LPC/FDC/FDD0/eject
> 
The new ACPI code is to  support _physical_ insertion/removal of
cpus and "containers" (nodes) that have cpus and memory. This
requires firmware/platform support.  Linux already supports ACPI
(as well as SHPC/PCI-Express) based physical insertion/removal of
IO adapters independent of the new code in 2.6.11-rc1. The ACPI 
namespace you listed above shows ACPI ejectable IO devices. This
is handled by the existing acpiphp code, not the new processor
or container code.

Rajesh



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
