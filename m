From: "M. Warner Losh" <imp-uzTCJ5RojNnQT0dZR+AlfA@public.gmane.org>
Subject: Re: Re: [PATCH] bad strlcpy conversion breaks toshiba_acpi
Date: Sun, 27 Jul 2003 15:26:20 -0600 (MDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030727.152620.127108646.imp@bsdimp.com>
References: <20030725161510.GA31565@vana.vc.cvut.cz>
	<20030725165709.GA670@win.tue.nl>
	<20030727210203.GU1485@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030727210203.GU1485-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org
Cc: aebr-ek1Qb6IBo2Pz+pZb47iToQ@public.gmane.org, vandrove-hnqZr3NxcozrBKCeMvbIDA@public.gmane.org, jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org, bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, torvalds-3NddpPZAyC0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, gan-28sE0Wxkf/LCXR85Y8Hu3Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In message: <20030727210203.GU1485-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
            Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org> writes:
: On Fri, Jul 25, 2003 at 06:57:09PM +0200, Andries Brouwer wrote:
: > strlcpy is for strings, not for character arrays.
: > The *BSD version accesses the source past the size-1 characters
: > that are copied: 
: > 	while (*s++)
: > 		;
: > Thus, replacing strncpy (used to copy character arrays, possibly
: > not 0-terminated) by strlcpy is wrong.

Ah, that's to get the silly return value correct :-(.

Warner


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
