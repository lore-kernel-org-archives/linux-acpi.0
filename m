From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / APEI: fix error return code in einj_init()
Date: Thu, 13 Jun 2013 00:51:34 +0200
Message-ID: <1564755.IPcJhbuUt7@vostro.rjw.lan>
References: <CAPgLHd-uB=hWRNCgoUhzFzsjQiPj1cuedUk0ttu1g7UXAx=3=Q@mail.gmail.com> <3066984.NhLpaQnhPR@vostro.rjw.lan> <3908561D78D1C84285E8C5FCA982C28F2DA7A526@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:35430 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756916Ab3FLWm2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jun 2013 18:42:28 -0400
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F2DA7A526@ORSMSX106.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Chen Gong <gong.chen@linux.intel.com>, Wei Yongjun <weiyj.lk@gmail.com>, "lenb@kernel.org" <lenb@kernel.org>, "yongjun_wei@trendmicro.com.cn" <yongjun_wei@trendmicro.com.cn>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wednesday, June 12, 2013 01:42:02 PM Luck, Tony wrote:
> > Well, as it happens, all of these patches are in my tree as well. :-)
> 
> Excellent!
> 
> > I actually didn't know that there was a separate path to Linus for APEI
> > material.
> 
> It's one of the many gray areas ... APEI is clearly part of ACPI, but it is also
> all about RAS too.

Yes, it is.

> > Do you want to handle it going forward or do you want me to do that?  Or do
> > you want me to pull it from you?
> 
> I think I'd like to take them into my tree and then have you pull them
> into the ACPI tree.

OK

Going forward I won't pick up any APEI patches from the list unless you tell
me to do that.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
