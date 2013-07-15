From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Mon, 15 Jul 2013 13:29:47 +0200
Message-ID: <5742401.D3Ye1zZPh5@linux-5eaq.site>
References: <1373544870-15135-1-git-send-email-oliver@neukum.org> <6802146.fKe43BS873@skinner.arch.suse.de> <1373618715.7539.106.camel@linux-s257.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34264 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755636Ab3GOL2K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Jul 2013 07:28:10 -0400
In-Reply-To: <1373618715.7539.106.camel@linux-s257.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: Thomas Renninger <trenn@suse.de>, lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org

On Friday 12 July 2013 16:45:15 joeyli wrote:

> Per information from OEM, Windows 8 didn't really block S4 resume when
> hardware_signature not match, I think as Oliver's patch.

Is that confidential information?
 
If it is indeed true, introducing a blacklist makes no sense. And I
see no alternative to my patch. Should I resubmit with an improved
comment?

	Regards
		Oliver

