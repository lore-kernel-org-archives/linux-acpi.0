From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] acpi/blacklist: enable OSI(Linux) on newer eeepc
Date: Mon, 23 Nov 2009 16:29:59 +0000
Message-ID: <20091123162959.GA12637@srcf.ucam.org>
References: <1258752548-9299-1-git-send-email-corentincj@iksaif.net> <20091121184503.GA15141@srcf.ucam.org> <71cd59b00911211322t45be6c92g2a0c78c03d7eb5e9@mail.gmail.com> <20091121232815.GA17749@srcf.ucam.org> <alpine.LFD.2.00.0911231113520.858@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37112 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756103AbZKWQaD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2009 11:30:03 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0911231113520.858@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>

On Mon, Nov 23, 2009 at 11:24:37AM -0500, Len Brown wrote:

> Matthew,
> blacklist.c shows only 3 specific Lenovo models where we DMI enable 
> OSI(Linux).  Is that causing Lenovo to ship additional models,
> as yet un-documented, that depend on OSI(Linux)?

Yes - as far as I can tell, everything from the current Thinkpad line.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
