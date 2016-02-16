From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] acpi: remove modular references from non modular code
Date: Tue, 16 Feb 2016 20:29:05 +0100
Message-ID: <1543551.z8D9aYzdaQ@vostro.rjw.lan>
References: <1455514071-26368-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62019 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755589AbcBPT1n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2016 14:27:43 -0500
In-Reply-To: <1455514071-26368-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>, Huang Ying <ying.huang@intel.com>, Josh Triplett <josh@joshtriplett.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

On Monday, February 15, 2016 12:27:48 AM Paul Gortmaker wrote:
> An audit of i386/x86_64 allmodconfig builds found these instances of 
> non-modular ACPI code needlessly using the modular equivalents of 
> their built-in counterparts.
> 
> In fixing that, we get rid of some dead code, make the mandate of
> the remaining code more clear, and leave behind better examples
> for future ACPI code to copy/emulate.
> 
> Two of them are trivial, in that there is no binary output change.
> The other has dead code removal so the binary output will be
> slightly smaller.   We've done a direct mapping of module_init to
> device_initcall in each instance, so there is no initcall
> reordering risks here.  Overall, in all cases, the runtime should
> be completely unchanged.
> 
> Where others have deployed module_param() already, we have to
> leave it, because there is no equivalent builtin_param (not yet)
> and we have to remain compatible with existing bootarg users.

All three applied.

Thanks,
Rafael

