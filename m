From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Possible dcache BUG
Date: 13 Sep 2004 00:53:03 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1095051183.2984.7.camel@d845pe>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	 <20040808113930.24ae0273.akpm@osdl.org>
	 <200408100012.08945.gene.heskett@verizon.net>
	 <200408102342.12792.gene.heskett@verizon.net>
	 <Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
	 <20040810211849.0d556af4@laptop.delusion.de>
	 <Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
	 <Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>
	 <20040812180033.62b389db@laptop.delusion.de>
	 <Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>
	 <20040912000354.7243a328@laptop.delusion.de>
	 <20040912001626.759e2d17.akpm@osdl.org>
	 <20040912002945.29a976ad@laptop.delusion.de>
	 <20040912004812.3544c6de.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040912004812.3544c6de.akpm-3NddpPZAyC0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: "Udo A. Steinberg" <us15-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 2004-09-12 at 03:48, Andrew Morton wrote:
> "Udo A. Steinberg" <us15-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org> wrote:
> >
> > On Sun, 12 Sep 2004 00:16:26 -0700 Andrew Morton (AM) wrote:
> >
> >  AM> Random guess: acpi_evaluate_object() is returning an error but
> is
> >  AM> allocating memory anyway.
> >  AM>
> >  AM> In acpi_battery_get_status():
> >  AM>
> >  AM>  status = acpi_evaluate_object(battery->handle, "_BST", NULL,
> &buffer);
> >  AM>  if (ACPI_FAILURE(status)) {
> >  AM>          ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating
> _BST\n"));
> >  AM>          return_VALUE(-ENODEV);
> >  AM>  }
> >  AM>
> >  AM> Is that failure path being taken?
> >
> >  Is there a way for me to find that out without recompiling and
> rebooting?
> 
> Looks like you need to set CONFIG_ACPI_DEBUG and then put the
> right number into /proc/acpi/debug_layer.

For the battery module:
# echo 0x00040000 > /proc/acpi/debug_layer


and then to turn on everything about it:
# echo 0xffffffff > /proc/acpi/debug_level

These hooks exist only if the kernel is built with CONFIG_ACPI_DEBUG.

It would be interesting to know if you can examine the contents of
/proc/acpi/battery/*/*

thanks,
-Len




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
