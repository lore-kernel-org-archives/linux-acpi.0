From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: RE: Please Help!
Date: Mon, 12 Jan 2004 22:59:04 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040112225811.B59750@root.org>
References: <3ACA40606221794F80A5670F0AF15F8401720CBD@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720CBD-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacek Blizinski <azidog-SDTLKeebBdLQT0dZR+AlfA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 13 Jan 2004, Yu, Luming wrote:
> > Hello, I own a Fujitsu P5010D and I'm trying to fix my DSDT
> > so that the volume
> > controls work. The key mappings are as follows:
> >
> > Fn+F3 = Mute
> > Fn+F4 = Disable/Enable Touchpad
> > Fn+F5 = Widescreen/Native Resolution
> > Fn+F6/7 = Brightness Down/UP
> > Fn+F8/9 = Volume down/up
> >
> > The brightness controls work and all i wish to do is include
> > the Mute and
> > Volume up/down features.
>
> All this features seems to need support from
> other module like asus_acpi.c.

I know this is a Linux list but for the developers assistance, here is a
link to the FreeBSD Fujitsu driver:

http://www.stalker.org/~sean/freebsd-p2040/FujiApp/

-Nate


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
