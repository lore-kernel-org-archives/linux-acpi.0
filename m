From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH v2] If _BIX fails, retry with _BIF.
Date: Wed, 2 Nov 2016 21:26:23 -0200
Message-ID: <20161102232623.GA15671@khazad-dum.debian.net>
References: <1474153002-13904-1-git-send-email-linux@davel.me.uk>
 <1478111847-14653-1-git-send-email-linux@davel.me.uk>
 <1478111847-14653-2-git-send-email-linux@davel.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34939 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756412AbcKBX01 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Nov 2016 19:26:27 -0400
Content-Disposition: inline
In-Reply-To: <1478111847-14653-2-git-send-email-linux@davel.me.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Lambley <linux@davel.me.uk>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Wed, 02 Nov 2016, Dave Lambley wrote:
> -static int acpi_battery_get_info(struct acpi_battery *battery)
> +
> +int extract_battery_info(const int use_bix,
> +			 struct acpi_battery *battery,
> +			 const struct acpi_buffer *buffer)

Shouldn't extract_battery_info() be static as well?

-- 
  Henrique Holschuh
