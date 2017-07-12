From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: Fix proper return code for function acpi_gsi_to_irq
Date: Wed, 12 Jul 2017 23:19:13 +0200
Message-ID: <3621133.l64SNjHUuW@aspire.rjw.lan>
References: <20170711164543.23439-1-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44383 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753588AbdGLV04 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Jul 2017 17:26:56 -0400
In-Reply-To: <20170711164543.23439-1-msalter@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, July 11, 2017 12:45:43 PM Mark Salter wrote:
> The function acpi_gsi_to_irq must return 0 on success as the caller
> ghes_probe expects an 0 for success. This change also matches x86
> implementation.
> 
> This patch was submitted around 4.5 timeframe but wasn't pushed because
> it didn't fix a real problem. Now that RAS/GHES patches are in kernel,
> this fixes an error seen on a Mustang (arm64) platform:
> 
>     GHES: Failed to map GSI to IRQ for generic hardware error source: 2
>     GHES: probe of GHES.2 failed with error 81
> 
> Signed-off-by: Tuan Phan <tphan@apm.com>
> Signed-off-by: Loc Ho <lho@apm.com>
> [rebased to v4.12-rc]
> Signed-off-by: Mark Salter <msalter@redhat.com>

Applied with the Lorenzo's ACK.

Thanks,
Rafael

