From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: DMI init_set_sci_en_on_resume for multiple
	Lenovo ThinkPads
Date: Tue, 20 Apr 2010 18:24:19 +0100
Message-ID: <20100420172419.GA9719@srcf.ucam.org>
References: <20100420140314.GA5573@canonical.com> <1271782601.25170.105.camel@laptop> <20100420171415.GA9550@srcf.ucam.org> <1271783936.25170.131.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48877 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401Ab0DTRY0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Apr 2010 13:24:26 -0400
Content-Disposition: inline
In-Reply-To: <1271783936.25170.131.camel@laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerone Young <jerone.young@canonical.com>
Cc: Alex Chiang <achiang@canonical.com>, lenb@kernel.org, colin.king@canonical.com, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org

On Tue, Apr 20, 2010 at 12:18:56PM -0500, Jerone Young wrote:

> I could agree, but the only issue is if you go to the thinkpad-acpi or
> ibm-acpi mailing list they would probably disagree as there have been
> updates to the bios in the past required for proper functionality of
> Thinkpads ;-) .. the bios update methods have not changed since then for
> Thinkpads.

If another OS works, and if Linux can be made to work without impairing 
the functionality of working machines, then Linux should be made to 
work. Always. Updating the BIOS should be limited to cases where it's 
impossible to fix things up in the OS.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
