From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH 1/2] x86 platform drivers, wmi: Remove needless dmi
 MODULE_ALIAS
Date: Fri, 18 Dec 2009 18:44:58 +0100
Message-ID: <20091218184458.464be49c@destiny.ordissimo>
References: <1261146563-2228-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:39125 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932354AbZLRRs6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2009 12:48:58 -0500
Received: by ewy19 with SMTP id 19so1739999ewy.21
        for <linux-acpi@vger.kernel.org>; Fri, 18 Dec 2009 09:48:57 -0800 (PST)
In-Reply-To: <1261146563-2228-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, Thomas Renninger <trenn@suse.de>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

On Fri, 18 Dec 2009 15:29:22 +0100, Thomas Renninger <trenn@suse.de> wrote :

> wmi autoloading came in, so the dmi matching for autoloading
> is not needed anymore.
> 

For this to work properly you need to have wmi built in your kernel, or have
your distribution load the wmi module. Maybe there should be some kind of
auto-loading for the wmi subsystem (acpi-based?).

Anyway, that's out of the scope of this patch, which was the plan all-along.

FWIW, and for msi-wmi :
Acked-by: Anisse Astier <anisse@astier.eu>

Regards,

Anisse
