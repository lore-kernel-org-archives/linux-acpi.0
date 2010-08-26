From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 8/8] ideapad: Change the driver name to ideapad_laptop
Date: Thu, 26 Aug 2010 07:43:10 +0200
Message-ID: <AANLkTi=STq=_K2NPnK4GM+XwruaR09m6QJ7nkuCJVQvB@mail.gmail.com>
References: <1282120564-11324-1-git-send-email-ike.pan@canonical.com>
	<1282120734-11635-1-git-send-email-ike.pan@canonical.com>
	<alpine.LFD.2.00.1008251656090.3037@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33169 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581Ab0HZFnL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Aug 2010 01:43:11 -0400
In-Reply-To: <alpine.LFD.2.00.1008251656090.3037@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Ike Panhc <ike.pan@canonical.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <David.Woodhouse@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>

On Wed, Aug 25, 2010 at 10:56 PM, Len Brown <lenb@kernel.org> wrote:
>> =A0drivers/platform/x86/ideapad_acpi.c =A0 | =A0381 ----------------=
-----------------
>> =A0drivers/platform/x86/ideapad_laptop.c | =A0381 ++++++++++++++++++=
+++++++++++++++
>
> Acked-by: Len Brown <len.brown@intel.com>
>
> thanks,
> Len Brown, Intel Open Source Technology Center
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Probably not very important .. but .. other drivers are called *-laptop=
=2Ec, not
*_laptop.c ..

asus-laptop.c classmate-laptop.c compal-laptop.c dell-laptop.c eeepc-la=
ptop.c
fujitsu-laptop.c msi-laptop.c panasonic-laptop.c sony-laptop.c topstar-=
laptop.c

--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
