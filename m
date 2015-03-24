From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Adjust the return value of _REV on x86
Date: Tue, 24 Mar 2015 18:01:56 +0000
Message-ID: <20150324180156.GA14658@srcf.ucam.org>
References: <1426150247-18309-1-git-send-email-matthew.garrett@nebula.com>
 <1426363131-14530-1-git-send-email-jason.ekstrand@intel.com>
 <CAOFGe95CiLcHtzD3Vv-KJoCXfeHCyGa55OBkzHSZMWwdOyLnfg@mail.gmail.com>
 <20150323120331.GA3007@codeblueprint.co.uk>
 <5510FB37.6030808@dell.com>
 <20150324152412.GA4706@codeblueprint.co.uk>
 <55119D4A.5050809@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39160 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452AbbCXSCF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2015 14:02:05 -0400
Content-Disposition: inline
In-Reply-To: <55119D4A.5050809@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>, Jason Ekstrand <jason@jlekstrand.net>, LKML <linux-kernel@vger.kernel.org>, Bard Liao <bardliao@realtek.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Tue, Mar 24, 2015 at 12:22:18PM -0500, Mario Limonciello wrote:

> At that time rt286 I2S wasn't even in the kernel.  Bard didn't start 
> to land it until later that year 
> (https://github.com/torvalds/linux/commit/07cf7cbadb4d97a78be61119a406de8fe446467e). 
> Was it really that crazy to plan Linux to take HDA mode?

Since we don't expose any way for the platform to detect that it's 
running Linux, yes.

> I would like to respectfully ask that this patch not be added to older 
> stable kernel versions.  It will knowingly cause a regression with 
> hardware in the field.  If this isn't an appropriate criteria for 
> avoiding to backport a patch to stable, what is?

Will it? You haven't shipped the firmware that changes this behaviour 
yet.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
