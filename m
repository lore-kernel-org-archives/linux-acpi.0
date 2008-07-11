From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-acpi: don't call sleeping function from invalid
 context
Date: Fri, 11 Jul 2008 09:42:36 -0400
Message-ID: <4877634C.3070307@garzik.org>
References: <1215655837.1617.7.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60950 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754306AbYGKNml (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jul 2008 09:42:41 -0400
In-Reply-To: <1215655837.1617.7.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, hmacht@suse.de, Andi Kleen <andi@firstfloor.org>

Zhang Rui wrote:
> The problem is introduced by commit
> 664d080c41463570b95717b5ad86e79dc1be0877.
> 
> acpi_evaluate_integer is a sleeping function,
> and it should not be called with spin_lock_irqsave.
> https://bugzilla.redhat.com/show_bug.cgi?id=451399
> 
> Sighed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/ata/libata-acpi.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

applied, with slight change


