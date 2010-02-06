From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] dell-laptop: Use buffer with 32-bit physical address
Date: Sat, 6 Feb 2010 13:38:09 -0200
Message-ID: <20100206153809.GA31008@khazad-dum.debian.net>
References: <1265324214-7812-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34634 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753330Ab0BFPiN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Feb 2010 10:38:13 -0500
Content-Disposition: inline
In-Reply-To: <1265324214-7812-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, stuart_hayes@dell.com

On Thu, 04 Feb 2010, Matthew Garrett wrote:
> Currently the dell-laptop driver does not guarantee this, and when the
> buffer address is higher than 4GB, the address is truncated to 32 bits
> and the SMI handler writes to the wrong memory address.

Hmm, this is a very dangerous bug, with the potential to cause
page-cache/file system corruption and data loss, isn't it?

What kernel versions does it affect?  How easy is it to trigger?  Shouldn't
it go to -stable post-haste as soon as it is merged in mainline?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
