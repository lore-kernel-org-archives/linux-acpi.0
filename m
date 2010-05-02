From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Input Brightness events on EeePc 1201HA
Date: Sun, 2 May 2010 15:25:50 +0100
Message-ID: <20100502142550.GA16837@srcf.ucam.org>
References: <w2t71cd59b01004280220rbbff08cek497c98985e996748@mail.gmail.com> <1272446724.12834.24.camel@plop> <g2o71cd59b01004280508m99790717x9d9f10c71fd1145b@mail.gmail.com> <1272457434.12834.29.camel@plop> <q2z71cd59b01004280528scc775622lf85055f797cec79e@mail.gmail.com> <1272461780.12834.93.camel@plop> <1272462009.12834.95.camel@plop> <t2g71cd59b01004292311sd797e259g6340d701bc52a93e@mail.gmail.com> <1272643738.26706.63.camel@plop> <q2k71cd59b01005020531n8f827e63qd03588fd980c3c9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46494 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756336Ab0EBO0E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 May 2010 10:26:04 -0400
Content-Disposition: inline
In-Reply-To: <q2k71cd59b01005020531n8f827e63qd03588fd980c3c9a@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Pascal Terjan <pterjan@mandriva.com>, "Zhang, Rui" <rui.zhang@intel.com>, acpi4asus-user@lists.sourceforge.net, linux acpi <linux-acpi@vger.kernel.org>

On Sun, May 02, 2010 at 02:31:19PM +0200, Corentin Chary wrote:
> > It works in Linux, without using video (which can not manage this
> > machine), until psb driver is loaded and creates a backlight device
> > using PWM!

The PSB driver needs to implement the Intel video device opregion spec. 
Unfortunately it's developed in a closed environment and we have no 
ability to contribute fixes to it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
