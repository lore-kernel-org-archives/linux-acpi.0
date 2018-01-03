From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] misc: rtsx: release IRQ during shutdown
Date: Wed, 3 Jan 2018 07:31:06 -0500
Message-ID: <da795216-42b6-49c0-9eaf-7632b6511893@codeaurora.org>
References: <1514925904-24001-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0hYu-1O63omwGNCDUhzt6_TT2vPk7OxSSfJ06h1GWeWxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34454 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeACMbJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jan 2018 07:31:09 -0500
In-Reply-To: <CAJZ5v0hYu-1O63omwGNCDUhzt6_TT2vPk7OxSSfJ06h1GWeWxA@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Timur Tabi <timur@codeaurora.org>, chris2553@googlemail.com, Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 1/3/2018 7:06 AM, Rafael J. Wysocki wrote:
>>   pci_disable_device(pcidev);
>> +       free_irq(pcr->irq, (void *)pcr);
> Do you need to disable MSI here too?
> 

Makes sense. I'll post V2 in a minute.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
