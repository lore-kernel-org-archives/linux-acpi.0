From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH] bad strlcpy conversion breaks toshiba_acpi
Date: Sun, 27 Jul 2003 22:02:03 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030727210203.GU1485@parcelfarce.linux.theplanet.co.uk>
References: <3F2142CE.4090608@prairienet.org> <20030725161510.GA31565@vana.vc.cvut.cz> <20030725165709.GA670@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030725165709.GA670-ek1Qb6IBo2Pz+pZb47iToQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andries Brouwer <aebr-ek1Qb6IBo2Pz+pZb47iToQ@public.gmane.org>
Cc: Petr Vandrovec <vandrove-hnqZr3NxcozrBKCeMvbIDA@public.gmane.org>, John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>, Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Michael Wawrzyniak <gan-28sE0Wxkf/LCXR85Y8Hu3Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 25, 2003 at 06:57:09PM +0200, Andries Brouwer wrote:
> strlcpy is for strings, not for character arrays.
> The *BSD version accesses the source past the size-1 characters that are copied:
> 	while (*s++)
> 		;
> Thus, replacing strncpy (used to copy character arrays, possibly not 0-terminated)
> by strlcpy is wrong.

But using strncpy() is _also_ wrong because of its NUL-padding behaviour.
There's really four different situations and strncpy is only suitable
for one of them:

a) Copy at most n bytes of a string to another string (strlcpy)
b) Copy at most n bytes from a character array into a string (strncat?)
c) Copy at most n bytes from a string to a character array that will
   be returned to user space (strncpy)
d) Copy n bytes from one character array to another (memcpy)

stpcpy is another interesting variant on the awful strcpy, but we'd need
a stpncpy too.  strncat is a little dubious for case (b) since you need
to initialise the dest with a NUL in the first byte.

C's string handling sucks, and everybody knows it.  Making strings a first
class object may be a cure worse than the disease (for the intended use
of C; for scripting languages it makes perfect sense).

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
