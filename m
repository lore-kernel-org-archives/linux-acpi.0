From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: ACPI: Battery information?
Date: Thu, 10 Jun 2004 16:43:24 -0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040610164324.GA6919@message-id.gmane0305.slipkontur.de>
References: <40C4FD27.7000805@users.xeroprj.org> <20040608092045.72e15c4c@tethys.solarsys.org> <20040608094707.GM13782@poupinou.org> <40C58F45.2040108@users.xeroprj.org> <20040608113456.GN13782@poupinou.org> <40C6319A.7080707@users.xeroprj.org> <20040609075401.GT13782@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040609075401.GT13782-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 09, 2004 at 09:54:01AM +0200, Bruno Ducrot wrote:
> On Tue, Jun 08, 2004 at 02:37:30PM -0700, Binary Xerroz wrote:

> >    About the battery.c, the main reason for my modifications is
> > because to me ACPI for linux doesnt expect a battery to be removed
> > (physically) such as on a laptop. the modified code reruns check

Well, this works fine for me on a hp compaq nx5000 with 2 batteries.
So i suspect the quality of your BIOS / DSDT is to blame.

> > routines to make sure the battery is still there, if not its updated as
> > no present; before it still showed as present, but had critical status
> > and such, this patch fixes that and updates accordingly. Double check
> > routines added to make it work on status update instead of two.
> > Anything else, let me know.
> 
> ACPI support hotplug of batteries if the hardware generate an SCI (an
> interrupt), then a handler is called which will call an AML method which
> in turn will call a special opcode (Notify()).
> Then, after a Notify(FOO, 0x80) (or 0x81),
> drivers/acpi/battery::acpi_battery_notify() will be called which will
> reprobe the battery FOO (and (re)attach or detach to the acpi bus
> if needed).
> 
> So it's more likely a trouble somewhere in your DSDT, or a bug under linux.

As written above, it works for me under Linux.
 
> ps: my email client do not support HTML.  Would be fine if you can send
> at least a text alternative somehow.

indeed.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
