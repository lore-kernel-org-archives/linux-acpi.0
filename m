From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Fwd: [RFC/patch] ACPI in linux PnP layer
Date: Tue, 21 Sep 2004 08:27:12 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1095726432.1370.6.camel@sli10-desk.sh.intel.com>
References: <c0a09e5c040920150413cbc270@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <c0a09e5c040920150413cbc270-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Grover <andy.grover-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, castet.matthieu-GANU6spQydw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-09-21 at 06:04, Andrew Grover wrote:
> Did anyone else see Matthieu's post to lkml a while back and were
> there any comments? Is this going to get applied, or if not why not?
> 
Yes, Andy. I'm working on enhancing Matthieu's driver, if he didn't mind
:). I have some ideas about the driver, such as D-state support, IRQ
usage (avoid link device use legacy devices' IRQ) and etc. 

Thanks,
Shaohua
> 
> ---------- Forwarded message ----------
> From: castet.matthieu-GANU6spQydw@public.gmane.org <castet.matthieu-GANU6spQydw@public.gmane.org>
> Date: Sat,  4 Sep 2004 15:22:54 +0200
> Subject: [RFC/patch] ACPI in linux PnP layer
> To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> 
> Hi,
> 
> I have started to plug acpi in PnP layer.
> A first patch add the function acpi_driver_scan, that allow to call a
> function
> for each acpi device.
> I have to do that because acpi is load before PnP, and it can't add my
> function
> in acpi_bus_add (driver/acpi/scan.c).
> 
> The second patch is the PnP acpi driver.
> It parse possible and activated resources.
> It use acpi_register_gsi to activate irq (is that need ???)
> 
> Also there are no disable/set acpi resource support, nor ADDRESS
> resource
> support.
> 
> But it work well with drivers that work with pnpbios(parport, serial,
> ...).
> 
> What do you think of it ?
> Any comment ?
> 
> Matthieu
> 
> PS : please CC me since I'm not subscribed to lkml.
> 



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
