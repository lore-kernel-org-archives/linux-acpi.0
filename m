From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: pci device resume too early?
Date: Wed, 28 Jul 2004 19:14:45 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1091038485.15464.9.camel@tyrosine>
References: <200407281953.39159.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200407281953.39159.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-07-28 at 19:53 +0200, Stefan D=C3=B6singer wrote:

> The problem is that directly after S3 resume, any attempt to write to pci=
=20
> configuration registers of three of my devices(00:1d.7, 00:1f.5, 00:1f.6)=
=20
> locks up my system. After some testing, I found out that pci_restore_stat=
e=20
> works nice if I place it into a function which is scheduled with=20
> schedule_delayed_work. I use my dummydriver module for testing.

Ooh, neat. This might explain the problems I have with yenta resuming on
my Thinkpad 240X. pci_restore_state is called from drivers/pci/pci-
driver.c (see pci_default_resume), and from some specific drivers (it
can probably be removed from them now though, really). That gets called
from the chain of things called in device_resume in
drivers/base/power/resume.c - it steps through each registered driver
and calls the associated resume method. For PCI stuff, that will either
be pci_default_resume or a driver-specific resume method. device_resume
is called from suspend_finish in kernel/power/main.c.

--=20
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
