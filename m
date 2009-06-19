From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 00/15] acpi4asus updates
Date: Fri, 19 Jun 2009 10:28:28 +0200
Message-ID: <71cd59b00906190128h6de62133o9e8380e1992da59c@mail.gmail.com>
References: <1245180536-28009-1-git-send-email-corentincj@iksaif.net>
	 <alpine.LFD.2.00.0906172241040.8921@localhost.localdomain>
	 <alpine.LFD.2.00.0906180157380.8921@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f206.google.com ([209.85.220.206]:55885 "EHLO
	mail-fx0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbZFSI21 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2009 04:28:27 -0400
Received: by fxm2 with SMTP id 2so117516fxm.37
        for <linux-acpi@vger.kernel.org>; Fri, 19 Jun 2009 01:28:28 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0906180157380.8921@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Thu, Jun 18, 2009 at 8:21 AM, Len Brown<lenb@kernel.org> wrote:
>> applied
>
> This series was okay in my 2.6.30-based test tree -- modulo
> a simple conflict with Bjorn's .notify patch. =A0But there are more
> conflicts when merged up w/ Linus in preparation for a push
> due to the rfkill changes that are upstream:-(
>
> I got lost trying to merge that branch on top of Linus's tree --
> git merges do all the branch conflicts at once rather than
> patch-by-patch, so I quickly lost track of which line was
> from which patch.
>
> So I abandoned the 2.6.30-based asus branch in my test tree
> and instead created a new asus branch on top of my release
> tree, which contains Linus' latest, bjorn's .notifiy series;
> and I simply took the (6) patches in the series that applied
> cleanly and skipped the ones that did not.
>
> Corentin,
> If you can refresh the skipped patches below (or simply the whole ser=
ies)
> so it applies on top of my test or release trees, that would be great=
=2E
>
> thanks,
> -Len
>
>
> Subject: [01/15] eeepc-laptop: Register as a pci-hotplug device
>
> skipped
>
> Subject: [02/15] eeepc: fix kconfig selects
>
> skipped
>
> Subject: [03/15] eeepc-laptop.c: use pr_fmt and pr_<level>
>
> skipped
>
> Subject: [04/15] eeepc-laptop: enable camera by default
>
> applied
>
> Subject: [05/15] asus-laptop: platform dev as parent for led and back=
light
>
> applied
>
> Subject: [06/15] acpi4asus: update MAINTAINER and KConfig links
>
> applied
>
> Subject: [07/15] asus_acpi: Deprecate in favor of asus-laptop
>
> applied
>
> Subject: [08/15] asus-laptop: use pr_fmt and pr_<level>
>
> skipped
>
> Subject: [09/15] eeepc-laptop: rfkill refactoring
>
> skipped
>
> Subject: [10/15] eeepc-laptop: right parent device
>
> skipped
>
> Subject: [11/15] eeepc-laptop: sync eeepc-laptop with asus_acpi
>
> applied
>
> Subject: [12/15] eeepc-laptop: makes get_acpi() returns -ENODEV
>
> skipped
>
> Subject: [13/15] eeepc-laptop: get the right value for CMSG
>
> skipped
>
> Subject: [14/15] eeepc-laptop: add rfkill support for the 3G modem in=
 Eee PC
>
> skipped
>
> Subject: [15/15] eeepc-laptop: cpufv updates
>
> applied.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>


Hi,
Working on it, will send fixed patches soon.

--=20
Corentin Chary
http://xf.iksaif.net - http://uffs.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
