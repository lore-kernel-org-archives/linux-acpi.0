From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 09/13] ACPI: thinkpad-acpi: handle HKEY thermal and battery alarms
Date: Thu, 15 Jan 2009 19:51:10 +0000
Message-ID: <20090115195110.GA4200@srcf.ucam.org>
References: <1231650070-21722-10-git-send-email-hmh@hmh.eng.br> <alpine.LFD.2.00.0901151342011.4737@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57373 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406AbZAOTvU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jan 2009 14:51:20 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901151342011.4737@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Thu, Jan 15, 2009 at 01:45:19PM -0500, Len Brown wrote:
> While useful to a techie, it is hard to imagine that these will
> become useful to a generic Linux GUI some day that is used by
> regular people.

I think it makes sense to tie them to uevents on the appropriate generic 
devices. Even if most hardware doesn't generate them, the ability to pop 
up a notification telling the user that the firmware thinks their system 
is too hot is useful.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
