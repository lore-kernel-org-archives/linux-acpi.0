From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] sony-laptop: Ignore missing _DIS method on pic device
Date: Tue, 28 Oct 2008 00:59:38 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810280059030.24123@localhost.localdomain>
References: <1224192550-366-1-git-send-email-ajax@redhat.com>
 <20081016224903.GD21963@inferi.kami.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:47946 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbYJ1E7l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Oct 2008 00:59:41 -0400
In-reply-to: <20081016224903.GD21963@inferi.kami.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Adam Jackson <ajax@redhat.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>




> > At least the Vaio VGN-Z540N doesn't have this method, so let's not fail
> > to suspend just because it doesn't exist.

> > Signed-off-by: Adam Jackson <ajax@redhat.com>

> Acked-by: Mattia Dongili <malattia@linux.it>

applied to acpi-test

thanks,
-len
