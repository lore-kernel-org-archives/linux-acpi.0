From: =?iso-8859-15?q?Ois=EDn_Mac_Fheara=ED?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
Subject: Re: Good news: video can be revived after S3 on Samsung P30 (Radeon 9200)
Date: Fri, 26 Nov 2004 09:47:41 +0000
Message-ID: <200411260947.41321.destynova@esatclear.ie>
References: <1101458866.15323.4.camel@mhcln03>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1101458866.15323.4.camel@mhcln03>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'd like to see that as a "standard suspend/resume procedure" in a machine 
manual...

Talk about a -hack- ;)
This is one of those things not to mention during one of those "reasons to use 
linux over windows" debates :P

Oisín

On Friday 26 November 2004 08:47, Matthias Hentges wrote:
> How to revive the monitor:
>
> - Start X11 with radeon driver (DRI can be enabled) on :0
> - Start X11 with *vesa* driver on :1 (use X
> -xf86config /etc/X11/$some_XF86Config)
> - Change to VT1 (chvt 1)
> - Make sure that "dummydriver" is loaded
> - Sync your disks (can't hurt heh)
> - Enter S3 (echo -n mem >/sys/power/state)
> - Hit the power button to resume
> - Run boot-vga-bios (if you don't, the machine will freeze during the
> next step)
> - Just ignore the segfault it is causing
> - Change to the running *vesa* X11 screen (eg: chvt 8)
> - The vesa screen will crash and throw you back to VT1 - that's no
> problem at all!
> - The crashing vesa session revives your Monitor :)
> - Change to the radeon X11 screen to re-init AGP (this is a *must*)
> - Done !
> - Repeat from step 2 ;)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
