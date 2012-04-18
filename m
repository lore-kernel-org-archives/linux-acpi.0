From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] x86/acpi: Call acpi_enter_sleep_state via an asmlinkage
 C function from assembler.
Date: Wed, 18 Apr 2012 13:49:03 -0700
Message-ID: <4F8F28BF.6010003@zytor.com>
References: <1334769518-7660-1-git-send-email-konrad.wilk@oracle.com> <1334769518-7660-3-git-send-email-konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:42046 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753318Ab2DRUtX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Apr 2012 16:49:23 -0400
In-Reply-To: <1334769518-7660-3-git-send-email-konrad.wilk@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: ming.m.lin@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, rjw@sisk.pl, "Brown, Len" <len.brown@intel.com>

On 04/18/2012 10:18 AM, Konrad Rzeszutek Wilk wrote:
> 
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> [v2: Remove extra assembler operations, per hpa review]
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Reviewed-by: H. Peter Anvin <hpa@zytor.com>

Len, your tree or mine?

	-hpa

