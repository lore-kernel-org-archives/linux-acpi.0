From: Xavier Bestel <xavier.bestel@free.fr>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Thu, 20 Apr 2006 22:07:03 +0200
Message-ID: <1145563624.14595.5.camel@bip.parateam.prv>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com>
	 <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com>
	 <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com>
	 <1145549460.23837.156.camel@capoeira> <4447B7D6.4030401@linux.intel.com>
	 <d120d5000604201230y48493995l1bb13d01a8122e11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.wanadoo.fr ([193.252.22.29]:2494 "EHLO smtp2.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1751236AbWDTUGy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Apr 2006 16:06:54 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0204.wanadoo.fr (SMTP Server) with ESMTP id 583E51C00233
	for <linux-acpi@vger.kernel.org>; Thu, 20 Apr 2006 22:06:53 +0200 (CEST)
In-Reply-To: <d120d5000604201230y48493995l1bb13d01a8122e11@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dtor_core@ameritech.net
Cc: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Le jeudi 20 avril 2006 =E0 15:30 -0400, Dmitry Torokhov a =E9crit :
> On 4/20/06, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.co=
m> wrote:
> > Xavier Bestel wrote:
> > > There are keyboards with power/sleep buttons. It makes sense they=
 have
> > > the same behavior than ACPI buttons.
> > Agree, make them behave like ACPI buttons -- remove them from input=
 stream, as they do not belong there...
>=20
> What if there is no ACPI? What if I want to remap the button to do
> something else? Input layer is the proper place for them.

Err .. that's what I meant, sorry I was not clear. Matthew's solution
looks right.

	Xav


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
