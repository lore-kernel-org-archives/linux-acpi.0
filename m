From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 3/4] ACPI: thinkpad-acpi: disable backlight handler if ACPI generic could do it
Date: Tue, 9 Oct 2007 14:49:59 +0100
Message-ID: <20071009134959.GB5071@srcf.ucam.org>
References: <1191910875.9847.79.camel@queen.suse.de> <20071009075914.GA790@srcf.ucam.org> <1191918351.9847.132.camel@queen.suse.de> <20071009083336.GA1099@srcf.ucam.org> <1191923208.9847.169.camel@queen.suse.de> <20071009100418.GA2472@srcf.ucam.org> <20071009111445.GB24946@khazad-dum.debian.net> <1191936552.9847.257.camel@queen.suse.de> <20071009133441.GA4689@srcf.ucam.org> <1191937626.9847.266.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:57057 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbXJINuT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Oct 2007 09:50:19 -0400
Content-Disposition: inline
In-Reply-To: <1191937626.9847.266.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tue, Oct 09, 2007 at 03:47:06PM +0200, Thomas Renninger wrote:

> Yep, I just realized that :(
> Maybe all required funcs (_BCM,_BCL,...) should get checked, but must
> not be invoked or I am pretty sure brightness switch through buttons
> won't work because the notify handler isn't used.

I'm not sure I understand. The video driver works fine on Thinkpads, 
including for backlight control on recent ones.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
