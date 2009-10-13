From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 2/2] eeepc-laptop: Prevent a panic when disabling RT2860
	wireless when associated
Date: Tue, 13 Oct 2009 10:25:36 +0200
Message-ID: <71cd59b00910130125x2af5bba3j5089b3eea34dfe17@mail.gmail.com>
References: <1255385613-25400-1-git-send-email-corentincj@iksaif.net>
	 <1255385613-25400-2-git-send-email-corentincj@iksaif.net>
	 <1255385613-25400-3-git-send-email-corentincj@iksaif.net>
	 <alpine.LFD.2.00.0910130126560.9285@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:41463 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759178AbZJMI0N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Oct 2009 04:26:13 -0400
Received: by ywh6 with SMTP id 6so8792228ywh.4
        for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2009 01:25:36 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0910130126560.9285@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Darren Salt <linux@youmustbejoking.demon.co.uk>

On Tue, Oct 13, 2009 at 7:26 AM, Len Brown <lenb@kernel.org> wrote:
> applied
>
> thanks,
> Len Brown, Intel Open Source Technology Center
>
>

Darren just reported:
> ... er, oops. I'd only forgotten to apply the patch to -rc4...
>
> I've re-tested and I get two results, depending on which card (and th=
erefore
> driver) is in use. rt2860sta is fine with the patch as is, but iwl394=
5 isn't
> (eeepc_rfkill_set() needs to call eeepc_rfkill_hotplug(true) =96 whic=
h means
> that we're back to causing the rt2860sta panic :-|

Please revert this patch, Darren is currently trying to fix the
rt2860sta instead
Sorry for that :/

--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
