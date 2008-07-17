From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH]  ACPI:  Ignore _BQC object when registering backlight device
Date: Thu, 17 Jul 2008 14:09:31 +0100
Message-ID: <20080717130931.GA27135@srcf.ucam.org>
References: <1216262765.7169.36.camel@localhost.localdomain> <487F3EC6.8070406@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34442 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755843AbYGQNJg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 09:09:36 -0400
Content-Disposition: inline
In-Reply-To: <487F3EC6.8070406@firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Thu, Jul 17, 2008 at 02:44:54PM +0200, Andi Kleen wrote:

> Hmm, but the original patch was reverted. How is this patch better
> than the patch that was reverted by Linus?

The initial patch would have resulted in the screen brightness being set 
to minimum (which may be off on some hardware). The new one sets it to 
maximum brightness if it's not possible to determine the current 
brightness.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
