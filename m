From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4]Bind physical devices with ACPI devices - take 2
Date: Thu, 06 Jan 2005 15:50:34 +0800
Message-ID: <1104997834.22886.17.camel@sli10-desk.sh.intel.com>
References: <1104893444.5550.127.camel@sli10-desk.sh.intel.com>
	 <1104984055.18173.239.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1104984055.18173.239.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-01-06 at 12:00, Len Brown wrote:
> I think we'll save some significant power when ACPI D-states
> are invoked for the devices that supply them.  While many
> PCI devices support PCI power management and thus don't need/use
> ACPI D-states, I think it will be even more important to add
> this functionality to the legacy devices which never have
> PCI power management and thus always depend on ACPI for D-states.
It's easy to link the PNP devices with the ACPI devices with the ACPIPNP
driver. But the PNP driver core hasn't similar routines as
'pnp_set_power_state'. Unclear if the PNP drivers support
suspend/resume.

> It looks like some device drivers scribble on dev->platform_data;
> and we need to fix those drivers before deploying this patch.
> Alternatively, we could add a new field to struct device,
> but then we'd probably never get rid of it...
Yep, this is a big problem. According to the comments in the source
file, it's designed for firmware such as ACPI, but some drivers misused
it. A search shows there are many such drivers. Fixing the drivers is a
pain for me.

> I'm a little unformforable with platform_notify
> and platform_notify_remove available as globals.
> We should probably BUG_ON if we
> find them set before ACPI writes on them.
I will fix it.

> We'll need to update this patch to handle erroneous
> but real platforms that don't have _BBN
> by using _CRS to get PCI bus number.
That's ok.

> Unclear to me if/how this association of ACPI capability
> should be reflected in the sysfs device tree.
Possibly both the physical devices and ACPI devices have a link in sysfs
to pointer partners.

Thanks,
Shaohua



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
