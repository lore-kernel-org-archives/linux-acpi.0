From: Frans Pop <elendil@planet.nl>
Subject: Re: 2.6.23-rc6: S4 and S5 no longer listed as supported on Toshiba Satellite A40
Date: Thu, 20 Sep 2007 14:37:55 +0200
Message-ID: <200709201437.56431.elendil@planet.nl>
References: <200709192014.08443.elendil@planet.nl> <20070920105312.GC12157@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml18.kpnxchange.com ([213.75.38.118]:41627 "EHLO
	hpsmtp-eml18.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753288AbXITMh6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Sep 2007 08:37:58 -0400
In-Reply-To: <20070920105312.GC12157@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 20 September 2007, you wrote:
> > When compared with 2.6.22-4, dmesg no longer lists S4 and S5 as
> > supported for my Toshiba Satellite A40 laptop (Mobile Intel Pentium 4,
> > 2.8GHz).
> >
> > -Linux version 2.6.22-2-686 (Debian 2.6.22-4) (waldi@debian.org) ...
> > +Linux version 2.6.23-rc6 (root@faramir) ...
> >  [...]
> > -ACPI: (supports S0 S3 S4 S5)
> > +ACPI: (supports S0 S3)
>
> Unexpected, and potentially pretty serious. Something went wrong with
> ACPI. Can you try to narrow down when it started happening?

rc1 still had all 4 levels. I'll run a bisect between rc1 and rc6.
