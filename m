From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: resource for S3 suspend/resume of Radeon
Date: Mon, 17 Mar 2003 10:12:33 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0303171006240.17506-100000@osdlab.pdx.osdl.net>
References: <1047915331.28836.45.camel@dutidad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1047915331.28836.45.camel-1Jw6Eky0yc0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On 17 Mar 2003, Charl P. Botha wrote:

> On Mon, 2003-03-17 at 15:42, Charl P. Botha wrote:
> > benh and ATI seem to have fixed the suspension code of the radeon.  I
> > have looked at this (see the Radeon bits) and at Patrick Mochel's power
> > management architecture code and documentation and it does look like a
> > lot of this code could be used to make ACPI S3 (suspend to RAM) a
> > reality on Radeon-using laptops.
>
> Hmmm, this might not be AS useful as I thought.  Could a pmac expert
> elaborate on the differences between its suspend and ACPI S3?  For S3 we
> need something that can init the chip almost from scratch.

The concepts are identical - the OS must suspend/resume devices before
telling the platform to enter the sleep state. And, the code should be
identical. IIRC, the pmac doesn't ever have the liberty of re-POSTing any
devices, as the OpenFirmware context is completely lost after booting.
In general, the pmac is a few steps ahead of x86 in terms of power
management support.

On top of that, Ben is incredibly talented and has the benefit (or curse
;) of knowing both power management and the ATI cards very well.


	-pat



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
