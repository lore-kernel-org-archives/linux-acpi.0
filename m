From: Manish Prasad <mprasad-EX0cT3Az47bauI2f2gSDlQ@public.gmane.org>
Subject: RE: ACPI newbie: Device Power Consumption at Dx states
Date: Mon, 17 Mar 2003 15:56:35 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GSO.4.53.0303171529050.22027@compserv1>
References: <F760B14C9561B941B89469F59BA3A84725A1FB@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A1FB-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thanks for the reply, Andy !

>
> I don't think it is in there. The device's driver is responsible for
> doing any runtime power management based upon, say, idle detection, so
> it may know, but ACPI doesn't know.
>
But, the device manufacturer would know how much power it'll draw at each
of its supported power states. For example, if a hard disk supports 3
(Dx) states viz.
- full power on, disk spinning
- disk spun down, disk cache context maintained
- disk spun down. disk cache context cleared
... the manufacturer would know how much power the disk would consume in
each of these states. So I wonder why the ACPI spec. doesn't support an
interface for the device to expose power consumption information for each
of its Dx states, when in fact it does support control method objects to
query the various power states supported and power resource requirements
(power planes, clock sources etc.) at each of the states.

Best Regards,
--Manish


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
