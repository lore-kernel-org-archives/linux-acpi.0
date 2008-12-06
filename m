From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: samsung x360, acpi support
Date: Sat, 6 Dec 2008 17:32:34 +0000
Message-ID: <20081206173234.GA8400@srcf.ucam.org>
References: <200812041915.39971.mheinz@cs.uni-frankfurt.de> <200812061733.37471.mheinz@cs.uni-frankfurt.de> <20081206164247.GD7623@srcf.ucam.org> <200812061828.29429.mheinz@cs.uni-frankfurt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45095 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbYLFRcg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Dec 2008 12:32:36 -0500
Content-Disposition: inline
In-Reply-To: <200812061828.29429.mheinz@cs.uni-frankfurt.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Heinz <mheinz@cs.uni-frankfurt.de>
Cc: linux-acpi@vger.kernel.org

On Sat, Dec 06, 2008 at 06:28:28PM +0100, Matthias Heinz wrote:

> The brightness key(s) just send a keycode:
> e.g.
> atkbd.c: Unknown key pressed (translated set 2, code 0x83 on isa0060/serio0).
> atkbd.c: Use 'setkeycodes e003 <keycode>' to make it known.

Oh, fail. Ok. Does writing a value into the /sys/class/backlight 
interface result in an interrupt in the i915_gem_interrupts file?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
