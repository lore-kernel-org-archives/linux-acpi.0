From: Ole Myren Rohne <ole.rohne-vJEk5272eHo@public.gmane.org>
Subject: Re: S3 wakeup code
Date: 25 Jul 2003 14:25:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3r84eaj3z.fsf@localhost.localdomain>
References: <20030723152809.GA591@paradigm.rfc822.org>
	<20030723162423.GD9013@atrey.karlin.mff.cuni.cz>
	<1059041888.19684.8.camel@bacchus.gpphy.uni-duesseldorf.de>
	<20030724104518.GA12041@paradigm.rfc822.org>
	<1059045536.19684.21.camel@bacchus.gpphy.uni-duesseldorf.de>
	<20030724144535.GA629@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030724144535.GA629-L3tpvOS5ZD2KugBFyThYrEB+6BGkLq7r@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Florian Lohoff <flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org>
Cc: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Florian Lohoff <flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org> writes:

> > * Insert lcall $0xffff,$0 or machin_restart in various places in    
> >   wakeup.S and upwards and see if your machine reboots on S3 resume
> 
> Ok - i tried this - Doesnt work - Machine seems not to execute the
> wakeup code at all.

IIRC, at one point linux wrote the kernel VM address to the firmware
wakeup vector, typically 0xc0000000 + hardware address. Now, there is
of course only one way to interpret that as a real-mode seg:off
address, but it did strike me as weird. I once checked that the
leading 0xc is irrelevant on my P2120, but YMMV.

I would also check that the suspend/resume doesn't choke somewhere in
32-bit land by jumping over the call to acpi_enter_sleep_state in
wakeup.S.

Ole





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
