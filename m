From: Zhao Yakui <yakui.zhao@intel.com>
Subject: a problem about the function of acpi_ec_read_data
Date: Mon, 18 Aug 2008 10:37:11 +0800
Message-ID: <1219027032.3998.62.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30072 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbYHRCWk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Aug 2008 22:22:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: astarikovskiy@suse.de
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Hi, Alexey
    There is a question about the function of acpi_ec_read_data.
 
    When the data is ready for OS, OS will check the OBF flag of EC status and then call the following
function to read the data returned by EC controller.

static inline u8 acpi_ec_read_data(struct acpi_ec *ec)
{
        u8 x = inb(ec->data_addr);
        pr_debug(PREFIX "---> data = 0x%2.2x\n", x);
        return inb(ec->data_addr);
}

    Why is the EC data I/O address accessed twice to get the data returned by EC controller?
    Does there exist some specific reason about it?
 
Thanks for the comments.

Best regards.
   Yakui

