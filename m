From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: DSDT in initrd
Date: Thu, 15 May 2003 18:41:57 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <A5974D8E5F98D511BB910002A50A6647054FC400@hdsmsx103.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Michael Frank' <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> IMHO this patch is very useful because it provides the 
> equivalent of a "DSDT module" and avoids building a kernel 
> for each DSDT.

This is the 1st reason I've seen for not simply using an ACPI_DSDT_OVERRIDE
config option to pull a DSDT into the kernel from a well-known file name.

I figure that the set of people who go to the trouble to get a custom DSDT
are mostly included in the set of people who config and build a kernel for
their system.  As such, ACPI_DSDT_OVERRIDE would be simple and sufficient --
without requiring admins to change any code.

It makes me uneasy to append the DSDT to the initrd image.  This encumbers
the initrd booting scheme with ACPI BIOS workarounds.  What happens when
somebody changes how initrd works?  If appending a DSDT image to initrd is
okay, why not append other things such as the ACPI black-list, for the same
reasons?

I think I'd be happier with the DSDT being _in_ the initrd as a named
file/module -- just like the other boot-time modules, rather than being
magically appended to the image.  Of course this would require you to run
mkinitrd for each platform; unless multiple named tables were included in
the initrd.

-Len


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
