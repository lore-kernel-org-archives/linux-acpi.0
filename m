From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/5] Bluetooth: hci_bcm: Add missing acpi_dev_free_resource_list()
Date: Thu, 1 Oct 2015 10:05:06 +0200
Message-ID: <B5ED0060-B534-493D-B6CD-16E44D255B2C@holtmann.org>
References: <1443619605-19320-1-git-send-email-jarkko.nikula@linux.intel.com> <FBA45A9C-2E3D-4D13-BEDE-957647DC173F@holtmann.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:58911 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909AbbJAIFS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Oct 2015 04:05:18 -0400
In-Reply-To: <FBA45A9C-2E3D-4D13-BEDE-957647DC173F@holtmann.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-acpi@vger.kernel.org, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Frederic Danis <frederic.danis@linux.intel.com>

Hi Jarkko,

>> Caller of acpi_dev_get_resources() should free the constructed resource
>> list by calling the acpi_dev_free_resource_list() in order to avoid memory
>> leak.
>> 
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> ---
>> Call to acpi_dev_get_resources() was introduced by the commit ae056908862b
>> ("Bluetooth: hci_bcm: Retrieve UART speed from ACPI") so fix should go to
>> v4.3-rc.
> 
> if this should go into 4.3 then you need to send it against bluetooth tree actually and not bluetooth-next. And you might want to include patch 2/5 in there as well. Sending them as combined set with bluetooth-next patches is not really helping.
> 
> In case this is not an urgent fix that has to make it into 4.3, then I am just applying all 5 to bluetooth-next tree. Your choice.

I changed my mind here and applied all 5 patches to bluetooth-next tree.

Regards

Marcel

