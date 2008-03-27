From: "Alok Kataria" <akataria@vmware.com>
Subject: cpu eject bug
Date: Thu, 27 Mar 2008 11:02:28 -0700
Message-ID: <D8D2AEA3575B364DAC5F27D00A5E0D1701DBDB33@PA-EXCH03.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([65.113.40.141]:55195 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754096AbYC0SC3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Mar 2008 14:02:29 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org

Hi Zhang, Len,

This is with reference to the deadlock that we see when hot-ejecting a cpu.

Please refer this link for reference.
http://bugzilla.kernel.org/show_bug.cgi?id=9772

Zhang had then provided a patchset which fixed this issue. 
The battery-hotplug patches and the 3 patches from the above link.

I hand weaved all these patches to fit on top of the latest X86 git tree and
this approach still works well.

In that discussion Zhang had also mentioned that Alex and Thomas are working
on a simpler approach due to which this patchset was dropped. 
I tried searching though the linux-acpi archives to look for discussion on
that approach or patches on that, but didn't get any.

I would be interested in knowing the status of those patches or if there were
any discussions may be I can help you guys with. Also, IMO, if the simpler
approach is going to take some time would it be better to have these patches
upstream (until those are ready) so that atleast the eject feature is not
broken there ?
Please let me know your thoughts. 

Thanks,
Alok
