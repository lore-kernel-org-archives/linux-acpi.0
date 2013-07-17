From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] acpi: blacklist win8 OSI for ASUS Zenbok Prime UX31A
Date: Wed, 17 Jul 2013 10:42:35 -0500
Message-ID: <CAMP44s2oq5+H=oCXjik4y_yaLm1YKL6nRgbwKNqfVmP4C8pthg@mail.gmail.com>
References: <1369037793-1559-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s3M=LtOfPp+AS0dv=eud1rVSzDOjYbkw+cTAQPzLsK2wg@mail.gmail.com>
	<4224252.tpDZo1Wai9@vostro.rjw.lan>
	<51CBA54C.6040703@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33089 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724Ab3GQPmg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jul 2013 11:42:36 -0400
Received: by mail-wg0-f54.google.com with SMTP id n11so1919309wgh.33
        for <linux-acpi@vger.kernel.org>; Wed, 17 Jul 2013 08:42:35 -0700 (PDT)
In-Reply-To: <51CBA54C.6040703@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Wed, Jun 26, 2013 at 9:37 PM, Aaron Lu <aaron.lu@intel.com> wrote:

> Please reference a similar bug where ACPI video driver can't work for
> some thinkpad win8 laptops:
> https://bugzilla.kernel.org/show_bug.cgi?id=51231
>
> And the proposed way to fix this issue is for all Win8 systems, the
> ACPI video backlight interface will be removed, leaving only GPU's
> backlight interface:
> https://lkml.org/lkml/2013/6/9/161

Thanks. I took a look at the thread and the patches, so essentially
when those patches are applied, I should expect the same behavior as
acpi_backlight=vendor, right? If so, that doesn't work correctly in
this laptop. In this laptop intel backlight works through X, but when
I set the level to 0 everything is black (it works fine in ACPI), and
the keyboard keys don't work.

ACPI works perfectly fine. So I think for this laptop (and possibly
others) ACPI without win8 mode is the way to go.

-- 
Felipe Contreras
