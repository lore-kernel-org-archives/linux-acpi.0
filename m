From: bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org
Subject: Question about space handling
Date: Wed, 02 Apr 2003 18:14:32 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200304022314.h32NEWi28650@throb.netspace.org>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

I'm investigating the space handling issues on my Thinkpad R32 (and
others).  The problem is that some AML seems to fail with
AE_BAD_PARAMETER, as I reported on this list a week or two ago.  Lu
Tong came up with a hack that fixes it, but I'm trying to get a "real"
fix.

Anyway, I've tracked things down a bit and gotten the following
(heavily digested) info from debug traces:

evregion-0422 [26] ev_detach_region      : Removing Region cfec63a8 from address handler c135a128
evregion-0422 [26] ev_detach_region      : Removing Region cfeccfa8 from address handler c135a128
evregion-0535 [27] ev_attach_region      : Adding Region cfeccfa8 to address handler c135bda8 [EmbeddedControl]
evregion-0535 [27] ev_attach_region      : Adding Region cfec63a8 to address handler c135bda8 [EmbeddedControl]
evregion-0320 [43] ev_address_space_dispa: Addrhandler c135bda8 (c024cf8e), Address 000000000FF7BFC0

The AE_BAD_PARAMETER comes shortly after these messages.  

The first two lines seem to detach the "makeshift" handlers. The second
two are the handlers that are getting installed that are causing the
problem.  My question is how to I determine what  c135bda8 refers to(*)?


FWIW the new BIOS update that was mentioned on this list doesn't seem
to do very much of anything.  There's a one line change on the DSDT
and ECDT is still broken.  To add to the insult, it appears that
things have changed enough that you can't use the old corrected ecdt
table, you have to go through the rebuild process again.



(*)I suspect that if I could look at _all_ the tracing info, I'd be able to
find out, but I don't currently have a serial port, and there's more
information than can fit in the kmsg buffer (CONFIG_LOG_BUF_SHIFT of
greater than 21 prevents my machine from booting).  I was only able
to get this info by targeting areas I was interested in.  If someone
could give me a hint on where I should turn on tracing to get this
info I'd appreciated it.


--
Brian Perkins                bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org 



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
