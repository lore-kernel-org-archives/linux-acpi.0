From: Vladimir Lazarenko <vlad-Qw1rWqDNyQwB085IDyDbTA@public.gmane.org>
Subject: Re: [ACPI] Where do I send APIC victims?
Date: Wed, 3 Sep 2003 15:04:03 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200309031504.03596.vlad@lazarenko.net>
References: <20030903080852.GA27649@k3.hellgate.ch> <1062589205.19059.6.camel@dhcp23.swansea.linux.org.uk> <20030903145356.35b9a192.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030903145356.35b9a192.skraw-DcQCyzbjH0jQT0dZR+AlfA@public.gmane.org>
Content-Disposition: inline
To: Stephan von Krawczynski <skraw-DcQCyzbjH0jQT0dZR+AlfA@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org, rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On my board, A7V8X, ACPI/APIC works just perfectly with 2.4.22 and KT400 
chipset, alas on A7N8X Deluxe board with nForce2 chipsets it causes nasty 
hangups.
Machine just simply freezes, no oops, nothing whatsoever.

Disabling APIC solved the problem.

--
Regards,
Vladimir

On Wednesday 03 September 2003 14:53, Stephan von Krawczynski wrote:
> On Wed, 03 Sep 2003 12:40:06 +0100
>
> Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org> wrote:
> > On Mer, 2003-09-03 at 11:48, Andrew de Quincey wrote:
> > > 2.4.22 has the ACPI from 2.6 backported into it, (which includes my
> > > patch for nforce2 boards) so it will start having the same issue with
> > > the BIOS bug in KT333/KT400  boards.
> >
> > It does - 2.4.22pre7 is great on my boxes, 2.4.22 final ACPI is
> > basically unusable on anything I own thats not intel.
>
> I can't back that. At least on all my Serverworks boxes there are no
> problems with ACPI. I got reports from VIA-bases SMP boards that they are
> doing well, too. (all for 2.4.22)
>
> Regards,
> Stephan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Best regards,
Vladimir Lazarenko
