From: Robert Richter <robert.richter@cavium.com>
Subject: Re: [PATCH 1/1] PCI: Add MCFG quirk for 2nd node of Cavium ThunderX
 pass2.x host controller
Date: Fri, 21 Apr 2017 13:34:54 +0200
Message-ID: <20170421113454.GR16981@rric.localdomain>
References: <1490789773-21506-1-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-dm3nam03on0062.outbound.protection.outlook.com ([104.47.41.62]:43936
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1038783AbdDULfK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Apr 2017 07:35:10 -0400
Content-Disposition: inline
In-Reply-To: <1490789773-21506-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>
Cc: helgaas@kernel.org, Lorenzo.Pieralisi@arm.com, ddaney@caviumnetworks.com, Vadim.Lomovtsev@caviumnetworks.com, rafael@kernel.org, Sunil.Goutham@cavium.com, geethasowjanya.akula@gmail.com, linu.cherian@cavium.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org

On 29.03.17 14:16:13, Tomasz Nowicki wrote:
> Currently SoCs pass2.x do not emulate EA headers for ACPI boot method at all.
> However, for pass2.x some devices (like EDAC) advertise incorrect base addresses
> in their BARs which results in driver probe failure during resource request.
> Since all problematic blocks are on 2nd NUMA node under domain 10 add necessary
> quirk entry to obtain BAR addresses correction using EA header emulation.
> 
> Fixes: 44f22bd91e88 ("PCI: Add MCFG quirks for Cavium ThunderX pass2.x host controller")
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> CC: stable@vger.kernel.org	# v4.10+

Acked-by: Robert Richter <rrichter@cavium.com>

Bjorn, please apply.

Thanks,

-Robert
