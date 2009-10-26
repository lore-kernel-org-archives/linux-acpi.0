From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 1/3] X86 drivers: Introduce msi-wmi driver
Date: Mon, 26 Oct 2009 22:56:28 +0100
Message-ID: <200910262256.28855.trenn@suse.de>
References: <1256575458-19269-1-git-send-email-trenn@suse.de> <1256575458-19269-2-git-send-email-trenn@suse.de> <20091026170421.GA3515@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:45931 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754468AbZJZTyv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Oct 2009 15:54:51 -0400
In-Reply-To: <20091026170421.GA3515@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Monday 26 October 2009 06:04:21 pm Matthew Garrett wrote:
> Only one question - does hitting the brightness keys automatically
> change the backlight on non-ACPI backlight hardware driven by this?

Hmm, not sure what you mean with non-ACPI driven.
I can only talk about this specific model which only provides WMI (thus
also ACPI driven) backlight functionality. No generic ACPI backlight functions 
as it seems only WindowsXP and not Vista is supported.

The OS has to react on WMI notifications and the brightness change only
happens when writing to IO via ACPI WSAA (WMI set block) function.
So I expect the answer to your question is no.

   Thomas

BTW: Does someone know already whether Windows 7 also requires
generic ACPI backlight functions? Does someone have a good pointer to
some published Windows 7 ACPI documentation/requirements?
