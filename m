From: David Moore <dcm-HInyCGIudOg@public.gmane.org>
Subject: RE: _PDC method in DSDT
Date: 22 Jun 2003 21:17:25 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1056341845.10322.44.camel@aldebaran.caltech.edu>
References: <00be01c33922$b8fb3cd0$b8d21b2b@ADACHIPC>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <00be01c33922$b8fb3cd0$b8d21b2b-5Bsh/8v8vXc@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Adachi, Kenichi" <adachi-fvZ7ij+YLgEZc9YY0SgeQc8NsWr+9BEh@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thanks, that's exactly what I needed.

Given this document, I think I have enough information now to patch
processor.c to support Enhanced Speedstep on Pentium M for those BIOSes
that have a correctly written _PDC method in the DSDT.  Would the
maintainers of the ACPI driver be willing to accept such a patch?

Regards,

David

On Sun, 2003-06-22 at 17:59, Adachi, Kenichi wrote:
> Hi,
> 
> > Does anyone know the purpose or specification of the _PDC method of
> the DSDT?  
> 
> It's another annoyance (?) added by Microsoft -); 
> Document is available online at the following URL:
> 
> "Windows Native Processor Performance Control"
> http://www.microsoft.com/whdc/hwdev/tech/onnow/procperfctrl.mspx
> 
> Thanks,
> - Adachi, Kenichi 
> 



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
