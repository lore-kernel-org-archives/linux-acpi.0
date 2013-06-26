From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: blacklist win8 OSI for ASUS Zenbok Prime UX31A
Date: Wed, 26 Jun 2013 14:42:53 +0200
Message-ID: <4224252.tpDZo1Wai9@vostro.rjw.lan>
References: <1369037793-1559-1-git-send-email-felipe.contreras@gmail.com> <CAMP44s3M=LtOfPp+AS0dv=eud1rVSzDOjYbkw+cTAQPzLsK2wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:51767 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368Ab3FZMd1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Jun 2013 08:33:27 -0400
In-Reply-To: <CAMP44s3M=LtOfPp+AS0dv=eud1rVSzDOjYbkw+cTAQPzLsK2wg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Wednesday, June 26, 2013 05:41:01 AM Felipe Contreras wrote:
> On Mon, May 20, 2013 at 3:16 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > Otherwise the backlight can't be changed, presumably because the DSDT
> > contains stub code when in conjunction with Windows 8.
> >
> > https://wiki.archlinux.org/index.php/ASUS_Zenbook_Prime_UX31A
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> 
> Hello?
> 
> Is there anything wrong with this patch?

We're going to fix this issue in a different way.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
