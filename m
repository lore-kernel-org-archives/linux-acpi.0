From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: patch for bugs 9998 and 10724
Date: Fri, 05 Sep 2008 10:26:36 +0800
Message-ID: <1220581596.3441.2.camel@rzhang-dt>
References: <1219730254.4116.38.camel@yakui_zhao.sh.intel.com>
	 <20080904121820.GC18288@one.firstfloor.org> <48BFD5AA.3090006@suse.de>
	 <48BFD609.2050604@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13817 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962AbYIEC1X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Sep 2008 22:27:23 -0400
In-Reply-To: <48BFD609.2050604@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Thu, 2008-09-04 at 16:35 +0400, Alexey Starikovskiy wrote:
> Here is the same patch as attachment for your convenience.
> Alexey Starikovskiy wrote:
> > Hi Andy,
> >=20
> > I just uploaded patch for bugs 9998 and 10724, which solves the pro=
blem=20
> > of interrupt storm more cleanly.
> > Could you please add this patch to testing?
> >=20
> > Thanks,
> > Alex.
> >=20
> >=20
>=20
=EF=BB=BF+       ec->t.command =3D 0;
+       if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
+               /* check if we received SCI during transaction */
+               ec_check_sci(ec, acpi_ec_read_status(ec));
+               /* it is safe to enable GPE outside of transaction */
+               acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
+       } else if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
+                  atomic_read(&ec->irq_count) >
ACPI_EC_STORM_THRESHOLD)
+               pr_debug(PREFIX "GPE storm detected\n");
+               set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
+       return 0;
+}

you will set the =EF=BB=BFEC_FLAGS_GPE_STORM flag in every ec transacti=
on.
I don't think that's what you/we want. :)

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
