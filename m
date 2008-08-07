From: "Kleen, Andi" <andi.kleen@intel.com>
Subject: RE: ACPICA patch set, release 20080701 & 20080729
Date: Thu, 7 Aug 2008 22:10:29 +0100
Message-ID: <38E5333AA17D0A4DABBB33D71000D2908037BB@swsmsx411.ger.corp.intel.com>
References: <1217837747.2569.22.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44947 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbYHGVKm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 17:10:42 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1217837747.2569.22.camel@minggr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lin, Ming M" <ming.m.lin@intel.com>, "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>


 

>-----Original Message-----
>From: Lin, Ming M 
>Sent: Monday, August 04, 2008 10:16 AM
>To: Kleen, Andi; Moore, Robert
>Cc: linux-acpi
>Subject: ACPICA patch set, release 20080701 & 20080729
>
>Hi, Andi
>
>ACPICA release 20080701 & 20080729 patch set for linux attached.
>I generated this patch set on top of Linus tree.
>
>To apply,
>
>#git-pull linus tree
>#git-am R07_29_08.mbox
>
>We now have gaps of 2 release, 20080701 & 20080729, between standard
>acpica and linux acpica.
>
>Would you please apply this patch set for 2.6.27-rc2?

Does this one actually apply? The last one didn't.

And it's far too late for feature patches at this point. Can you 
extract only the bug fixes and non intrusive cleanups?

-Andi

