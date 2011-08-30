From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 0/2] Implement overriding of arbitrary ACPI tables via
 initrd
Date: Tue, 30 Aug 2011 14:55:50 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E316E70AA6@ORSMSX101.amr.corp.intel.com>
References: <1314179290-31526-1-git-send-email-trenn@suse.de>
 <201108301341.33452.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7443 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754634Ab1H3Ozw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Aug 2011 10:55:52 -0400
In-Reply-To: <201108301341.33452.trenn@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, "lenb@kernel.org" <lenb@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Lin, Ming M" <ming.m.lin@intel.com>
Cc: "eric.piel@tremplin-utc.net" <eric.piel@tremplin-utc.net>, "jnelson-suse@jamponi.net" <jnelson-suse@jamponi.net>, "devel@acpica.org" <devel@acpica.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>

Lin Ming is looking at this now and will report soon.
Bob


> -----Original Message-----
> From: Thomas Renninger [mailto:trenn@suse.de]
> Sent: Tuesday, August 30, 2011 4:42 AM
> To: lenb@kernel.org; hpa@zytor.com; Lin, Ming M; Moore, Robert
> Cc: eric.piel@tremplin-utc.net; jnelson-suse@jamponi.net;
> devel@acpica.org; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; x86@kernel.org
> Subject: Re: [PATCH 0/2] Implement overriding of arbitrary ACPI tables
> via initrd
> 
> Hi Len, Hi Robert, hi Lin,
> 
> what's your opinion about these patches?
> I just sent a tiny bug fix which slipped in when I did
> last minute cleanups.
> 
> Is the additional acpi_os_phys_table_override() function which
> would be needed in ACPICA sources acceptable?
> 
> I'd appreciate if the acpica adoption can be made by
> acpica people, but if you give green light, I can also
> re-write the first patch against acpica sources.
> 
> As this needs syncing with acpica it would be great if the first
> steps can be made, so that this can show up in 3.2 release.
> 
> Thanks,
> 
>    Thomas
> 
> On Wednesday, August 24, 2011 11:48:08 AM Thomas Renninger wrote:
> > This patch series got some basic testing already (see patch 2
> changelog) and
> > is based on latest 3.1-rc2 Linus kernel.
> >
> > The patches are separated into ACPICA parts (patch 1) and kernel
> parts (patch 2).
> >
> > They are ready for integeration (if now objections should show up in
> a review
> > discussion) and it would be great if they can be added in Len's
> latest acpi-test
> > tree for broader testing.
> >
> > Thanks,
> >
> >    Thomas
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

