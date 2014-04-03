From: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>
Subject: How to i2c pass platform_data under ACPI
Date: Thu, 3 Apr 2014 04:48:53 +0000
Message-ID: <D854C92F57B1B347B57E531E78D05EAD57462F64@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43182 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751215AbaDCEs5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Apr 2014 00:48:57 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>

Hi All,

I am trying to enable a i2c client driver under ACPI. The device is being enumerated behind adapter device and I am getting IRQ resource as well.

The problem I have now is, how do I pass the platform data to driver?

struct i2c_board_info {
        char            type[I2C_NAME_SIZE];
        unsigned short  flags;
        unsigned short  addr;
        void            *platform_data; ===========> how can I initialize this filed.
        struct dev_archdata     *archdata;
        struct device_node *of_node;
        struct acpi_dev_node acpi_node;
        int             irq;
};
 
In non ACPI environment I used to initialize the platform_data under board or platforms files. Under ACPI how do I do that?

Thanks,
Ram
