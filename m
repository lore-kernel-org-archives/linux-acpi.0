From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH] ACPI: Add reboot mechanism
Date: Tue, 17 Jul 2007 09:46:56 +0800
Message-ID: <1184636816.11983.1.camel@sli10-conroe.sh.intel.com>
References: <20070716180019.GA5112@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32687 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753686AbXGQBvz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Jul 2007 21:51:55 -0400
In-Reply-To: <20070716180019.GA5112@google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Durbin <adurbin@google.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, ak@suse.de, akpm@osdl.org

On Tue, 2007-07-17 at 02:00 +0800, Aaron Durbin wrote:
> 
> Add the ability to reset the machine using the RESET_REG in ACPI's
> FADT table.
We could have another command for 'reboot' kernel command line.

Thanks,
Shaohua
