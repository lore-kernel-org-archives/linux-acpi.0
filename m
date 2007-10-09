From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 3/4] ACPI: thinkpad-acpi: disable backlight handler if
	ACPI generic could do it
Date: Tue, 09 Oct 2007 10:25:51 +0200
Message-ID: <1191918351.9847.132.camel@queen.suse.de>
References: <1191849179-24087-1-git-send-email-hmh@hmh.eng.br>
	 <1191849179-24087-4-git-send-email-hmh@hmh.eng.br>
	 <1191910875.9847.79.camel@queen.suse.de>
	 <20071009075914.GA790@srcf.ucam.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:45744 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988AbXJII0A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Oct 2007 04:26:00 -0400
In-Reply-To: <20071009075914.GA790@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tue, 2007-10-09 at 08:59 +0100, Matthew Garrett wrote:
> On Tue, Oct 09, 2007 at 08:21:14AM +0200, Thomas Renninger wrote:
> 
> > IMO a config variable that compiles out brightness control totally makes
> > more sense (and video, is there any functionality in ThinkPad acpi
> > driver that does not get supported by the video driver?).
> 
> No, older Thinkpads don't implement the video extension. It needs to be 
> handled at runtime.

Why?
If you have a recent Lenovo you don't need all this compiled in and do
not set it. Otherwise you add it.

   Thomas


