From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] acpi4asus update
Date: 07 Feb 2004 02:19:21 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076138354.2558.1785.camel@dhcppc4>
References: <20040127221341.GA19793@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040127221341.GA19793-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Accepted.

thanks,
-Len

On Tue, 2004-01-27 at 17:13, Karol Kozimor wrote:
> Hi,
> The attached patch updates the acpi4asus driver to 0.27 through the
> following changes:
> - add support for M1300A, S5200N, L8400L,
> - remove WLED support for certain models, since it is not controlled by
>   AML,
> - add LCD backlight switching for L2E / L3H,
> - C99 initializers,
> - generic LED handlers,
> - the output of ASYM method to provide battery state information (might be
>   more accurate under certain conditions) in /proc/acpi/asus/info,
> - fix several oddities, various clean-ups and other minor changes.
> 
> The patch itself is quite big, which is mostly due to the C99 initializers
> and the fact that diff doesn't like moving code around.
> 
> This has been compile-tested in various configurations, the substantive
> changes were discussed on the acpi4asus mailing list.
> 
> The code should apply to current bk (both for 2.4 and 2.6). The patch is
> also available here:
> http://hell.org.pl/~sziwan/asus/acpi4asus-0.26-0.27.diff
> 
> Thanks to all the contributors (notably Pontus Fuchs) to this release.
> 
> Please apply, TIA,
> Best regards,



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
