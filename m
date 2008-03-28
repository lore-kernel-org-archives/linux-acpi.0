From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: cpu eject bug
Date: Fri, 28 Mar 2008 15:30:51 +0800
Message-ID: <1206689451.3047.65.camel@acpi-hp-zz.sh.intel.com>
References: <D8D2AEA3575B364DAC5F27D00A5E0D1701DBDB33@PA-EXCH03.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11580 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbYC1Hqw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Mar 2008 03:46:52 -0400
In-Reply-To: <D8D2AEA3575B364DAC5F27D00A5E0D1701DBDB33@PA-EXCH03.vmware.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alok Kataria <akataria@vmware.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Alexey Starikovskiy <aystarik@gmail.com>

Hi, Alok,

On Fri, 2008-03-28 at 02:02 +0800, Alok Kataria wrote:
> Hi Zhang, Len,
> 
> This is with reference to the deadlock that we see when hot-ejecting a
> cpu.
> 
> Please refer this link for reference.
> http://bugzilla.kernel.org/show_bug.cgi?id=9772
> 
> Zhang had then provided a patchset which fixed this issue.
> The battery-hotplug patches and the 3 patches from the above link.
> 
> I hand weaved all these patches to fit on top of the latest X86 git
> tree and
> this approach still works well.
Yes, that's true.

> In that discussion Zhang had also mentioned that Alex and Thomas are
> working
> on a simpler approach due to which this patchset was dropped.
> I tried searching though the linux-acpi archives to look for
> discussion on
> that approach or patches on that, but didn't get any.
Patches are not finished yet. :(

> I would be interested in knowing the status of those patches or if
> there were
> any discussions may be I can help you guys with. Also, IMO, if the
> simpler
> approach is going to take some time would it be better to have these
> patches
> upstream (until those are ready) so that atleast the eject feature is
> not
> broken there ?
Not all the first four patches attached in the bugzilla are needed.
I'll try to cook up a simpler version which has no conflicts with the
new approach.

thanks,
rui



