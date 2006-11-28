From: Thomas Renninger <trenn@suse.de>
Subject: Re: Broken DSDT (ASUS A6Km, Sempron 3300+)
Date: Tue, 28 Nov 2006 11:50:08 +0100
Message-ID: <1164711008.4656.232.camel@queen.suse.de>
References: <1164651563.12120.3.camel@frodo>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:23782 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S933570AbWK1KuM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Nov 2006 05:50:12 -0500
In-Reply-To: <1164651563.12120.3.camel@frodo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mirekmajka@o2.pl
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

On Mon, 2006-11-27 at 19:19 +0100, Miros=C5=82aw Majka wrote:
> Hi,
>=20
> I've been sent to You by Ling Yu. don't know how to repair my broken
> DSDT. I've tried some of those sent to the ACPI for linux page but no=
ne
> of them works perfectly. I don't know where to send my decompiled cod=
e
> to search for some anwsers. Can I send my DSDT to You to have it
> examined and for some tips on how to fix it?

If this is about that your asus model specific stuff like hotkeys or
whatever is not supported well you may want to try:
linux-acpi@vger.kernel.org

If you have the possibility to upload the acpidump or DSDT and point to
it it's best, if not just give it a try, I just saw some tables attache=
d
there.



If you have a general ACPI problem you are right here.
Best is you describe your problem a bit first.
What function does not work?
Do you see kernel errors/warnings (pls C&P them)?


In general you should not override the DSDT table at all!
Hmm, asus could be a smart battery machine? If yes throw away all DSDT
tables you downloaded and try the new sbs module.

Maybe these SBS workaround DSDT tables should get marked somehow that
there is support for this feature since kernel xy, if this is possible?

So, before sending anything, pls describe your problem.

Thanks,

    Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
