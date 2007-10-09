From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 3/4] ACPI: thinkpad-acpi: disable backlight handler if
	ACPI generic could do it
Date: Tue, 09 Oct 2007 15:47:06 +0200
Message-ID: <1191937626.9847.266.camel@queen.suse.de>
References: <1191849179-24087-1-git-send-email-hmh@hmh.eng.br>
	 <1191849179-24087-4-git-send-email-hmh@hmh.eng.br>
	 <1191910875.9847.79.camel@queen.suse.de>
	 <20071009075914.GA790@srcf.ucam.org>
	 <1191918351.9847.132.camel@queen.suse.de>
	 <20071009083336.GA1099@srcf.ucam.org>
	 <1191923208.9847.169.camel@queen.suse.de>
	 <20071009100418.GA2472@srcf.ucam.org>
	 <20071009111445.GB24946@khazad-dum.debian.net>
	 <1191936552.9847.257.camel@queen.suse.de>
	 <20071009133441.GA4689@srcf.ucam.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:37378 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219AbXJINrO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Oct 2007 09:47:14 -0400
In-Reply-To: <20071009133441.GA4689@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tue, 2007-10-09 at 14:34 +0100, Matthew Garrett wrote:
> On Tue, Oct 09, 2007 at 03:29:12PM +0200, Thomas Renninger wrote:
> > static const struct acpi_device_id dummy_vid_device_ids[] = {
> > 	{"LNXVIDEO", 0},
> > 	{"", 0},
> > };
> 
> No. This will match if any of the video extension is implemented. We 
> only want it to match if backlight control is implemented. There are 
> plenty of Thinkpads that implement a subset of the video extension but 
> still need backlight control to be handled via the Thinkpad-specific 
> routes.
Yep, I just realized that :(
Maybe all required funcs (_BCM,_BCL,...) should get checked, but must
not be invoked or I am pretty sure brightness switch through buttons
won't work because the notify handler isn't used.

I wonder how we should make the video module not load then in a sane way
on those, udev rules in userspace would be very dirty..., dmiscan for
ThinkPad in scan.c and only set LNXVIDEO if _BCM,_BCL... are there also,
maybe the latter is acceptable?

   Thomas

