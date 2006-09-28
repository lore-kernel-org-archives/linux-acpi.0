From: Andi Kleen <ak@suse.de>
Subject: Re: fadt.boot_flags.MSI_not_supported
Date: 29 Sep 2006 00:45:38 +0200
Message-ID: <p73psdfip9p.fsf@verdi.suse.de>
References: <CFF307C98FEABE47A452B27C06B85BB6019B425D@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42650 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932536AbWI1Wpl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Sep 2006 18:45:41 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6019B425D@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

"Brown, Len" <len.brown@intel.com> writes:

> sifting through ACPI 3.0a I just noticed a bit (3)
> in the FADT boot_flag to indicate the platform
> does not support MSI.

Implementing that is on my todo list. We definitely should.

-Andi
