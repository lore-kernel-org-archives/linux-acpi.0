From: Dan Carpenter <error27@gmail.com>
Subject: double unlock in bt_rfkill_poll()
Date: Sun, 19 Jul 2009 14:47:30 +0300 (EAT)
Message-ID: <alpine.DEB.2.00.0907171544100.12306@bicker>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:24633 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbZGSMpk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 19 Jul 2009 08:45:40 -0400
Received: by an-out-0708.google.com with SMTP id d40so2728231and.1
        for <linux-acpi@vger.kernel.org>; Sun, 19 Jul 2009 05:45:39 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

My source checker tool (http://repo.or.cz/w/smatch.git) found an issue in 
bt_rfkill_poll().  I don't know the correct way to fix this.

We unlock on line 337 and again on line 342.

drivers/platform/x86/toshiba_acpi.c
   334          hci_result = hci_get_radio_state(&value);
   335          if (hci_result != HCI_SUCCESS) {
   336                  /* Can't do anything useful */
   337                  mutex_unlock(&dev->mutex);
   338          }
   339  
   340          new_rfk_state = value;
   341  
   342          mutex_unlock(&dev->mutex);

regards,
dan carpenter


