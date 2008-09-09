From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: patch for bugs 9998 and 10724
Date: Tue, 09 Sep 2008 17:13:03 +0800
Message-ID: <1220951583.3989.85.camel@yakui_zhao.sh.intel.com>
References: <1219730254.4116.38.camel@yakui_zhao.sh.intel.com>
	 <20080904121820.GC18288@one.firstfloor.org> <48BFD5AA.3090006@suse.de>
	 <48BFD609.2050604@suse.de> <1220581596.3441.2.camel@rzhang-dt>
	 <48C129D3.5000904@suse.de> <1220842582.3441.30.camel@rzhang-dt>
	 <48C4E15F.2020701@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28020 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754615AbYIII6i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Sep 2008 04:58:38 -0400
In-Reply-To: <48C4E15F.2020701@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Zhang Rui <rui.zhang@intel.com>, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

Hi, Alexey
    You attached the updated patch on the bug 10724/9998.
    Can the following situation be handled by your patch?(For example:
bug 10724)
       EC GPE Interrupt storm is detected and EC GPE will be disabled
when doing EC transaction.=20
       If EC notification event happens while doing EC transaction(EC
GPE is disabled), the SCI_EVT bit of EC status register is cleared
automatically before we can handle it.=20
       Can the EC notification event be handled by OS?

 Thanks
     Yakui.
> Zhang Rui wrote:
> > On Fri, 2008-09-05 at 16:45 +0400, Alexey Starikovskiy wrote:
> >> Zhang Rui wrote:
> >>> On Thu, 2008-09-04 at 16:35 +0400, Alexey Starikovskiy wrote:
> >>>> Here is the same patch as attachment for your convenience.
> >>>> Alexey Starikovskiy wrote:
> >>>>> Hi Andy,
> >>>>>
> >>>>> I just uploaded patch for bugs 9998 and 10724, which solves the=
 problem=20
> >>>>> of interrupt storm more cleanly.
> >>>>> Could you please add this patch to testing?
> >>>>>
> >>>>> Thanks,
> >>>>> Alex.
> >>>>>
> >>>>>
> >>> =EF=BB=BF+       ec->t.command =3D 0;
> >>> +       if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
> >>> +               /* check if we received SCI during transaction */
> >>> +               ec_check_sci(ec, acpi_ec_read_status(ec));
> >>> +               /* it is safe to enable GPE outside of transactio=
n */
> >>> +               acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
> >>> +       } else if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
> >>> +                  atomic_read(&ec->irq_count) >
> >>> ACPI_EC_STORM_THRESHOLD)
> > +	{
> >>> +               pr_debug(PREFIX "GPE storm detected\n");
> >>> +               set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
> > +	}
> Thanks!
> >=20
> >=20
> > thanks,
> > rui
> >=20
> >>> +       return 0;
> >>> +}
> >>>
> >>> you will set the =EF=BB=BFEC_FLAGS_GPE_STORM flag in every ec tra=
nsaction.
> >>> I don't think that's what you/we want. :)
> >> please elaborate...
> >> If EC_FLAGS_GPE_STORM is set once, I will not get there (else).
> >=20
> >=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
