From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: GA-MA69VM-S2 requires pci=nocrs with 2.6.35.4
Date: Tue, 14 Sep 2010 20:48:40 -0600
Message-ID: <20100915024840.GA28781@helgaas.com>
References: <de55082de958760245f23930b79ab42b7c54c838@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <201009131716.18197.bjorn.helgaas@hp.com>
 <f041c95ed553edce2bb319fd31a9dc5402863437@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <201009140817.18988.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qmta11.emeryville.ca.mail.comcast.net ([76.96.27.211]:53725
	"EHLO qmta11.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752770Ab0IOCuH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Sep 2010 22:50:07 -0400
Content-Disposition: inline
In-Reply-To: <201009140817.18988.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Simon Arlott <simon@fire.lp0.eu>, Jordan Crouse <jcrouse@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>

On Tue, Sep 14, 2010 at 08:17:16AM -0600, Bjorn Helgaas wrote:
> On Tuesday, September 14, 2010 05:38:49 am Simon Arlott wrote:
> > On Tue, September 14, 2010 00:16, Bjorn Helgaas wrote:

> > > I can see from the stalled.txt log that we did call sb600_disable_hpet_bar(),
> > > and it *looks* like that should have disabled BAR 1.  But apparently it
> > > didn't.  Would you mind collecting another log with the patch below?
> > 
> > Whenever I next need to reboot, I can try the patch, but that won't be soon...
> 
> OK.  Just let me know if/when you have any more information.  I opened
> this bugzilla for this problem:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=18482

I attached an updated patch to this bugzilla, so please give it
a try when it's convenient for you.

Bjorn
