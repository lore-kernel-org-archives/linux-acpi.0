From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH] ACPI: add "auto" to acpi_enforce_resources
Date: Wed, 4 Feb 2009 14:20:15 +0000
Message-ID: <20090204142015.GB3923@srcf.ucam.org>
References: <20090125210520.GA12963@dreamland.darkstar.lan> <200901291130.35434.trenn@suse.de> <68676e00901290716g1aabd6c0p1e5202fbdbc659a4@mail.gmail.com> <alpine.LFD.2.00.0902040042570.9833@localhost.localdomain> <20090204060513.GA28321@srcf.ucam.org> <498953DF.5050306@redhat.com> <20090204131708.GA2739@srcf.ucam.org> <20090204142606.1823661b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59320 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbZBDOUZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2009 09:20:25 -0500
Content-Disposition: inline
In-Reply-To: <20090204142606.1823661b@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, Luca Tettamanti <kronos.it@gmail.com>, Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Feb 04, 2009 at 02:26:06PM +0100, Jean Delvare wrote:
> On Wed, 4 Feb 2009 13:17:09 +0000, Matthew Garrett wrote:
> > Personally, I'd rather that it was "strict" on everything. We might 
> > break some existing setups, but they're already working mostly by luck.
> 
> Are you the new hwmon and i2c subsystems maintainer and I wasn't aware
> of it?

If you've got some programmatic way to tell the difference between safe 
and dangerous reuse of ACPI resources then that would obviously be 
preferable, but I doubt that's practical. auto is a compromise that 
avoids one specific case of breakage, but it does nothing to protect us 
on the majority of systems. Allowing the firmware and the OS to attempt 
to access the same hardware without any locking is an invitation for 
disaster, and in the absence of any way to prevent the firmware from 
doing it...

But. Hans asked for my opinion - the maintainer's is obviously more 
relevant.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
