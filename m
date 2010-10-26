From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI / PM: Blacklist another machine that needs
	acpi_sleep=nonvs
Date: Tue, 26 Oct 2010 14:19:48 +0100
Message-ID: <20101026131948.GA9221@srcf.ucam.org>
References: <201010172101.21576.rjw@sisk.pl> <alpine.LFD.2.00.1010252013270.18670@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55209 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932857Ab0JZNUC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Oct 2010 09:20:02 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010252013270.18670@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Emanuele Bigiarini <pulmro@gmail.com>

On Mon, Oct 25, 2010 at 08:14:42PM -0400, Len Brown wrote:
> Rather than a black list of machines that can not survive saving NVS,
> I wonder how long a white list of machines requiring NVS save would be?

Windows saves the NVS area in my testing. Either there's something that 
indicates the choices of one behaviour over the other, or the machines 
that are broken by NVS saving are actually tripping some other bug.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
