From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: PCI power state mapping
Date: Thu, 29 Jul 2004 13:23:59 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040729112359.GD9718@elf.ucw.cz>
References: <B44D37711ED29844BEA67908EAF36F036BCB8C@pdsmsx401.ccr.corp.intel.com> <41069C59.5020603@drzeus.cx> <20040729084154.GH21889@openzaurus.ucw.cz> <4108D5BC.8040302@drzeus.cx> <20040729105251.GB9718@elf.ucw.cz> <4108DC59.4050409@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4108DC59.4050409-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

[Please do not use html on the lists.]

[me:]
> Okay, try suspending to disk, first. It tends to work better. Are your
> "hacks into pci_device_suspend() getting it to suspend devices without
> a driver" available somewhere?

[you:]
>    Suspend to disk works fine. It's just the ram-bit that won't work.
>    There is an earlier thread about this with more details (search for
>    "suspend-to-ram hangs on HP NX7010"). I haven't bothered making a
>    patch of my changes since they do not add any functionality. If you
>    have a look at pci_device_suspend() it's fairly easy to change it.
>    It's a very compact and obvious function.

Why do you think it is a driver problem? I have nx5000 here, it fails
to suspend, too, but I suspect some ACPI weirdness. Similar problem is
there on compaq 620c, btw.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
