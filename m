From: Philippe =?iso-8859-1?q?Cl=E9ri=E9?= <philippe-vlmYvWlZpDU@public.gmane.org>
Subject: Re: General ACPI/Linux question
Date: Sun, 26 Jan 2003 12:10:10 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301261210.10345.philippe@gcal.net>
References: <1043546064.14472.9.camel@nefeli> <200301260823.35858.philippe@gcal.net> <1043596509.1683.8.camel@nefeli>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1043596509.1683.8.camel-coIz1MXBdV0@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>
> Could you or anybody else perhaps provide some feedback on
> the attached image? I have compiled a vanilla 2.4.20 with
> acpi-20021212-2.4.20.diff. When I try to boot it freezes at
> the point of the attached (camera captured - ~280K image)
> point.
>
> http://mit.edu/costas/www/img_0092.jpg
>
> Please let me know if any other information would help.
>

I should have mentionned earlier that the only way the thing 
would boot is to add pci=noacpi to the kernel boot params. 
Sorry for the omission.

Regards,
Philippe


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
