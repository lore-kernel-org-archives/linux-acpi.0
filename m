From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] x86 platform drivers, wmi: Remove needless dmi
	MODULE_ALIAS
Date: Fri, 18 Dec 2009 17:54:32 +0000
Message-ID: <20091218175432.GA29522@srcf.ucam.org>
References: <1261146563-2228-1-git-send-email-trenn@suse.de> <20091218184458.464be49c@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34015 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932237AbZLRRyv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2009 12:54:51 -0500
Content-Disposition: inline
In-Reply-To: <20091218184458.464be49c@destiny.ordissimo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: Thomas Renninger <trenn@suse.de>, lenb@kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org

On Fri, Dec 18, 2009 at 06:44:58PM +0100, Anisse Astier wrote:

> For this to work properly you need to have wmi built in your kernel, or have
> your distribution load the wmi module. Maybe there should be some kind of
> auto-loading for the wmi subsystem (acpi-based?).

[mjg59@2530p ~]$ modinfo wmi | grep alias
alias:          acpi*:pnp0c14:*
alias:          acpi*:PNP0C14:*

Should work already.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
