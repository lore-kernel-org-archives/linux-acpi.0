From: "Noah J. Misch" <noah-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org>
Subject: Re: [BUG] test9 ACPI bad: scheduling while atomic!
Date: Mon, 27 Oct 2003 10:02:37 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GSO.4.58.0310270929010.14546@blinky>
References: <Pine.GSO.4.58.0310262327040.19469@clyde> <1067273229.7497.30.camel@patsy.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1067273229.7497.30.camel-Wmjt7DDUnIVxnVILBQAtiA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jon-fdRWMHV75ajk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 27 Oct 2003, Alex Williamson wrote:

> > This was obvious on my system because it has no ECDT table, and as such
> > acpi_ec_gpe_query was _always_ running in interrupt context, whereas with an
> > ECDT it would only do so for a brief time during boot, and the problem would be
> > much more subtle.  That's probably why nobody noticed this in earlier tests.
> >
>
>   I don't have an ECDT either.  Is it possible that the setting of
> ec_device_init = 1 is simply misplaced?

It is misplaced.  If revision 1.26 of ec.c were otherwise sound, I would place
ec_device_init = 1 right before the call to acpi_install_gpe_handler in
acpi_ec_start.  Anywhere outside that if and between where _add removes the
handlers and _start installs them would work.  This would fix your crash, but
it's not the right fix.

> I can see why we wouldn't want to call acpi_os_queue_for_execution() early in
> bootup, but there ought to be a fixed point after which it's ok, regardless of
> whether the system has the ECDT table.

I don't think early calls to schedule_work (via acpi_os_queue_for_execution) are
a problem.  The call to init_workqueues is just before do_initcalls in
do_basic_setup, so it happens earlier than all this stuff.

The more general problem is that acpi_ec_gpe_query cannot run in an interrupt
handler as written.  It used to always run from a queue.  We can either fix it
so it can run from an interrupt handler or change it back to never doing so.  I
favor the latter, especially because I don't see how the recent change fixed the
problem T40 users were experiencing.

> Would it be sufficient to set ec_device_init to 1 at the beginning of
> acpi_ec_add(), with no dependency on the ECDT table?

That particular placement looks racy.  I would do it after removing the
handlers, as explained above.

Thanks,
Noah



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
