From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI events generated on PCI usage.
Date: 09 Feb 2004 23:03:58 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076385838.4105.495.camel@dhcppc4>
References: <20040207224901.34064.qmail@web9607.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040207224901.34064.qmail-D/IqPAlx7LewAeGFf/znCBupM2+RrINj@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Chad LeClair <sesca256-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Chad,
Please file a bug and attach the output of acpidmp with full dmesg.

thanks,
-Len

On Sat, 2004-02-07 at 17:49, Chad LeClair wrote:
> Since upgrading to the 2.6 series of kernel I have
> noticed the events/0 process consuming processor time
> any time I use a PCI device. For example, when I play
> sound on my SB Live, the events/0 consumes ~15% of my
> processor. It doesn't effect AGP, or onboard devices.
> I turned ACPI debugging on and found that when these
> devies are in use a constant stream of DEVICE WAKE
> events are generated.  
> 
> Is there any way to prevent or ignore these events to
> avoid wasting processor time on them? 
> 
> Debug log with debug_level=0xff:
> 
...
> acpi_bus-0492 [15] acpi_bus_notify       : Received
> DEVICE WAKE notification for device [PCI0]




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
