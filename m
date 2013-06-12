From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / APEI: fix error return code in einj_init()
Date: Wed, 12 Jun 2013 13:13:29 +0200
Message-ID: <3066984.NhLpaQnhPR@vostro.rjw.lan>
References: <CAPgLHd-uB=hWRNCgoUhzFzsjQiPj1cuedUk0ttu1g7UXAx=3=Q@mail.gmail.com> <4984765.hSvoDJCYAH@vostro.rjw.lan> <3908561D78D1C84285E8C5FCA982C28F2DA79B4D@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34852 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103Ab3FLLET (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jun 2013 07:04:19 -0400
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F2DA79B4D@ORSMSX106.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Chen Gong <gong.chen@linux.intel.com>, Wei Yongjun <weiyj.lk@gmail.com>, "lenb@kernel.org" <lenb@kernel.org>, "yongjun_wei@trendmicro.com.cn" <yongjun_wei@trendmicro.com.cn>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tuesday, June 11, 2013 11:04:51 PM Luck, Tony wrote:
> > Queued up for 3.11.
> 
> I'd independently queued this and a couple of other EINJ fixes from Chen Gong
> in my RAS tree and tried to tempt Ingo to pull them for 3.11 (since this was the
> route that we'd used for EINJ stuff in the past).
> 
> If you want them, then please pull what Ingo is ignoring.
> 
> Here's the e-mail with the please pull details:
> 
> http://marc.info/?l=linux-kernel&m=137062147012973&w=2

Well, as it happens, all of these patches are in my tree as well. :-)

I actually didn't know that there was a separate path to Linus for APEI
material.

Do you want to handle it going forward or do you want me to do that?  Or do
you want me to pull it from you?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
