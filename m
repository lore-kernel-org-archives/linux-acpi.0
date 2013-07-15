From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Mon, 15 Jul 2013 13:40:09 +0200
Message-ID: <2772497.7moIZd7YLR@vostro.rjw.lan>
References: <1373544870-15135-1-git-send-email-oliver@neukum.org> <1373618715.7539.106.camel@linux-s257.site> <5742401.D3Ye1zZPh5@linux-5eaq.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43358 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755641Ab3GOLaQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Jul 2013 07:30:16 -0400
In-Reply-To: <5742401.D3Ye1zZPh5@linux-5eaq.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: joeyli <jlee@suse.com>, Thomas Renninger <trenn@suse.de>, lenb@kernel.org, linux-acpi@vger.kernel.org

On Monday, July 15, 2013 01:29:47 PM Oliver Neukum wrote:
> On Friday 12 July 2013 16:45:15 joeyli wrote:
> 
> > Per information from OEM, Windows 8 didn't really block S4 resume when
> > hardware_signature not match, I think as Oliver's patch.
> 
> Is that confidential information?
>  
> If it is indeed true, introducing a blacklist makes no sense. And I
> see no alternative to my patch. Should I resubmit with an improved
> comment?

Yes, it would be good to update the changelog with this info.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
