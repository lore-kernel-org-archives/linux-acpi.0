From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI hotplug
Date: Sat, 15 Jan 2005 02:26:46 -0800 (PST)
Message-ID: <20050115102646.69910.qmail@web50203.mail.yahoo.com>
References: <20050113120620.A1002@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050113120620.A1002-39QZ/XbsZ5/mO6KZMuUCQVaTQe2KTcn/@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Keshavamurthy,

The eject files have no any side effect for me.
I just tried to play with them for my devices.

I tried on a docked computer and I have this:
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/USB7/URTH/UPDK/eject
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/USB0/URTH/UPDK/eject
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/IDE0/SCND/MSTR/eject
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/PCI1/DOCK/eject
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/LPC/UART/eject
Trying to echo 1 >
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/PCI1/DOCK/eject
did not undocked the laptop as I hoped.

I thought I can use my docking station without being
necessary to boot docked.
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
--- Keshavamurthy Anil S
<anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> On Thu, Jan 13, 2005 at 03:02:37PM +0100, Paul
> Ionescu wrote:
> > Hi,
> > 
> > I just read that 2.6.11-rc1 does support ACPI
> hotplug.
> > What does this really mean ?
> 
> 2.6.11-rc1 now supports physical CPU hotplug and
> these eject files
> were added to support the same. Once the cpu's are
> logically offlined,
> they can be physically removed by echoing 1 onto the
> eject file
> under _SB/PCI0/LSBX/CPUX/eject.
> 
> 
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
> 
> Looks like your DSDT has _EJx methods for many other
> types of devices,
> either you can enhance these devices drivers to
> support user
> mode eject or you can simply not create "eject"
> file.
> 
> > 
> > But what can I do with them, and what else is
> there for hotplug ?
> > Does it support docking stations ?
> 
> Does this "eject" file has any side effects which
> needs to be addressed,
> please let me know.
> 
> -Anil
> 
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
