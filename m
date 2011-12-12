From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPICA: Put back the call to acpi_os_validate_address
Date: Mon, 12 Dec 2011 14:12:40 +0100
Message-ID: <201112121412.40963.trenn@suse.de>
References: <1322576015.6856.10.camel@hp6530s>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49068 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255Ab1LLNMo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Dec 2011 08:12:44 -0500
In-Reply-To: <1322576015.6856.10.camel@hp6530s>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, kronos.it@gmail.com, "Moore, Robert" <robert.moore@intel.com>

On Tuesday, November 29, 2011 03:13:35 PM Lin Ming wrote:
> The call to acpi_os_validate_address in acpi_ds_get_region_arguments was
> removed by mistake in commit 9ad19ac(ACPICA: Split large dsopcode and
> dsload.c files).
> 
> Put it back.
> 
> Reported-and-bisected-by: Luca Tettamanti <kronos.it@gmail.com>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Just for info:
Adding here:
CC: stable@vger.kernel.org
(mail address changed since kernel.org was down)
should effectively be the same as explicitly submitting the
patch for stable inclusion.

> ---
> 
> Len,
> 
> Could you apply this patch?


> And it should be ported to stable kernel since v2.6.39.
The CC: above and this hint in the changelog would be enough
for Greg and he will pick it out automatically and merge it into
stable kernels (if it applies to stable rules, like this one should),
once the patch is submitted mainline by Len.

   Thomas
