From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI hotplug
Date: Sat, 15 Jan 2005 02:14:53 -0800 (PST)
Message-ID: <20050115101454.67867.qmail@web50203.mail.yahoo.com>
References: <20050113120644.A911@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050113120644.A911-39QZ/XbsZ5/mO6KZMuUCQVaTQe2KTcn/@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Rajesh,

I was hoping that I can use my docking station without
being necessary to boot docked.
But is not the case.
I tried this way:
Booted normaly, loaded acpiphp (even said found a pci
slot), then plug the ThinkPad in the dockingstation,
but nothing happened. No new devices get added.
Then I tried to boot in the dockingstation and while I
see all the new devices (this was always the case), I
cannot remove the laptop from the docking station
because it does not senses I push the eject button on
it.


Thanks,
Paul
--- Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> On Thu, Jan 13, 2005 at 03:02:37PM +0100, Paul
> Ionescu wrote:
> > 
> > I just read that 2.6.11-rc1 does support ACPI
> hotplug.
> > What does this really mean ?
> > I found some new files in /sys/firmware:
> > find /sys/firmware/ | grep eject
> >
>
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/USB7/URTH/UPDK/eject
> >
>
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/USB0/URTH/UPDK/eject
> >
>
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/IDE0/SCND/MSTR/eject
> >
>
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/LPC/EC/BAT1/eject
> >
>
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/LPC/FDC/FDD0/eject
> > 
> The new ACPI code is to  support _physical_
> insertion/removal of
> cpus and "containers" (nodes) that have cpus and
> memory. This
> requires firmware/platform support.  Linux already
> supports ACPI
> (as well as SHPC/PCI-Express) based physical
> insertion/removal of
> IO adapters independent of the new code in
> 2.6.11-rc1. The ACPI 
> namespace you listed above shows ACPI ejectable IO
> devices. This
> is handled by the existing acpiphp code, not the new
> processor
> or container code.
> 
> Rajesh
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
