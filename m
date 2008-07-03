From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
Subject: Re: [PATCH 1/1] ACPI: compal-laptop: use rfkill switch subsystem
Date: Thu, 3 Jul 2008 06:48:18 +0200
Message-ID: <20080703064818.35ee2532@debian>
References: <20080702214524.2ba4a001@debian>
	<20080703021433.GC20410@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:45180 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbYGCEsZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jul 2008 00:48:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so258363fgg.17
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jul 2008 21:48:23 -0700 (PDT)
In-Reply-To: <20080703021433.GC20410@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ak@linux.intel.com, Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Dnia 2008-07-02, o godz. 23:14:33
Henrique de Moraes Holschuh <hmh@hmh.eng.br> napisa=B3(a):

[...]
> That doesn't look like a new-style (i.e. what is in net-next-2.6) rfk=
ill
> support.  Could you take a look on the new (and I sure hope, vastly
> improved) Documentation/rfkill.txt in net-next-2.6, and switch the dr=
iver to
> RFKILL_STATE_UNBLOCKED, RFKILL_STATE_SOFT_BLOCKED, etc?  After a quic=
k look,
> it looks like Compal won't need RFKILL_STATE_HARD_BLOCKED  (thinkpad-=
acpi
> does, because some thinkpads have a master wireless kill switch), but
> still...

Compal has hardware wireless kill switch (without software it kill all =
radios
rf and disconnecting bluetooth from usb bus). Does he should generate
SW_RFKILL_ALL or something like this?

--=20
 Cezary Jackiewicz
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
