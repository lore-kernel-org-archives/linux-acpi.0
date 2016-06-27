From: Tony <tony.makkiel@daqri.com>
Subject: Any acpi_device_id naming conventions to follow?
Date: Mon, 27 Jun 2016 12:36:47 +0100
Message-ID: <57710FCF.3090908@daqri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35552 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbcF0Lgu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jun 2016 07:36:50 -0400
Received: by mail-wm0-f53.google.com with SMTP id v199so96333075wmv.0
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jun 2016 04:36:49 -0700 (PDT)
Received: from [192.168.1.25] ([81.139.40.162])
        by smtp.gmail.com with ESMTPSA id yr4sm4215563wjc.18.2016.06.27.04.36.47
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2016 04:36:48 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,
         Is there a naming convention to follow on ACPI device names 
(acpi_device_id) for device drivers?

For TI led lp3952, I would otherwise name it as "lp3952". But in order 
to follow  ACPI/PNP device ID convention, it has to be 7 or 8 char long. 
So is "TLP3952" a valid name?

Should the name be registered before it can be used? If it has to be 
registered, is there a subset of characters which can be used without 
registration?

 From a little bit of googling, I found there is an ACPI ID 'TXNW' for TI,
http://www.uefi.org/ACPI_ID_List?search=texas

So should the device name be "TXNW3952"?

Many Thanks,
Tony
