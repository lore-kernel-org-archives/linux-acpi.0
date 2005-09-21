From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Re: [PATCH] PNPACPI: handle address descriptors in _PRS
Date: Wed, 21 Sep 2005 09:27:03 -0600
Message-ID: <200509210927.03377.bjorn.helgaas@hp.com>
References: <200509201626.15973.bjorn.helgaas@hp.com> <1127265452.4040.3.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1127265452.4040.3.camel-ECwVeV2eNyQD0+JXs3kMbRL4W9x8LtSr@public.gmane.org>
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
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 20 September 2005 7:17 pm, Shaohua Li wrote:
> On Tue, 2005-09-20 at 16:26 -0600, Bjorn Helgaas wrote:
> > PNPACPI complained about and ignored devices with ADDRESS16, ADDRESS32,
> > or ADDRESS64 descriptors in _PRS.  Those descriptors seem legitimate,
> > and HP firmware uses them for built-in serial ports, so this patch adds
> > support for them.

> You might have missed the similar change in pnpacpi_encode_resources in
> your patch. It's used when we assign new resources (_SRS method) to pnp
> devices.

You're right, I did miss the corresponding encoding change.  I'll
add that.  I feel a bit uneasy about it, though, because it will be
a fair amount of code, and I don't know how to test it.  Do we ever
really use _SRS today?  And there's information lost when decoding
the ACPI resources, such as the _TRA.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
