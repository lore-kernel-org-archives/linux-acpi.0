From: Len Brown <lenb@kernel.org>
Subject: RE: [Xen-devel] [PATCH][pvops_dom0][2/4] Introduce the external
 control operation interface for domain0 ACPI parser
Date: Thu, 30 Jul 2009 11:37:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0907301121080.17818@localhost.localdomain>
References: <4D05DB80B95B23498C72C700BD6C2E0B315D64CC@pdsmsx502.ccr.corp.intel.com>
 <E87738D94A6AD54789B5B8D1BAEB06CC5C744C68C2@azsmsx503.amr.corp.intel.com>
 <4D05DB80B95B23498C72C700BD6C2E0B315D65B6@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:33250 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbZG3Php (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jul 2009 11:37:45 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KNL00BB8Q26VYX1@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 30 Jul 2009 10:37:20 -0500 (CDT)
In-reply-to: <4D05DB80B95B23498C72C700BD6C2E0B315D65B6@pdsmsx502.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Ke" <ke.yu@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, "Tian, Kevin" <kevin.tian@intel.com>

> >So the xen hypervizor is responsible for power management decisions,
> >but it doesn't know how to talk to the power management
> >controls in the platform?
> >
> >Why is that a good idea?
> 
> Your question is reasonable. there is also debate here before. People discuss if it is possible to add acpica stuff to xen hypervisor and let xen control the acpi completely. Unfortunately, this will lead dilemma here, i.e. some devices are controlled by dom0 and also need acpi info, e.g. battery, thermal, etc. and pci hotplug in dom0 is another example. Tian Kevin has detail description on this issue in the attached mail.
> 
> On the other hand, the dom0 acpica approach has other benefit, i.e. current linux acpica stuff is pretty mature and has numerous bug fix. Leveraging acpica in linux kernel is more practical.

I agree with Kevin that it would be a mistake to put ACPI both into
both dom0 and the hypervisor.  Frankly, on many levels, ACPI was
designed with Windows in mind, and the further an OS strays from
how Windows does things, the less likely you'll run well on many 
systems.  Obviously, Xen looks nothing like windows, or any other OS,
for it seems to have not one division between implementation and
policy, but multiple...

So I have a fundamental lack of understanding of the logic
behind the partitioning behind the hypervisor and dom0.
Maybe somebody explain it to me in terms that I'll understand?

It reminds me of the partitioning between the Mach microkernel
and the "user-space OS personality, eg Unix".  This looked really neat
in proposals for funding and academic papers, but in reality it turned
out to have little value other than employing programmers to
re-invent the wheel, only to discover that the original round
wheel was better than the square one that they produced...

-Len Brown, Intel Open Source Technology Center



