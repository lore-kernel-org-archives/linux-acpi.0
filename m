From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Hauppauge WinTV-HVR-1120 on Unbuntu 10.04
Date: Tue, 12 Oct 2010 14:27:33 -0600
Message-ID: <201010121427.33472.bjorn.helgaas@hp.com>
References: <139193.61347.qm@web25403.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:46057 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247Ab0JLU2m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Oct 2010 16:28:42 -0400
In-Reply-To: <139193.61347.qm@web25403.mail.ukl.yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fabio tirapelle <ftirapelle@yahoo.it>
Cc: linux-acpi@vger.kernel.org

On Monday, October 11, 2010 03:41:17 am fabio tirapelle wrote:
> Hi
> 
> After upgrading from Ubuntu 9.10 to Ubuntu 10.04 my Hauppauge WinTV-HVR-1120 
> (sometimes) doesn't work correctly.
> I get random the following errors:
> 
> [   53.216153] DVB: registering new adapter (saa7133[0])
> [   53.216156] DVB: registering adapter 2 frontend 0 (NXP TDA10048HN DVB-T)...
> [   53.840013] tda10048_firmware_upload: waiting for firmware upload 
> (dvb-fe-tda10048-1.0.fw)...
> [   53.840019] saa7134 0000:01:06.0: firmware: requesting dvb-fe-tda10048-1.0.fw
> [   53.880505] tda10048_firmware_upload: firmware read 24878 bytes.
> [   53.880509] tda10048_firmware_upload: firmware uploading
> [   58.280136] tda10048_firmware_upload: firmware uploaded
> [   59.024537] tda18271_write_regs: ERROR: idx = 0x5, len = 1, i2c_transfer 
> returned: -5

Can you collect the complete dmesg log, please?  If you still have
the 9.10 kernel and can collect a log from that for comparison, that
would be great, too.

I don't see an indication that it's ACPI-related, so maybe
linux-kernel@vger.kernel.org would be a better place.  Please copy
me, too :-)

Bjorn
