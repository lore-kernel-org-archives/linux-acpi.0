From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH v2] If _BIX fails, retry with _BIF.
Date: Thu, 3 Nov 2016 20:38:18 -0200
Message-ID: <20161103223818.GA14534@khazad-dum.debian.net>
References: <1474153002-13904-1-git-send-email-linux@davel.me.uk>
 <1478111847-14653-1-git-send-email-linux@davel.me.uk>
 <1478111847-14653-2-git-send-email-linux@davel.me.uk>
 <20161102232623.GA15671@khazad-dum.debian.net>
 <CAPCK=o8Ydkb530rnzUBUo1+tZxbiK+ocfPrHQmogS3PnUSbSdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53037 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933297AbcKCWi1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Nov 2016 18:38:27 -0400
Content-Disposition: inline
In-Reply-To: <CAPCK=o8Ydkb530rnzUBUo1+tZxbiK+ocfPrHQmogS3PnUSbSdw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Lambley <dave@lambley.me.uk>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Thu, 03 Nov 2016, Dave Lambley wrote:
> On 2 November 2016 at 23:26, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> >
> > On Wed, 02 Nov 2016, Dave Lambley wrote:
> > > -static int acpi_battery_get_info(struct acpi_battery *battery)
> > > +
> > > +int extract_battery_info(const int use_bix,
> > > +                      struct acpi_battery *battery,
> > > +                      const struct acpi_buffer *buffer)
> >
> > Shouldn't extract_battery_info() be static as well?
> 
> I do not believe it needs to be exported. It is a new function only
> used inside battery.c.

Indeed.  Therefore, it really should be made static.

Please fix that on the next version of your patch...

-- 
  Henrique Holschuh
