From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: blacklist win8 OSI for ASUS Zenbok Prime UX31A
Date: Thu, 18 Jul 2013 00:04:41 +0200
Message-ID: <13622439.arY5YlYVCP@vostro.rjw.lan>
References: <1369037793-1559-1-git-send-email-felipe.contreras@gmail.com> <51CBA54C.6040703@intel.com> <CAMP44s2oq5+H=oCXjik4y_yaLm1YKL6nRgbwKNqfVmP4C8pthg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:47691 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756263Ab3GQVyq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Jul 2013 17:54:46 -0400
In-Reply-To: <CAMP44s2oq5+H=oCXjik4y_yaLm1YKL6nRgbwKNqfVmP4C8pthg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Wednesday, July 17, 2013 10:42:35 AM Felipe Contreras wrote:
> On Wed, Jun 26, 2013 at 9:37 PM, Aaron Lu <aaron.lu@intel.com> wrote:
> 
> > Please reference a similar bug where ACPI video driver can't work for
> > some thinkpad win8 laptops:
> > https://bugzilla.kernel.org/show_bug.cgi?id=51231
> >
> > And the proposed way to fix this issue is for all Win8 systems, the
> > ACPI video backlight interface will be removed, leaving only GPU's
> > backlight interface:
> > https://lkml.org/lkml/2013/6/9/161

No, that's obsolete already.

I'll let you know what to try when other people confirm it works for them.

> Thanks. I took a look at the thread and the patches, so essentially
> when those patches are applied, I should expect the same behavior as
> acpi_backlight=vendor, right?

I'm not sure about the Matthew's version.

> If so, that doesn't work correctly in
> this laptop. In this laptop intel backlight works through X, but when
> I set the level to 0 everything is black (it works fine in ACPI), and
> the keyboard keys don't work.
> 
> ACPI works perfectly fine. So I think for this laptop (and possibly
> others) ACPI without win8 mode is the way to go.

While that may be the case, I'd like to avoid more blacklisting than we
already have.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
