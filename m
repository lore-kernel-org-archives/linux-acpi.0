From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Hauppauge WinTV-HVR-1120 on Unbuntu 10.04
Date: Tue, 12 Oct 2010 09:00:29 +0800
Message-ID: <1286845229.2111.4078.camel@rui>
References: <139193.61347.qm@web25403.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49813 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753658Ab0JLBDP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Oct 2010 21:03:15 -0400
In-Reply-To: <139193.61347.qm@web25403.mail.ukl.yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fabio tirapelle <ftirapelle@yahoo.it>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2010-10-11 at 17:41 +0800, fabio tirapelle wrote:
> Hi
> 
> After upgrading from Ubuntu 9.10 to Ubuntu 10.04 my Hauppauge WinTV-HVR-1120 
> (sometimes) doesn't work correctly.

Well, this is not an ACPI problem, so I'm not sure why you report it
here.

thanks,
rui

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
> [   59.024541] tda18271c2_rf_tracking_filters_correction: error -5 on line 264
> [   59.420153] tda18271_write_regs: ERROR: idx = 0x5, len = 1, i2c_transfer 
> returned: -5
> [   59.420157] tda18271_toggle_output: error -5 on line 47
> [   91.004019] Clocksource tsc unstable (delta = -295012684 ns)
> [  256.293639] eth0: link up.
> [  256.294750] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [  263.523498] eth0: link down.
> [  265.258740] eth0: link up.
> [  266.460026] eth0: no IPv6 routers present
> [ 9869.636167] tda18271_write_regs: ERROR: idx = 0x5, len = 1, i2c_transfer 
> returned: -5
> [ 9869.636178] tda18271_init: error -5 on line 826
> [ 9872.636220] tda18271_write_regs: ERROR: idx = 0x5, len = 1, i2c_transfer 
> returned: -5
> [ 9872.636232] tda18271_toggle_output: error -5 on line 47
> [ 9998.240167] tda18271_write_regs: ERROR: idx = 0x5, len = 1, i2c_transfer 
> returned: -5
> [ 9998.240178] tda18271_init: error -5 on line 826
> [10001.240179] tda18271_write_regs: ERROR: idx = 0x5, len = 1, i2c_transfer 
> returned: -5
> [10001.240190] tda18271_toggle_output: error -5 on line 47
> 
> 
> 
> Any ideas?
> Thanks
> 
> 
>       
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


