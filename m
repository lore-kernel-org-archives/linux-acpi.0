From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Please send DMI info if system does not work as expected boot
 with acpi=copy=dsdt
Date: Wed, 16 Jun 2010 13:47:17 +0300
Message-ID: <1276685237.9687.5.camel@maxim-laptop>
References: <4C18A1DE.7040601@internode.on.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:1917 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758789Ab0FPKrX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2010 06:47:23 -0400
Received: by fg-out-1718.google.com with SMTP id l26so1456201fgb.1
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2010 03:47:21 -0700 (PDT)
In-Reply-To: <4C18A1DE.7040601@internode.on.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: paulngen <paulngen@internode.on.net>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59-kernel@srcf.ucam.org>, lenb <lenb@kernel.org>

On Wed, 2010-06-16 at 20:05 +1000, paulngen wrote: 
> Hi,
> 
> I think I may have another satellite model to add to your list of 
> toshiba machines that has dsdt problems when linux is run.

The real question is, why not to make acpi=copy-dsdt default?
Since this system I assume works with the other OS, its quite likely
that it copies the DSDT.
in fact I have seen in ACPI spec that it suggest to copy the ACPI
tables.
(It says that OS is free to reclaim memory used by ACPI tables as soon
as it made copy if these).

The only way to make ACPI robust on linux is unfortunately to reproduce
the behavior of the other os bug to bug.

Best regards,
Maxim Levitsky

