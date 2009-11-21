From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] acpi/blacklist: enable OSI(Linux) on newer eeepc
Date: Sat, 21 Nov 2009 18:45:03 +0000
Message-ID: <20091121184503.GA15141@srcf.ucam.org>
References: <1258752548-9299-1-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43999 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756741AbZKUSpD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Nov 2009 13:45:03 -0500
Content-Disposition: inline
In-Reply-To: <1258752548-9299-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: Len Brown <lenb@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>

On Fri, Nov 20, 2009 at 10:29:08PM +0100, Corentin Chary wrote:
> Without this patch, eeepc-laptop won't work on newer Eeepc
> because the interface it uses is disabled.

It looks easy to add the WMI interface instead. Please let's not 
perpetuate this kind of thing.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
