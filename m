From: Len Brown <lenb@kernel.org>
Subject: Re: (STA.functional && !STA.present)
Date: Sat, 18 Aug 2007 17:10:12 -0400
Message-ID: <200708181710.12550.lenb@kernel.org>
References: <200703090049.19356.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56665 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723AbXHUDqH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Aug 2007 23:46:07 -0400
In-Reply-To: <200703090049.19356.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Shaohua Li <shaohua.li@intel.com>, castet.matthieu@free.fr, linux-acpi@vger.kernel.org

On Friday 09 March 2007 00:49, Len Brown wrote:
> Matthieu,
> what good things happen if instead of using bjorn's current
> tweak to simply set STA.present we use your patch here
> http://bugzilla.kernel.org/show_bug.cgi?id=3358
> which doesn't re-write the bits?
> 
> Bjorn, will the case that provoked your change still work?
> 
> it is interesting now to google for:
> "functional but not present; setting present"
> it comes up on more than Tiger systems...

Shall we discard the patch in this bug report?
Shall we keep the current code and discard the warning?

-Len
