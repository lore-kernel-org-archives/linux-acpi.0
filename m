From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/3]: Store SRAT revision
Date: Sun, 15 Jan 2012 13:52:37 -0800
Message-ID: <20120115215237.GA10124@kroah.com>
References: <20120115213005.GT12380@tpkurt2.garloff.de>
 <20120115213407.GU12380@tpkurt2.garloff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59257 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751295Ab2AOVyl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Jan 2012 16:54:41 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1C26F211D7
	for <linux-acpi@vger.kernel.org>; Sun, 15 Jan 2012 16:54:41 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20120115213407.GU12380@tpkurt2.garloff.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kurt Garloff <kurt@garloff.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org, lenb@kernel.org

On Sun, Jan 15, 2012 at 10:34:07PM +0100, Kurt Garloff wrote:
> Hi,
> 
> This patch stores the SRAT table revision for later consumption
> by arch specific __init functions.
> 
> 
> This is patch 1/3.
> -- 
> Kurt Garloff <kurt@garloff.de>  [Koeln/Greven]
> 

> From: Kurt Garloff <kurt@garloff.de>
> Subject: Store SRAT table revision
> References: bnc#503038
> 
> In SRAT v1, we had 8bit proximity domain (PXM) fields; SRAT v2 provides
> 32bits for these. The new fields were reserved before.
> According to the ACPI spec, the OS must disregrard reserved fields.
> In order to know whether or not, we must know what version the SRAT
> table has.
> 
> This patch stores the SRAT table revision for later consumption
> by arch specific __init functions.
> 
> This is patch 1/3.
> 
> Signed-off-by: Kurt Garloff <kurt@garloff.de>
> 
> ---
>  drivers/acpi/numa.c      |    3 +++
>  include/acpi/acpi_numa.h |    1 +
>  2 files changed, 4 insertions(+)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
