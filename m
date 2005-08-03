From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Re: [PATCH] PNPACPI: fix types when decoding ACPI resources [resend]
Date: Wed, 3 Aug 2005 15:41:53 -0600
Message-ID: <200508031541.53777.bjorn.helgaas@hp.com>
References: <200508020955.54844.bjorn.helgaas@hp.com> <200508030920.13450.bjorn.helgaas@hp.com> <42F1343B.70707@free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42F1343B.70707-GANU6spQydw@public.gmane.org>
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

On Wednesday 03 August 2005 3:16 pm, matthieu castet wrote:
> Bjorn Helgaas wrote:
>  > On Tuesday 02 August 2005 7:01 pm, Shaohua Li wrote:
>  >>Did you have plan to remove other
>  >>legacy acpi drivers?
>  > No, I didn't -- which ones are you thinking about?  Looking at
>  > the callers of acpi_bus_register_driver(), I see:
> looking for METHOD_NAME__CRS is more acurate.

I didn't see any new ones when I looked for METHOD_NAME__CRS.

>  > 	drivers/char/hpet.c
>  > 		This probably should be converted to PNP.  I'll
>  > 		look into doing this.
> IIRC, I am not sure that the pnp layer was able to pass the 64 bits 
> memory adress for hpet correctly. But it would be nice if it works.

You're right, this was broken.  But I've been pushing a PNPACPI
patch to fix this.

> There was an extention of a floppy driver in order to use acpi in -mm, 
> but it seems to have been dropped.

Yeah, I did that, and it was a huge mistake.  The point was to avoid
blind probing for the device, but my concern was for ia64, and no ia64
boxes have floppy, so it's much easier to just not build the driver.

> PS : I saw in acpi ols paper that you plan once all dupe acpi drivers 
> will be removed to register again the pnp device in acpi layer. Do you 
> plan to add more check and for example add only device that have a CRS 
> in pnp layer ?

If you mean the last paragraph of section 6, I don't really understand
it.  But it mentions 8250_acpi.c as an obstacle, and I do know that we
are very close to being able to remove that.  I've already posted two
patches (one to PNPACPI to fix the 64-bit address problem, and one to
8250_pnp to add support for MMIO UARTs).  Once those are accepted, we
should be able to remove 8250_acpi.c.  I think only ia64 really relies
on it anyway.

> PPS : is there any plan to integrate 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111827568001255&w=2

I'm afraid I don't know anything about this one.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
