From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/3] X86 drivers: Introduce msi-wmi driver
Date: Mon, 26 Oct 2009 20:10:41 +0000
Message-ID: <20091026201041.GA8736@srcf.ucam.org>
References: <1256575458-19269-1-git-send-email-trenn@suse.de> <1256575458-19269-2-git-send-email-trenn@suse.de> <20091026170421.GA3515@srcf.ucam.org> <200910262256.28855.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35032 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114AbZJZUKm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Oct 2009 16:10:42 -0400
Content-Disposition: inline
In-Reply-To: <200910262256.28855.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Mon, Oct 26, 2009 at 10:56:28PM +0100, Thomas Renninger wrote:

> The OS has to react on WMI notifications and the brightness change only
> happens when writing to IO via ACPI WSAA (WMI set block) function.
> So I expect the answer to your question is no.

Ok, that's fine.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
