From: Julien Lerouge <julien.lerouge-o/5/jSaJEHk+NdeTPqioyti2O/JbrIOy@public.gmane.org>
Subject: Re: Asus ACPI Hotkeys
Date: Sat, 3 May 2003 16:23:39 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030503142339.GC2203@babar.linux.home>
References: <20030503112602.3d2ac1c3.g.zwartjes@student.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030503112602.3d2ac1c3.g.zwartjes-oe7qfRrRQfdlL9U78CI+FQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Gertjan <g.zwartjes-oe7qfRrRQfdlL9U78CI+FQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,

Check my page : http://julien.lerouge.free.fr/

This driver supports Asus hotkeys, it adds an entry in /proc/
filesystem. Currently, events are redirected to this entry, but in the
next version, they will go directly in /proc/acpi/event.

What this driver dos is rather simple, it installs a handler for the
HOTK/ATKD device you can find in your DSDT.

Regards,
Julien


On Sat, May 03, 2003 at 11:26:02AM +0200, Gertjan wrote:
> Hi,

> I recently bought an Asus Laptop from the L3 series. It has hotkeys, or
> multimedia buttons, for volume up, down, mute, internet, mail etcetera.
> Especially the volume up, down and mute are the buttons I would like to
> see working.

> After some research I found out that these buttons are ACPI buttons. In
> Windows Asus has a driver which handles the buttons with a nice OSD
> interface. But as I use Linux and not Windows, I can't use these buttons
> since they are not currently supported. There are loads of programs to
> assign commands to special buttons ('hotkeys', 'lineakd', etcetera), but
> the problem is, that my buttons do not generate scancodes, because they
> are ACPI buttons.

> I really would like to have them working. I'm prepared to write a driver
> for them if needed and that's why I'm posting this request. Can somebody
> help me, where to start, which steps to take? I'll post my results and I
> hope that eventually the buttons will get supported in the ACPI patches.

> Regards,

> Gertjan

-- 
main() {int j = 1234; char t[] = ":@ab4defghijklmnopqrstuvwxyz.\n", *i =
"iqgbgxmjjtzyhlnvlzeo.xlstbqbrt";char *strchr(const char *, int);while (
*i){j += strchr(t, *i++) - t;j %= sizeof t - 1;putchar(t[j]);}return 0;}


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
