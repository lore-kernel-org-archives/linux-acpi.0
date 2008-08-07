From: "Kleen, Andi" <andi.kleen@intel.com>
Subject: RE: ACPICA patch set, release 20080701 & 20080729
Date: Thu, 7 Aug 2008 22:42:59 +0100
Message-ID: <38E5333AA17D0A4DABBB33D71000D2908037C2@swsmsx411.ger.corp.intel.com>
References: <1217837747.2569.22.camel@minggr> <38E5333AA17D0A4DABBB33D71000D2908037BB@swsmsx411.ger.corp.intel.com> <9D39833986E69849A2A8E74C1078B6B3CE13D2@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25120 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753488AbYHGVmz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 17:42:55 -0400
Content-class: urn:content-classes:message
In-Reply-To: <9D39833986E69849A2A8E74C1078B6B3CE13D2@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>




>-----Original Message-----
>From: Moore, Robert 
>Sent: Thursday, August 07, 2008 11:31 PM
>To: Kleen, Andi; Lin, Ming M
>Cc: 'linux-acpi'; Brown, Len
>Subject: RE: ACPICA patch set, release 20080701 & 20080729
>
>>And it's far too late for feature patches at this point. Can you
>>extract only the bug fixes and non intrusive cleanups?
>
>What does this mean exactly?

The Linux kernel has this concept of merging windows. After a major
release 
there is a 2 week merging window where all the features go in. The merge
window closes with -rc1. After -rc1 some features can still go in, but
in
general larger merges are frowned upon (as in Linus often yells at the 
submitter) The focus is definitely on bug fixes post -rc1. Also 
there seem to be unfortunately quite a lot of ACPI regressions this
cycle,
so I have to be especially conservative.

A full 2 cycle ACPICA merge would be likely too much
of a merge.  Also we need some testing time for major ACPICA changes 
in -mm/linux-next anyways.

I'm open for relatively clear bug fixes and unlikely to break anything
cleanups though to push in for .27. E.g. the pathname fixes would be 
obvious candidates. Since you know the various patches better than me 
it makes sense for you to preselect.

I can pull full ACPICA into the test tree of course (assuming 
it applies). Will do that tomorrow. But test is beyond .27.

-Andi

