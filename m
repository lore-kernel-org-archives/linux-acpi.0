From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/1] If _BIX fails, retry with _BIF.
Date: Thu, 24 Nov 2016 02:25:05 +0100
Message-ID: <7447331.Mb6AV2zv3K@vostro.rjw.lan>
References: <20161103223818.GA14534@khazad-dum.debian.net> <1478221540-30617-1-git-send-email-linux@davel.me.uk> <1478221540-30617-2-git-send-email-linux@davel.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61295 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934630AbcKXBRT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Nov 2016 20:17:19 -0500
In-Reply-To: <1478221540-30617-2-git-send-email-linux@davel.me.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Lambley <linux@davel.me.uk>
Cc: linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>

On Friday, November 04, 2016 01:05:40 AM Dave Lambley wrote:
> The Lenovo Yoga 300 laptop's firmware advertises that it provides the _BIX
> the method to retrieve battery information. Unfortunately (some versions
> of?) the implementation return with an error.
> 
> [   21.712228] ACPI Exception: AE_AML_PACKAGE_LIMIT, Index (0x000000010) is beyond end of object (length 0xD) (20160422/exoparg2-427)
> [   21.712244] ACPI Error: Method parse/execution failed [\_SB.PCI0.LPCB.H_EC.BAT1._BIX] (Node ffff95f8ff0b20f0), AE_AML_PACKAGE_LIMIT (20160422/psparse-542)
> 
> The _BIF method does succeed and returns convincing data. We detect _BIX
> failing and automatically retry with _BIF.
> 
> Signed-off-by: Dave Lambley <linux@davel.me.uk>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>

Patch applied.

Thanks,
Rafael

