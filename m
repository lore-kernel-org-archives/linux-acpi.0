From: Jan De Luyck <lkml-gY0FE6dpLprYtjvyW6yDsg@public.gmane.org>
Subject: Re: [2.6.1-rc1] no acpi event for ac_adapter?
Date: Tue, 13 Jan 2004 11:33:02 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200401131133.02634.lkml@kcore.org>
References: <3ACA40606221794F80A5670F0AF15F8401720CBF@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720CBF-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 13 January 2004 06:38, Yu, Luming wrote:
> > On Monday 12 January 2004 08:39, Yu, Luming wrote:
> > > > I was just wondering - should there normally be an acpi event
> > > > for the plugging
> > > > or removing of the ac-adapter? I've catted /proc/acpi/events,
> > > > but the only
> > > > thing I seem to be getting acpi events for is the powerbutton
> > > > and my lid
> > > > button.
> > >
> > > Usually , there is a AC Adapter event. there are some _Qxx method
> > > under EC , in which Notify will be issued to inform OSPM .
> > > Can you find out it in your laptop's dsl.
> >
> > I've included my dsdt + the disassembled dsdt + acpidmp here.
> > Is something
> > wrong with the DSDT of my laptop?
>
> In your dsl file, there are notify statement with respect to AC Adapter.
> Notify (\_SB.ACAD, 0x00) , which will generate AC Adapter event.
> But its execution depends on sizeof (\_OS) in_Q09. Maybe you can play
> with
> kernel option "acpi_os_name= "

Hmm. What am I supposed to supply to this parameter? I've just grepped through 
the kernel sourcetree, but not much info as far as i can see ...

Jan
-- 
Facts are the enemy of truth.
		-- Don Quixote



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
