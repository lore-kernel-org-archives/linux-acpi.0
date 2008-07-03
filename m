From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
Subject: Re: [PATCH 1/1] ACPI: compal-laptop: use rfkill switch subsystem
Date: Thu, 3 Jul 2008 07:05:28 +0200
Message-ID: <20080703070528.2f0603a5@debian>
References: <20080702214524.2ba4a001@debian>
	<20080703021433.GC20410@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:3291 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732AbYGCFFf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jul 2008 01:05:35 -0400
Received: by fg-out-1718.google.com with SMTP id 19so259876fgg.17
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jul 2008 22:05:32 -0700 (PDT)
In-Reply-To: <20080703021433.GC20410@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-netdev@vger.kernel.org, Ivo van Doorn <ivdoorn@gmail.com>, linux-acpi@vger.kernel.org

Dnia 2008-07-02, o godz. 23:14:33
Henrique de Moraes Holschuh <hmh@hmh.eng.br> napisa=B3(a):

> BTW, it is a good idea to Cc linux-wireless on rfkill patches, and yo=
u
> *really* should be CCing the rfkill maintainer on any patches dealing=
 with
> rfkill IMHO.  That way, you get more reviews, rfkill isn't (unfortuna=
tely)
> easy to use.

Is there any reason why rfkill_unregister switches off radio rather tha=
n=20
leaving it in the current status?

--=20
 Cezary Jackiewicz
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
