From: "Brown, Len" <len.brown@intel.com>
Subject: RE: automatically duplicate records on bugziila.kernel.org
Date: Sun, 14 May 2006 23:36:52 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670F4D8@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50965 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751330AbWEODhC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 May 2006 23:37:02 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>, bugme-admin@osdl.org
Cc: linux-acpi@vger.kernel.org


>Hi bugme-admin,
>
>I just found a weird duplicate record 6550 for a new created 
>bug report --bug 6549 after entering 2nd comments for 6549
>It looks like a bug of bugzilla.  


Both 6549 and 6550 were Opened: 2006-05-14 05:50

The 1st comment to 6550 is dated a minute later:
------- Additional Comment #1 From Luming Yu 2006-05-14 05:51 ------- 


so it does not look to me like 6549 was created upon the
comment addition to 6550, both because its bug id is lower,
and it was created a minute before that comment.

This doesn't mean there is not a bug.
I suspect it is in the way the browser is used immediately
after the bug is submitted.

I recommend trying to reproduce the failure by submitting
a bug against the bugzilla category itself:

http://bugzilla.kernel.org/enter_bug.cgi?product=Other&component=Bug%20T
racker
