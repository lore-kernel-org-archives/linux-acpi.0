From: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Problem while inserting pciehp (PCI Express Hot-plug) driver
Date: Wed, 3 Aug 2005 10:49:43 -0700
Message-ID: <20050803104940.A3754@unix-os.sc.intel.com>
References: <87ab37ab0507300920570b0ea6@mail.gmail.com>
Reply-To: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87ab37ab0507300920570b0ea6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>; from fierykylin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org on Sun, Jul 31, 2005 at 12:20:30AM +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: kylin <fierykylin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-newbie-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-hotplug-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dkumar-QByN7dn/BetQWC9lL0RKGQC/G2K4zDHf@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jul 31, 2005 at 12:20:30AM +0800, kylin wrote:
> I wonder if i can workaround the MSI using the polling way on the
> server geared by E7520 and the firmware with no OSC implemented
> 
Per the PCI firmware spec (I'm looking at draft 0.9, version 3.0),
the OS must explicitly get control of native pcie hotplug from
firmware using _OSC before trying to use it. Firmware may be
deliberately not creating an _OSC because it is controlling the
hotplug hardware, or may be aware of other reasons (e.g. errata)
why OS native pcie hotplug should not be used on this platform.
So no, I don't think we can load and use pciehp if there's
no _OSC implemented in firmware.

Rajesh


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
