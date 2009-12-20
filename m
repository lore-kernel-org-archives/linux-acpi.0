From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH 1/2] x86 platform drivers, wmi: Remove needless dmi
	MODULE_ALIAS
Date: Sun, 20 Dec 2009 21:15:00 +0100
Message-ID: <38c9179b0912201215k65ac9ed8t45468a28a534e063@mail.gmail.com>
References: <1261146563-2228-1-git-send-email-trenn@suse.de>
	<20091218184458.464be49c@destiny.ordissimo> <20091218175432.GA29522@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:45523 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbZLTUPY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Dec 2009 15:15:24 -0500
Received: by fxm21 with SMTP id 21so4196086fxm.21
        for <linux-acpi@vger.kernel.org>; Sun, 20 Dec 2009 12:15:22 -0800 (PST)
Received: by fxm21 with SMTP id 21so4196073fxm.21
        for <linux-acpi@vger.kernel.org>; Sun, 20 Dec 2009 12:15:20 -0800 (PST)
In-Reply-To: <20091218175432.GA29522@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, lenb@kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org

On Fri, Dec 18, 2009 at 18:54, Matthew Garrett <mjg59@srcf.ucam.org> wr=
ote:
> On Fri, Dec 18, 2009 at 06:44:58PM +0100, Anisse Astier wrote:
>
>> For this to work properly you need to have wmi built in your kernel,=
 or have
>> your distribution load the wmi module. Maybe there should be some ki=
nd of
>> auto-loading for the wmi subsystem (acpi-based?).
>
> [mjg59@2530p ~]$ modinfo wmi | grep alias
> alias: =A0 =A0 =A0 =A0 =A0acpi*:pnp0c14:*
> alias: =A0 =A0 =A0 =A0 =A0acpi*:PNP0C14:*
>
> Should work already.
>

Indeed, it does, my mistake.

I completely forgot about those lines. In fact, the reason I started
hacking on msi-wmi (the previous driver), was because it didn't have a
proper auto-loading, and thus we packaged it out of kernel tree.

It was using dmi auto-loading with those standard wmi strings (pnp0c14)=
=2E

Regards,

--
Anisse
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
