From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] add CONFIG_PNP=y to x86_64 defconfig
Date: Fri, 16 Feb 2007 00:33:37 +0100
Message-ID: <200702160033.37241.ak@suse.de>
References: <200702151742.15188.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:43154 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731AbXBOXd4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Feb 2007 18:33:56 -0500
In-Reply-To: <200702151742.15188.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Adam Belay <abelay@novell.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>


> Maybe we should select CONFIG_PNP from CONFIG_ACPI?

That would be probably better I think because it will fix existing
user configurations. You'll get the defconfig for free with that too.

-Andi
