From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [BUG] test9 ACPI bad: scheduling while atomic!
Date: Mon, 27 Oct 2003 09:47:09 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1067273229.7497.30.camel@patsy.fc.hp.com>
References: <Pine.GSO.4.58.0310262327040.19469@clyde>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.GSO.4.58.0310262327040.19469-8Uwgm7wxmYs@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Noah J. Misch" <noah-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jon-fdRWMHV75ajk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2003-10-27 at 01:22, Noah J. Misch wrote:

> This problem stems from the changes in revision 1.26 of drivers/acpi/ec.c.
> They come from a patch Shaohua Li submitted for kernel bug 1171 at
> bugme.osdl.org.  That patch can cause acpi_ec_gpe_query to run in interrupt
> context, whereas before it always ran from a workqueue.  It does non-interrupt
> like things, like sleeping and kmalloc'ing with GFP_KERNEL.
> 
> This was obvious on my system because it has no ECDT table, and as such
> acpi_ec_gpe_query was _always_ running in interrupt context, whereas with an
> ECDT it would only do so for a brief time during boot, and the problem would be
> much more subtle.  That's probably why nobody noticed this in earlier tests.
> 

  I don't have an ECDT either.  Is it possible that the setting of
ec_device_init = 1 is simply misplaced?  I can see why we wouldn't want
to call acpi_os_queue_for_execution() early in bootup, but there ought
to be a fixed point after which it's ok, regardless of whether the
system has the ECDT table.  Would it be sufficient to set ec_device_init
to 1 at the beginning of acpi_ec_add(), with no dependency on the ECDT
table?

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
