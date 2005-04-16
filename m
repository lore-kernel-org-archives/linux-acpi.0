From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: hot-addacpi-hotplug-decouple-slot-power-state-changes-from-physical-hotplug.patch
Date: Sat, 16 Apr 2005 11:46:13 -0700 (PDT)
Message-ID: <20050416184613.85317.qmail@web50202.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: 6667
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--- Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> > Is p2p hotplug in your roadmap (for i386) ?
>
> I believe others are already working on it. I expect to free up
> a bit more in a couple of weeks.  If I don't see any patches or
> indication of activity by then, I'll work on adding this support
> too.
> 
> Rajesh

Hi Rajesh,

While waiting for a p2p bridge hotplug support, I give a try to linux-2.6.12rc2-mm3 which include
your patch for powering on and off an ACPIPHP controlled PCI slot without actually remove the pci
card.
I gave it a try on my IBM thinkpad booted in docking station which has an ACPIPHP slot.

An echo 0 > /sys/bus/pci/slots/SOME_NUMBER/power is removing some devices ( verified with cat
/proc/pci ), but gives some kernel errors on console.
An echo 1 > /sys/bus/pci/slots/SOME_NUMBER/power is not activating the devices again ( again
tested with cat /proc/pci) but gives some kernel errors on console + some cpu registers and a
segfault.

In my dock I have a ide controller, 2 yenta pcmcia slots, and a PCI slot where I have a bttv
supported tv card.
All drivers needed were compiled in kernel, no modules needed.

Was this setup supposed to work ?
I can provide more info if needed.

Thanks,
Paul






__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
