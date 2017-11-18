From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 2/2] acpi: apei: call into AER handling regardless of severity
Date: Sat, 18 Nov 2017 15:54:19 +0100
Message-ID: <9355728.o7rQ576JL4@aspire.rjw.lan>
References: <1510758867-15940-1-git-send-email-tbaicar@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57033 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756753AbdKROyg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 18 Nov 2017 09:54:36 -0500
In-Reply-To: <1510758867-15940-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: bp@suse.de, tony.luck@intel.com, will.deacon@arm.com, james.morse@arm.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, November 15, 2017 4:14:27 PM CET Tyler Baicar wrote:
> Currently the GHES code only calls into the AER driver for
> recoverable type errors. This is incorrect because errors of
> other severities do not get logged by the AER driver and do not
> get exposed to user space via the AER trace event. So, call
> into the AER driver for PCIe errors regardless of the severity

Can you please resend the [1/2] too for completeness?

Thanks,
Rafael

