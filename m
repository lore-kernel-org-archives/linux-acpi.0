From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: suspend: don't let device _PS3 failure prevent
	suspend
Date: Tue, 12 May 2009 03:01:48 +0100
Message-ID: <20090512020147.GA24896@srcf.ucam.org>
References: <bug-13243-10286@http.bugzilla.kernel.org/> <4A073D92.5060904@gmx.net> <1242009782.3773.139.camel@localhost.localdomain> <200905111721.10166.rjw@sisk.pl> <1242089305.3773.198.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34020 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756652AbZELCCY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 May 2009 22:02:24 -0400
Content-Disposition: inline
In-Reply-To: <1242089305.3773.198.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Witold Szczeponik <Witold.Szczeponik@gmx.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "cedric@belbone.be" <cedric@belbone.be>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, May 12, 2009 at 08:48:25AM +0800, yakui_zhao wrote:

> In such case the power state check will be skipped in course of power
> transition.
> 
> Is this OK?

What's the real-world benefit to throwing an error in this case? What is 
the user or software supposed to do with it?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
