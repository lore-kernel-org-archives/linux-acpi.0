From: Emiliano Grilli <emiliano.grilli@poste.it>
Subject: Re: ACPI errors
Date: Mon, 5 Jun 2006 15:08:02 +0200
Message-ID: <20060605130802.GA3481@emillo.net>
References: <554C5F4C5BA7384EB2B412FD46A3BAD11206F0@pdsmsx411.ccr.corp.intel.com>
Reply-To: Emiliano Grilli <emiliano.grilli@poste.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out13.alice.it ([85.33.2.18]:47119 "EHLO out13.alice.it")
	by vger.kernel.org with ESMTP id S1751090AbWFENIW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2006 09:08:22 -0400
Content-Disposition: inline
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD11206F0@pdsmsx411.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Emiliano Grilli <emiliano.grilli@poste.it>, linux-acpi@vger.kernel.org

luned=EC, 05 giugno 2006 alle 20:49:44, Yu, Luming ha scritto:
>=20
> Sure, Please open a bug at bugzilla.kernel.org.
> Please post acpidump output, and dmesg.


Done.

Bug number is 6649:
http://bugzilla.kernel.org/show_bug.cgi?id=3D6649

=20
> Thanks,

Thanks to you :)

> Luming
>=20
> >I get a lot of these errors in dmesg:
> >
> > ACPI-0339: *** Error: Looking up [\_TZ_.THRM] in namespace,
> >AE_NOT_FOUND
> >search_node dfff7800 start_node dfff7800 return_node 00000000
> >    ACPI-0508: *** Error: Method execution failed [\_GPE._L1C] (Node
> >dfff7800), AE_NOT_FOUND
> >    ACPI-0549: *** Error: AE_NOT_FOUND while evaluating method [_L1C=
]
> >for GPE[ 0]
> >
> >This happens with 2.6.14 and 2.6.16 kernels
> >
> >
> >Can you help me?
> >
> >

--=20
Emiliano Grilli
Linux user #209089=20
http://www.emillo.net
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
