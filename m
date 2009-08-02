From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 0/8] eeepc-laptop fixes
Date: Sun, 2 Aug 2009 19:18:26 +0200
Message-ID: <71cd59b00908021018x3b4c0af2jde2ccf0218befa2f@mail.gmail.com>
References: <4A75B6C6.3020805@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:50311 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbZHBRS2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Aug 2009 13:18:28 -0400
Received: by fxm17 with SMTP id 17so2268174fxm.37
        for <linux-acpi@vger.kernel.org>; Sun, 02 Aug 2009 10:18:27 -0700 (PDT)
In-Reply-To: <4A75B6C6.3020805@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Sun, Aug 2, 2009 at 5:54 PM, Alan Jenkins<alan-jenkins@tuffmail.co.u=
k> wrote:
> I promised a specific race fix, which is in the second patch. =A0Whil=
e
> I was there, I found some other things I could fix as well.
>
> Regards
> Alan
>
> eeepc-laptop: use a mutex to serialize pci hotplug (resume vs. notify=
)
> eeepc-laptop: fix pci hotplug race on load and unload
> eeepc-laptop: fix ordering of init and exit functions
> eeepc-laptop: make input device a child of the platform device
> eeepc-laptop: remove redundant rfkill_set_sw_state in resume handler
> eeepc-laptop: check the 3G rfkill state on resume
> eeepc-laptop: correct the description of the hibernation abort bug
> eeepc-laptop: switch to dev_pm_ops
>

Thanks,
Applied in acpi4asus eeepc tree:
http://git.iksaif.net/?p=3Dacpi4asus.git;a=3Dshortlog;h=3Drefs/heads/ee=
epc-laptop
With two other patch on top of yours (wimax and __init).
I think I'll send them for 2.6.32 because there is a lot of change.

--=20
Corentin Chary
http://xf.iksaif.net - http://uffs.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
