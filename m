From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RESEND PATCH v3] mailbox: pcc: Support HW-Reduced Communication Subspace type 2
Date: Tue, 13 Sep 2016 00:07:05 +0200
Message-ID: <1758134.zE8G7Zy4qD@vostro.rjw.lan>
References: <1471306445-943-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50300 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1756226AbcILWA7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Sep 2016 18:00:59 -0400
In-Reply-To: <1471306445-943-1-git-send-email-hotran@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jassi Brar <jassisinghbrar@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, alexey.klimov@arm.com, Prakash Prashanth <pprakash@codeaurora.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>

On Monday, August 15, 2016 05:14:05 PM Hoan Tran wrote:
> ACPI 6.1 has a PCC HW-Reduced Communication Subspace type 2 intended for
> use on HW-Reduce ACPI Platform, which requires read-modify-write sequence
> to acknowledge doorbell interrupt. This patch provides the implementation
> for the Communication Subspace Type 2.
> 
> Signed-off-by: Hoan Tran <hotran@apm.com>
> Reviewed-by: Prashanth Prakash <pprakash@codeaurora.org>

Applied.

Thanks,
Rafael

