From: Daniel Hoffend <mail-nf-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Battery charging state: unknown
Date: Sun, 10 Nov 2002 02:59:03 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021110015902.GA6003@intranet.fresh-style.lan>
References: <200211081216.gA8CGuX15381@mailgate5.cinetic.de> <1036861357.17196.22.camel@carwash.duncangibb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1036861357.17196.22.camel-h9eRTumTmmZjMu4AB9qoK9F8XQ1HzYRO@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello

where can i access to the real state bits to check witch bits are set
and compare with the results.


Daniel Hoffend



On Sam, Nov 09, 2002 at 05:02:37 +0000, Duncan Gibb wrote:
> On Fri, 2002-11-08 at 12:16, joerg.beyer-htSm2yLGOjU@public.gmane.org wrote:
> > Daniel Hoffend <mail-nf-Mmb7MZpHnFY@public.gmane.org> schrieb am 07.11.02 23:09:43:
> 
> DH> /proc/acpi/battery/BAT1/state shows that there is an
> DH> unknown charging stage
> 
> JB> I get this, when the Laptop is connected to power supply _and_
> JB> is fully charged.
> 
> I thought this was odd too.  There are two relevant bits in the battery
> status reply, bit 0 for discharging, bit 1 for charging.  The code does
> this:
> 
> 	if ((bst->state & 0x01) && (bst->state & 0x02))
> 		p += sprintf(p, "charging state:          charging/discharging\n");
> 	else if (bst->state & 0x01)
> 		p += sprintf(p, "charging state:          discharging\n");
> 	else if (bst->state & 0x02)
> 		p += sprintf(p, "charging state:          charging\n");
> 	else
> 		p += sprintf(p, "charging state:          unknown\n");
> 
> 
> IMHO "unknown" is likely to worry people, when "not charging" can happen
> for a number of reasons - eg: the battery is full, or there is another
> battery in the system which is being used/charged in preference to this
> one.
> 
> Dunno whether there are userland progs which rely on the existing code,
> though.
> 
> 
> Duncan
> 
> 
> 

-- 
mfg

Daniel "Griffon" Hoffend
Team FETTNET
Team LANparty.de
---
Visit :: http://fettnet.lanparty.de




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
