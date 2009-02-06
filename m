From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: add debug dump of BIOS _OSI strings
Date: Fri, 6 Feb 2009 10:25:38 -0800
Message-ID: <4911F71203A09E4D9981D27F9D830858142EC26D@orsmsx503.amr.corp.intel.com>
References: <alpine.LFD.2.00.0902031811400.5607@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56595 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753236AbZBFSZj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Feb 2009 13:25:39 -0500
In-Reply-To: <alpine.LFD.2.00.0902031811400.5607@localhost.localdomain>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "devel@lists.acpica.org" <devel@lists.acpica.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Done, for the next release of ACPICA. Available in the git tree now.

I also removed a couple of the uses of DB_INFO that were too verbose.



>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Len Brown
>Sent: Tuesday, February 03, 2009 3:18 PM
>To: devel@lists.acpica.org
>Cc: linux-acpi@vger.kernel.org
>Subject: [PATCH] ACPICA: add debug dump of BIOS _OSI strings
>
>Bob,
>I'd like to make this minor change to the (linuxized) ACPICA code,
>for it can tell us a little about the BIOS w/o having the user
>go to the trouble to dump the tables etc.
>
>If you made this change in the upstream ACPICA code,
>then that would be dandy.
>
>thanks,
>-Len
>

