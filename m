From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Gericom Hummer 2430 problems
Date: Wed, 21 Jan 2004 10:40:40 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040121094040.GI5770@openzaurus.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8401720CC7@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720CC7-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Andy Beals <Andy_Beals-wAC0BGzJtFZBDgjK7y7TUQ@public.gmane.org>, Sebastien B <sebastien.bourdeauducq-QFKgK+z4sOrR7s880joybQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > I've recently noticed that this bug only happens while KDE is 
> > > > running. It's quite weird... and it is not only because 
> > of KDE : it 
> > > > locks up the whole system ; if I'm listening to music 
> > when the bug 
> > > > happens, there are interrupts in the song... I had the 
> > same problem 
> > > > with Linux 2.4.23 but without any message in the dmesg output.
> > > 
> > > It happens because of the aKpi (battery monitor) applet is 
> > loaded on 
> > > login. It's is not because of aKpi itself, I can trigger the same 
> > > problem with the Gnome battery monitor applet. So this is 
> > definitely 
> > > ACPI related...
> > 
> > I'd second that.  I'm seeing it with Sun JDS.  Easy 
> > reproduce-by: enable
> > the gnome battery applet, leave system on overnight.  Results in a
> > locked system the next day.  Disable battery applet, no 
> > locked system. 
> > I'm sure it's a corner-case hiding in the driver - just 
> > haven't had the
> > time to go after it and thought that it might have been quashed in
> > modern versions of the ACPI support.
> > 
> 
> The symptom seems to indicate there are some bugs triggered by 
> the battery monitor applet. We need to figure out what is the applet
> doing , then we can deeply look into ACPI code.
> 

Possible next step is while true; do cat batery/*/*; done, and see how long
it takes before lockup.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
