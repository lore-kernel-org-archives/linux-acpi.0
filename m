From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Re: [PATCH] PNPACPI: fix types when decoding ACPI resources [resend]
Date: Thu, 4 Aug 2005 09:57:55 -0600
Message-ID: <200508040957.55485.bjorn.helgaas@hp.com>
References: <200508020955.54844.bjorn.helgaas@hp.com> <200508031541.53777.bjorn.helgaas@hp.com> <42F20C5B.3020506@free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42F20C5B.3020506-GANU6spQydw@public.gmane.org>
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
To: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 04 August 2005 6:38 am, matthieu castet wrote:
> Bjorn Helgaas wrote:
> > On Wednesday 03 August 2005 3:16 pm, matthieu castet wrote:
> >>Bjorn Helgaas wrote:
> >> > 	drivers/char/hpet.c
> >> > 		This probably should be converted to PNP.  I'll
> >> > 		look into doing this.
> >>IIRC, I am not sure that the pnp layer was able to pass the 64 bits 
> >>memory adress for hpet correctly. But it would be nice if it works.
> > 
> > You're right, this was broken.  But I've been pushing a PNPACPI
> > patch to fix this.
> > 
> Yes but is ACPI_RSTYPE_ADDRESS64 possible on 32 bit machine ?

I can't think of a case where that would make sense, but I don't
actually know the answer.

> In this case your patch won't work as res->mem_resource[i].start and 
> res->mem_resource[i].end are unsigned long, and 64 bit value won't fit.

True.  But fixing that would be pretty far-reaching (changing struct
resource), so I'm not worried until it is shown to be a problem.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
