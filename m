From: Joern Heissler <linux-acpi@joern.heissler.de>
Subject: bug in acer-wmi.c, wmid3_set_device_status(), initialization of
 params.
Date: Tue, 31 May 2011 15:03:19 +1200
Message-ID: <20110531030316.GE13559@joerntop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kappa.tutnicht.de ([87.230.93.31]:40006 "EHLO kappa.tutnicht.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710Ab1EaDS5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 May 2011 23:18:57 -0400
Received: from 118-92-21-156.dsl.dyn.ihug.co.nz ([118.92.21.156] helo=joerntop)
	by kappa.tutnicht.de with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <linux-acpi@joern.heissler.de>)
	id 1QRFEt-0006Hv-9S
	for linux-acpi@vger.kernel.org; Tue, 31 May 2011 05:03:28 +0200
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I think I have found a bug in acer-wmi.c,
commit 987dfbaa65b2c3568b85e29d2598da08a011ee09:

The function wmid3_set_device_status contains:

    struct wmid3_gds_input_param params = {
        .function_num = 0x1,
        .hotkey_number = 0x01,
        .devices = ACER_WMID3_GDS_WIRELESS &
                ACER_WMID3_GDS_THREEG &
                ACER_WMID3_GDS_WIMAX &
                ACER_WMID3_GDS_BLUETOOTH,
    };

(1<<0) & (1<<6) & (1<<7) & (1<<11) is zero. Meant bitwise or?

And could someone please update the driver to support my laptop?
See https://bugzilla.kernel.org/show_bug.cgi?id=36322 for details :-)

Cheery
Joern Heissler
