From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Mon, 11 Feb 2013 17:52:13 +0000
Message-ID: <20130211175213.GA25139@srcf.ucam.org>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35345 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758378Ab3BKRwV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Feb 2013 12:52:21 -0500
Content-Disposition: inline
In-Reply-To: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>

On Mon, Feb 11, 2013 at 10:21:21AM -0600, Seth Forshee wrote:
> The AML implementation for brightness control on several ThinkPads
> contains a workaround to meet a Windows 8 requirement of 101 brightness
> levels [1]. The implementation is flawed, as only 16 of the brighness
> values reported by _BCL affect a change in brightness. _BCM silently
> discards the rest of the values. Disabling Windows 8 compatibility on
> these machines reverts them to the old behavior, making _BCL only report
> the 16 brightness levels which actually work. Add a quirk to do this
> along with a dmi callback to disable Win8 compatibility.

So the problem is that userspace is writing values that don't happen to 
be aligned with the values the hardware reacts to, and so nothing gets 
changed?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
