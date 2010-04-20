From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: DMI init_set_sci_en_on_resume for multiple
	Lenovo ThinkPads
Date: Tue, 20 Apr 2010 18:14:15 +0100
Message-ID: <20100420171415.GA9550@srcf.ucam.org>
References: <20100420140314.GA5573@canonical.com> <1271782601.25170.105.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37350 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358Ab0DTROW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Apr 2010 13:14:22 -0400
Content-Disposition: inline
In-Reply-To: <1271782601.25170.105.camel@laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerone Young <jerone.young@canonical.com>
Cc: Alex Chiang <achiang@canonical.com>, lenb@kernel.org, colin.king@canonical.com, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org

On Tue, Apr 20, 2010 at 11:56:41AM -0500, Jerone Young wrote:
> Don't think this patch should go in as Lenovo is issuing a BIOS to
> address this issue. On these Thinkpads listed and more. Seems to add
> uneeded quirks in my opinion.
> 
> Though some over all patch may be good for all machines. As Windows
> seems to be setting this bit on it's own.

It's a perfectly safe workaround that's limited to a well-bounded set of 
machines and fixes a pretty serious problem with them. While I'd prefer 
my approach and then a removal of the existing quirk entries, Alex's 
patch makes more sense for stable. The BIOS update is as yet unreleased, 
requires either Windows or an optical drive (which some of these 
machines don't have) and is a far from discoverable solution to the 
issue.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
