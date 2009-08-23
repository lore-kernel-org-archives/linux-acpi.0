From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] thinkpad-acpi: don't ask about brightness_mode for fw.
 1V and 1R
Date: Sun, 23 Aug 2009 09:54:56 -0300
Message-ID: <20090823125456.GB28731@khazad-dum.debian.net>
References: <1250440221-8185-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39150 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933506AbZHWMzG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Aug 2009 08:55:06 -0400
Content-Disposition: inline
In-Reply-To: <1250440221-8185-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Sun, 16 Aug 2009, Henrique de Moraes Holschuh wrote:
> X40 (firmware 1V) and T41 (firmware 1R) have been confirmed to work
> well with the new defaults, so we can stop pestering people to confirm
> that fact.

Len, if this could make it to mainline before the kernel is released, I
would be grateful.

It whitelists a large class of machines (all T4x models, and the X40 and
X41).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
