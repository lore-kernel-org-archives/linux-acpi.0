From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Add bluetooth support to toshiba-acpi driver
Date: Mon, 22 Oct 2007 15:54:16 +0100
Message-ID: <20071022145415.GA4912@srcf.ucam.org>
References: <20071021173529.GH1880@earth.li> <471C88E2.3020102@neggie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:34933 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbXJVOya (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Oct 2007 10:54:30 -0400
Content-Disposition: inline
In-Reply-To: <471C88E2.3020102@neggie.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Belmonte <john@neggie.net>
Cc: Jonathan McDowell <noodles@earth.li>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 22, 2007 at 07:26:26AM -0400, John Belmonte wrote:

> The /proc/acpi/toshiba interface should not be expanded-- do not apply
> this patch.  If any patch is applied, it would be to optionally
> implement the generic /dev/toshiba interface so that user space tools
> like toshset can operate.

The correct interface is rfkill, which will require this functionality 
to be in-kernel anyway. I can see the argument against implementing it 
in /proc/acpi/toshiba (further proc interface bloat), but not against 
doing it in-kernel. 

-- 
Matthew Garrett | mjg59@srcf.ucam.org
