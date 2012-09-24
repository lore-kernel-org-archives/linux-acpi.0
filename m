From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] ACPI: Override arbitrary ACPI tables via initrd for
 debugging
Date: Mon, 24 Sep 2012 10:21:59 +0100
Message-ID: <20120924102159.346d0735@pyramind.ukuu.org.uk>
References: <1348234085-39220-1-git-send-email-trenn@suse.de>
	<201209230317.04050.trenn@suse.de>
	<505E8F44.9020208@kernel.org>
	<201209240840.29342.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:41389 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab2IXJRX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Sep 2012 05:17:23 -0400
In-Reply-To: <201209240840.29342.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, hpa@zytor.com, initramfs@vger.kernel.org, robert.moore@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, yinghai@kernel.org, eric.piel@tremplin-utc.net, vojcek@tlen.pl

> The issue is/was, that root can inject code at runtime which is then
> executed in kernel environment.

Yes there are lots of other ways to do this too. The constraint we use
for it is CAP_SYS_RAWIO. With that capability you can totally do raw
hardware access and the like so requiring it for runtime ACPI updating
and execution is consistent with the security model.

> Afaik there are "security" provisions or say setups, which do
> hide modprobe/insmod and do not allow root to load any kernel drivers 
> or similar.

To do this you have to revoke CAP_SYS_RAWIO.

Alan
