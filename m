From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] ACPI: Store NVS state even when entering suspend
	to RAM
Date: Sun, 30 May 2010 15:51:43 +0100
Message-ID: <20100530145142.GA32078@srcf.ucam.org>
References: <1275078735-1866-1-git-send-email-mjg@redhat.com> <1275078735-1866-2-git-send-email-mjg@redhat.com> <1275230404.14907.11.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45017 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522Ab0E3Ovv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 30 May 2010 10:51:51 -0400
Content-Disposition: inline
In-Reply-To: <1275230404.14907.11.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Sun, May 30, 2010 at 05:40:04PM +0300, Maxim Levitsky wrote:

> Just one note, I am sure somebody will ask for s3_no_nvs option, just
> like s4_no_nvs.

I'd be surprised. Better to add the option when we think it's needed.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
