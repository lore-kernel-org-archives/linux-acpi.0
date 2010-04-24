From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Fix mute key on older Thinkpads by OSI blacklisting
	them
Date: Sat, 24 Apr 2010 17:01:14 +0100
Message-ID: <20100424160114.GA13867@srcf.ucam.org>
References: <1272062884.1594.73.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42483 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab0DXQBR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Apr 2010 12:01:17 -0400
Content-Disposition: inline
In-Reply-To: <1272062884.1594.73.camel@laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerone Young <jerone.young@canonical.com>
Cc: linux-acpi@vger.kernel.org

On Fri, Apr 23, 2010 at 05:48:04PM -0500, Jerone Young wrote:
> This patch fixes that mute keys for X & R & W series Thinkpads. For
> these Thinkpads in the BIOS if OS exposes itself as "Linux" it will
> switch the functionality of the mute key to send a mute key press to the
> OS. These machines will not be getting any bios updates in the future.

The correct way to handle this, as noted before, is to figure out what 
Windows does and implement that.
 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
