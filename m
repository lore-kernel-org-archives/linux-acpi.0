From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [BUG] acpica: ltp_acpi test case causes kernel crash at acpi_ns_walk_namespace
Date: Wed, 13 Dec 2017 00:45:50 +0100
Message-ID: <9523980.S2jPabPoO5@aspire.rjw.lan>
References: <1513094360-1414-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49471 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752723AbdLLXqd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Dec 2017 18:46:33 -0500
In-Reply-To: <1513094360-1414-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Cc: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, vadim.lomovtsev@cavium.com

On Tuesday, December 12, 2017 4:59:19 PM CET Vadim Lomovtsev wrote:
> Hi guys,
> 
> While running LTP tests I've faced kernel crash caused by ltp_acpi test case.
> I have ACPI support enabled in kernel but kernel is boot with FDT having ACPI
> disabled. The ltp_acpi test case application is built along with ltp_acpi_cmds
> module to run ACPI tests.
> 
> So my question is - should we update acpica implementation at kernel side by
> adding 'acpi_disabled' variable checking to the 'acpi_get_devices' function (see
> patch next to this email, maybe not a good approach) or this should be fixed at LTP
> side so the ltp_acpi_cmds should be updated in order to check if acpi is enabled
> before running tests ?

There should be a check preventing acpi_get_devices() from being called in the
acpi_disabled case.

acpi_disabled is Linux-specific and the ACPICA code isn't, so the code calling
ACPICA functions should check acpi_disabled when necessary.

Thanks,
Rafael

