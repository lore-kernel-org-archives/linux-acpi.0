From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Subject: RE: DSDT in initrd
Date: Fri, 16 May 2003 07:58:46 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0305160753400.5724@dynast.gaugusch.at>
References: <A5974D8E5F98D511BB910002A50A6647054FC400@hdsmsx103.hd.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <A5974D8E5F98D511BB910002A50A6647054FC400-MgY+aF+eRfZviC08c4yzC1DQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On May 15, Brown, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> It makes me uneasy to append the DSDT to the initrd image.  This encumbers
> the initrd booting scheme with ACPI BIOS workarounds.  What happens when
> somebody changes how initrd works?
It's like everything in the kernel: If something changes and breaks
something else, the other things will be fixed as well, or the change will
be reverted. (or in the worst case, the other things will be removed).

> If appending a DSDT image to initrd is okay, why not append other things
> such as the ACPI black-list, for the same reasons?
The DSDT is one of the most dynamic things for ACPI hackers. If there is
the need to put other things into the initrd: no problem. The existing
patch should cooperate with bootsplash and should do so as well with other
'magic attachments'.

> I think I'd be happier with the DSDT being _in_ the initrd as a named
> file/module -- just like the other boot-time modules, rather than being
> magically appended to the image.
I'll try to find out if it is possible in any way. I think that filesystem
drivers are not available at this stage of booting (why should they? they
are not needed and it would probably be a big and ugly hack to load them
in such an early stage.)

> Of course this would require you to run mkinitrd for each platform;
> unless multiple named tables were included in the initrd.
That's the least problem.

Markus
-- 
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org     X     Against HTML Mail
                      / \


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
