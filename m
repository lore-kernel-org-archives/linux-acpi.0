From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: DMI init_set_sci_en_on_resume for multiple
	Lenovo ThinkPads
Date: Tue, 20 Apr 2010 15:46:54 +0100
Message-ID: <20100420144654.GA6354@srcf.ucam.org>
References: <20100420140314.GA5573@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59000 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab0DTOrD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Apr 2010 10:47:03 -0400
Content-Disposition: inline
In-Reply-To: <20100420140314.GA5573@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@canonical.com>, lenb@kernel.org, colin.king@canonical.com, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org

On Tue, Apr 20, 2010 at 08:03:14AM -0600, Alex Chiang wrote:

> In any case, an existing DMI table exists for machines where this
> defect is a known problem. Lenovo promise to fix their BIOS, but
> for folks who either won't or can't upgrade their BIOS, allow
> Linux to workaround the issue.

While this is certainly the low impact fix for now, I'd prefer the patch 
I sent as a long-term solution in order to avoid having to add more 
machines to the table in future.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
