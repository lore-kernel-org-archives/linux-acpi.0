From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Adjust the return value of _REV on x86
Date: Tue, 24 Mar 2015 20:00:05 +0000
Message-ID: <20150324200005.GA17499@srcf.ucam.org>
References: <1426150247-18309-1-git-send-email-matthew.garrett@nebula.com>
 <1426363131-14530-1-git-send-email-jason.ekstrand@intel.com>
 <CAOFGe95CiLcHtzD3Vv-KJoCXfeHCyGa55OBkzHSZMWwdOyLnfg@mail.gmail.com>
 <20150323120331.GA3007@codeblueprint.co.uk>
 <5510FB37.6030808@dell.com>
 <20150324152412.GA4706@codeblueprint.co.uk>
 <55119D4A.5050809@dell.com>
 <20150324180156.GA14658@srcf.ucam.org>
 <5511C0B4.1000304@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40549 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbbCXUAM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2015 16:00:12 -0400
Content-Disposition: inline
In-Reply-To: <5511C0B4.1000304@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>, Jason Ekstrand <jason@jlekstrand.net>, LKML <linux-kernel@vger.kernel.org>, Bard Liao <bardliao@realtek.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Tue, Mar 24, 2015 at 02:53:24PM -0500, Mario Limonciello wrote:
> On 03/24/2015 01:01 PM, Matthew Garrett wrote:
> >Will it? You haven't shipped the firmware that changes this behaviour
> >yet.
> >
> This was posted a few days ago.  BIOS A02, it resolves the broken behavior introduced in A01 and Linux.
> 
> It can be flashed in the BIOS F12 boot menu, no Windows or DOS necessary.
> 
> http://www.dell.com/support/home/us/en/04/Drivers/DriversDetails?driverId=F2PRR&fileId=3442501672&osCode=WB64A&productCode=xps-13-9343-laptop&languageCode=EN&categoryId=BI
> 
> Anything bought from now forward will have that BIOS version (or something newer).

Sigh. Then yeah, backporting it to stable is probably out - which means 
you've made it impossible to fix any other systems that have broken _REV 
behaviour and which would work fine with stable kernels otherwise.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
