From: Len Brown <lenb@kernel.org>
Subject: RE: [PATCH] Fix possible null ptr dereference
Date: Fri, 17 Oct 2008 16:55:21 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810171653510.3006@localhost.localdomain>
References: <200810171449.m9HEnoHM018514@los-vmm.sc.intel.com>
 <4911F71203A09E4D9981D27F9D830858032E0245@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:54012 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756513AbYJQUzj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Oct 2008 16:55:39 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K8W00GOFI4DRERC@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 17 Oct 2008 15:55:26 -0500 (CDT)
In-reply-to: <4911F71203A09E4D9981D27F9D830858032E0245@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Dugger, Donald D" <donald.d.dugger@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bjorn.helgaas@hp.com" <bjorn.helgaas@hp.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "astarikovskiy@suse.de" <astarikovskiy@suse.de>, "Lin, Ming M" <ming.m.lin@intel.com>


> In general, the internal ACPICA functions do not perform nearly as much parameter validation as the external functions. The Host OS should not be calling any of the ACPICA internal functions for this and a few other good reasons -- such as the fact that internal functions can disappear, be renamed, or have the parameters changed without warning at any time.
> 
> It would probably be a good idea to audit Linux for the use of internal ACPICA functions and fix these bugs.

I think the way to do this is to clean up the headers
so that code outside of ACPICA doesn't even see
the declarations of the internal ACPICA functions.

Right now everything includes everything, so the headers can't help us.

-Len
