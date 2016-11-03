From: Dave Lambley <dave@lambley.me.uk>
Subject: Re: [PATCH v2] If _BIX fails, retry with _BIF.
Date: Thu, 3 Nov 2016 08:33:55 +0000
Message-ID: <CAPCK=o8Ydkb530rnzUBUo1+tZxbiK+ocfPrHQmogS3PnUSbSdw@mail.gmail.com>
References: <1474153002-13904-1-git-send-email-linux@davel.me.uk>
 <1478111847-14653-1-git-send-email-linux@davel.me.uk> <1478111847-14653-2-git-send-email-linux@davel.me.uk>
 <20161102232623.GA15671@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33354 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752858AbcKCId5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Nov 2016 04:33:57 -0400
Received: by mail-oi0-f67.google.com with SMTP id x4so5412493oix.0
        for <linux-acpi@vger.kernel.org>; Thu, 03 Nov 2016 01:33:56 -0700 (PDT)
In-Reply-To: <20161102232623.GA15671@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On 2 November 2016 at 23:26, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
>
> On Wed, 02 Nov 2016, Dave Lambley wrote:
> > -static int acpi_battery_get_info(struct acpi_battery *battery)
> > +
> > +int extract_battery_info(const int use_bix,
> > +                      struct acpi_battery *battery,
> > +                      const struct acpi_buffer *buffer)
>
> Shouldn't extract_battery_info() be static as well?

I do not believe it needs to be exported. It is a new function only
used inside battery.c.

Best regards,
Dave
