From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] Fix _STA checking in acpi_bus_add
Date: Mon, 26 Jan 2004 09:15:02 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200401260915.02308.bjorn.helgaas@hp.com>
References: <200401021635.25419.bjorn.helgaas@hp.com> <1074919407.14755.6.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1074919407.14755.6.camel-D2Zvc0uNKG8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Friday 23 January 2004 9:43 pm, Len Brown wrote:
> Applied.

Thanks!

> ps. did you find this because you've got a system where the actual
> get_status failed, or the _STA returned !present and that was ignored?

Umm...  let's see... the latter, I guess.  I found this because
ia64 linux was complaining about some invalid ranges in _CRS on
the Intel Tiger box.  It turned out that the ranges all had
_LEN==0, and we should have been ignoring them anyway.

But somebody from HP-UX noticed that we were complaining about
ranges on a bridge that should have been !present according to
the _STA.

Now that you've applied this, we have to resolve the next issue
I found while investigating this: the chipset config interface
(CBN/CSFF) is reported as _STA==0x8, i.e., "functioning, but not
present".  We can't find anything in the spec on how to interpret
this.

The problem here is that since CBN/CSFF is !present, we won't
enumerate devices under them.  Therefore, we will no longer find
the AGP bridge on Big Sur.

Bjorn



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
