From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 3/4] ACPI: thinkpad-acpi: disable backlight handler if ACPI generic could do it
Date: Tue, 9 Oct 2007 09:33:37 +0100
Message-ID: <20071009083336.GA1099@srcf.ucam.org>
References: <1191849179-24087-1-git-send-email-hmh@hmh.eng.br> <1191849179-24087-4-git-send-email-hmh@hmh.eng.br> <1191910875.9847.79.camel@queen.suse.de> <20071009075914.GA790@srcf.ucam.org> <1191918351.9847.132.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:39930 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbXJIIdz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Oct 2007 04:33:55 -0400
Content-Disposition: inline
In-Reply-To: <1191918351.9847.132.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tue, Oct 09, 2007 at 10:25:51AM +0200, Thomas Renninger wrote:
> On Tue, 2007-10-09 at 08:59 +0100, Matthew Garrett wrote:
> > On Tue, Oct 09, 2007 at 08:21:14AM +0200, Thomas Renninger wrote:
> > 
> > > IMO a config variable that compiles out brightness control totally makes
> > > more sense (and video, is there any functionality in ThinkPad acpi
> > > driver that does not get supported by the video driver?).
> > 
> > No, older Thinkpads don't implement the video extension. It needs to be 
> > handled at runtime.
> 
> Why?
> If you have a recent Lenovo you don't need all this compiled in and do
> not set it. Otherwise you add it.

If you have a recent Lenovo you don't need to worry about the extra few 
hundred bytes of code this is going to take. There's no point in 
microoptimising.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
