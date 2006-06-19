From: "Brown, Len" <len.brown@intel.com>
Subject: RE: ACPI control method battery question
Date: Mon, 19 Jun 2006 14:28:32 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6C665D2@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50066 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932321AbWFSS3O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Jun 2006 14:29:14 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matt Mullins <matt.mullins@gdc4s.com>
Cc: linux-acpi@vger.kernel.org

[added linux-acpi@vger.kernel.org, deleted acpi@linux.intel.com from
cc:]

>I'm trying to develop a Linux module to communicate with an 
>ACPI control
>method battery under the 2.4.21 kernel (only need read access to _BST),

/proc/acpi/battery doesn't tell you want you need to know?

>but I'm not allowed to recompile the kernel due to government
>certification.  I've compiled the Intel pm tools and have dumped the
>ACPI table, and the battery is seen correctly.

Is this 2.4.21 kernel running the system in ACPI mode?

>Is there a way to get around using the interpreter, and talk to the
>battery directly through direct reads and writes to the embedded
>controller?  If not, is what I'm looking to accomplish doable without
>modifying the kernel?

Sure, boot with "acpi=off" and the interpreter will not be in your
way:-)

cheers,
-Len
