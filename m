From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] ACPI: implement UUID-labelled vendor-defined resources
Date: Tue, 20 Sep 2005 17:09:57 -0600
Message-ID: <200509201709.57955.bjorn.helgaas@hp.com>
References: <971FCB6690CD0E4898387DBF7552B90E02C0B5F2@orsmsx403.amr.corp.intel.com> <200509190931.20643.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200509190931.20643.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>, "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 19 September 2005 9:31 am, Bjorn Helgaas wrote:
> > BTW, Please explain in more detail what support is needed in ACPICA for
> > the ACPI 3.0 vendor-defined resource.  Also, any idea how we are
> > supposed to determine if the UUID data exists within the descriptor?
> > (i.e., how do we differentiate an ACPI 2.0 vendor descriptor from an
> > ACPI 3.0 descriptor?)
> 
> There's no mark that distinguishes 2.0 and 3.0 vendor descriptors.
> As far as I can tell, a 3.0 descriptor (that contains a UUID and
> sub-type) is also a perfectly valid 2.0 descriptor.
> 
> ACPI 3.0 "strongs recommends," but apparently doesn't actually
> require a UUID, so a 2.0 vendor descriptor should also be a valid
> 3.0 descriptor.
> 
> The idea is that we just look through all the vendor descriptors
> for the supplied UUID.  If we find one, we return the information.
> There's a small possibility that an ACPI 2.0, non-UUID-labelled
> descriptor will contain data that happens to match the random
> 16-byte UUID, and we'll return it by mistake.  But that possibility
> is pretty remote, I think.

Ping...  Did this make any sense, or did I answer the wrong questions?


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
