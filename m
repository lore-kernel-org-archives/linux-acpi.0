From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: Convert PRINT_DEBUG(DB_ERROR/WARNING,...) to ACPI_ERROR/WARNING
Date: Mon, 6 Feb 2006 18:00:39 -0800
Message-ID: <20060206180039.6754a2d1.rdunlap@xenotime.net>
References: <971FCB6690CD0E4898387DBF7552B90E0440B4A2@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:64391 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932439AbWBGCAG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2006 21:00:06 -0500
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-acpi@vger.kernel.org>; Mon, 6 Feb 2006 18:00:03 -0800
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E0440B4A2@orsmsx403.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: trenn@suse.de, linux-acpi@vger.kernel.org, len.brown@intel.com

On Mon, 6 Feb 2006 15:06:24 -0800 Moore, Robert wrote:

> I meant, EXPORT_SYMBOLS is Linux-specific and belongs in a
> linux-specific header (wherever the rest of the ACPICA public symbols
> are exported)

a.  All of these files in drivers/acpi/ use EXPORT_SYMBOL:

./bus.c
./ec.c
./events/evxface.c
./events/evxfevnt.c
./events/evxfregn.c
./glue.c
./hardware/hwregs.c
./hardware/hwsleep.c
./hardware/hwtimer.c
./namespace/nsxfeval.c
./namespace/nsxfname.c
./namespace/nsxfobj.c
./numa.c
./osl.c
./pci_bind.c
./pci_irq.c
./pci_root.c
./processor_core.c
./processor_perflib.c
./resources/rsxface.c
./scan.c
./tables/tbconvrt.c
./tables/tbxface.c
./tables/tbxfroot.c
./utilities/utdebug.c
./utilities/utglobal.c
./utilities/utxface.c
./utils.c

b.  Linux convention is to put EXPORT_SYMBOL[_GPL]() close to the
symbol that is being exported.

c.  Thomas, please use "diffstat -p1" so that we get directory names
in the diffstat.


> > -----Original Message-----
> > From: Thomas Renninger [mailto:trenn@suse.de]
> > Sent: Monday, February 06, 2006 3:01 PM
> > To: Moore, Robert
> > Cc: ACPI-ML; Brown, Len
> > Subject: Re: Convert PRINT_DEBUG(DB_ERROR/WARNING,...) to
> > ACPI_ERROR/WARNING
> > 
> > Moore, Robert wrote:
> > >> Also added the EXPORT_SYMBOLS(ut_warning/error/exception) function
> > > decl.
> > >> in
> > >> (in a separated patch -> ACPICA, acpi/utilities/utmisc.c).
> > >
> > > Don't these belong somewhere else?
> > I thought everything in subdirs is ACPICA...
> > 
> > >
> > >> Also added errors inside remove/install handler funcs (in a
> separated
> > >> patch -> ACPICA,
> > >> acpi/events/evxface.c).
> > >
> > > So, you are saying that there are insufficient error messages in
> > > evxface.c, I'll look at it.
> > >
> > 
> > Grep in the big one for acpi_remove_notify_handler or
> > "Error installing notify handler" ...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


---
~Randy
