From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI: support customizing ACPI control methods at runtime
Date: Wed, 2 Dec 2009 11:34:58 +0100
Message-ID: <200912021134.58846.trenn@suse.de>
References: <1259731860.2029.1221.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:49247 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbZLBKex (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Dec 2009 05:34:53 -0500
In-Reply-To: <1259731860.2029.1221.camel@rzhang1-desktop>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wednesday 02 December 2009 06:31:00 Zhang Rui wrote:
> 
> Introduce a new debugfs I/F (/sys/kernel/debug/acpi/custom_method) for ACPI,
> which can be used to customize the ACPI control methods at runtime.
Still no kernel tainting on a successful override?
On purpose or unintended?

    Thomas
