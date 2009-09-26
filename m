From: "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>
Subject: Re: [PATCH 5/6] thinkpad-acpi: add internal hotkey event API
Date: Sat, 26 Sep 2009 10:48:05 -0300
Message-ID: <1253972885.13490.1336737611@webmail.messagingengine.com>
References: <1253466567-4285-1-git-send-email-hmh@hmh.eng.br>
 <1253466567-4285-6-git-send-email-hmh@hmh.eng.br>
 <1253955570.3897.4.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38512 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751462AbZIZNsC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Sep 2009 09:48:02 -0400
In-Reply-To: <1253955570.3897.4.camel@ht.satnam>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Sat, 26 Sep 2009 14:29 +0530, "Jaswinder Singh Rajput" <jaswinder@ke=
rnel.org> wrote:
> > +/*
> > + * Sets the driver hotkey mask.
> > + *
> > + * Can be called even if the hotkey subdriver is inactive
> > + */
> > +static int tpacpi_hotkey_driver_mask_set(const u32 mask)
>=20
>=20
>   CC [M]  drivers/platform/x86/thinkpad_acpi.o
> drivers/platform/x86/thinkpad_acpi.c:2225: warning:
> =E2=80=98tpacpi_hotkey_driver_mask_set=E2=80=99 defined but not used

The function is used by another patch, which is waiting for its
prerequisites to be merged through the backlight tree.

That patch has already been sent to linux-acpi as well.

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
