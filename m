From: Theodore Tso <tytso@mit.edu>
Subject: Re: [ibm-acpi-devel] [GIT PULL] thinkpad-acpi queue for 2.6.23 (v3)
Date: Thu, 19 Jul 2007 09:57:36 -0400
Message-ID: <20070719135736.GG28872@thunk.org>
References: <11848131483573-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from THUNK.ORG ([69.25.196.29]:56542 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938262AbXGSN5x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jul 2007 09:57:53 -0400
Content-Disposition: inline
In-Reply-To: <11848131483573-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Wed, Jul 18, 2007 at 11:45:25PM -0300, Henrique de Moraes Holschuh wrote:
> 
> Len,
> 
> Please pull from:....

Henirque, just as a suggestion, but now that thinkpad-acpi isn't part
of the ACPI subdirectories in the kernel source, I'm wondering whether
it might not be better for you to just submit directly to Linus.
Given that your changes are largely localized to the ACPI subtree, it
might make it easier to get fixes in post -rc2 or so.

Just a thought....

						- Ted
