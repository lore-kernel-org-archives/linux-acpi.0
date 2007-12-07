From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: + restore-missing-sysfs-max_cstate-attr.patch added to -mm tree
Date: Fri, 7 Dec 2007 13:38:00 -0800
Message-ID: <924EFEDD5F540B4284297C4DC59F3DEE38C313@orsmsx423.amr.corp.intel.com>
References: <20071130142058.816d1693.akpm@linux-foundation.org> <924EFEDD5F540B4284297C4DC59F3DEE2FAEAF@orsmsx423.amr.corp.intel.com> <20071205111720.GC3864@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36477 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754024AbXLGVhm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Dec 2007 16:37:42 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20071205111720.GC3864@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, lkml@rtr.ca, abelay@novell.com, lenb@kernel.org, mlord@pobox.com, rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

 

>-----Original Message-----
>From: Pavel Machek [mailto:pavel@ucw.cz] 
>Sent: Wednesday, December 05, 2007 3:17 AM
>To: Pallipadi, Venkatesh
>Cc: Andrew Morton; lkml@rtr.ca; abelay@novell.com; 
>lenb@kernel.org; mlord@pobox.com; rjw@sisk.pl; 
>linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org
>Subject: Re: + restore-missing-sysfs-max_cstate-attr.patch 
>added to -mm tree
>
>Hi!
>
>> >It is not known whether Mark is actually writing to this 
>> >thing.  Perhaps
>> >read-only permissions would be a suitable fix?
>> >
>> 
>> Exporting it as read only should be OK. We also need to know if there
>> are hard user space dependency on writing to this from userspace.
>
>Some people are manipulating it from their suspend scripts..
>

That is done by default in kernel now. Deep C-states are disabled
between suspend and resume.

Thanks,
Venki
