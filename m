From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 3/4] ACPI: thinkpad-acpi: disable backlight handler if ACPI generic could do it
Date: Tue, 9 Oct 2007 11:04:18 +0100
Message-ID: <20071009100418.GA2472@srcf.ucam.org>
References: <1191849179-24087-1-git-send-email-hmh@hmh.eng.br> <1191849179-24087-4-git-send-email-hmh@hmh.eng.br> <1191910875.9847.79.camel@queen.suse.de> <20071009075914.GA790@srcf.ucam.org> <1191918351.9847.132.camel@queen.suse.de> <20071009083336.GA1099@srcf.ucam.org> <1191923208.9847.169.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:51529 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbXJIKEg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Oct 2007 06:04:36 -0400
Content-Disposition: inline
In-Reply-To: <1191923208.9847.169.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tue, Oct 09, 2007 at 11:46:48AM +0200, Thomas Renninger wrote:

> More important: CONFIG_THINKPAD_ACPI_BACKLIGHT_DESIRED variable is error
> prone and should not get introduced, right?

I agree that I can't see any reason to ever want to use the thinkpad 
backlight functionality if it can be controlled through the standard 
mechanism instead.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
