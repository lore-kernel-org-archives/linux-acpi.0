From: Stefan =?utf-8?q?D=C3=B6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: pci device resume too early?
Date: Wed, 28 Jul 2004 21:18:52 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200407282118.52624.stefandoesinger@gmx.at>
References: <200407281953.39159.stefandoesinger@gmx.at> <1091038485.15464.9.camel@tyrosine>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1091038485.15464.9.camel-myFlNLNQP+Q@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

> Ooh, neat. This might explain the problems I have with yenta resuming on
> my Thinkpad 240X. pci_restore_state is called from drivers/pci/pci-
> driver.c (see pci_default_resume), and from some specific drivers (it
> can probably be removed from them now though, really). That gets called
> from the chain of things called in device_resume in
> drivers/base/power/resume.c - it steps through each registered driver
> and calls the associated resume method. For PCI stuff, that will either
> be pci_default_resume or a driver-specific resume method. device_resume
> is called from suspend_finish in kernel/power/main.c.

Thanks for the informations.
I moved device_resume(); in suspend_finish to be called after 
pm_ops->finish(state); and my system resumes MUCH nicer.
Sound resume works, usb-uhci resume works, ehci pci restore works. My suspend 
script will shink a lot.

That's what suspend_finish looks like:

static void suspend_finish(u32 state)
{
	if (pm_ops && pm_ops->finish)
		pm_ops->finish(state);
	device_resume();	/*Call it after pm_ops->finish*/	
	thaw_processes();
	pm_restore_console();
}

Can you try if this helps your yenta?



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
