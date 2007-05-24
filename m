From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: HP Compaq nc6320 Suspend / Resume (changes in behaviour)
Date: Thu, 24 May 2007 20:03:07 +0100
Message-ID: <1180033387.6463.10.camel@localhost>
References: <1179859741.27532.8.camel@localhost>
	 <1180032699.16396.161.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:50348 "EHLO
	ppsw-9.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbXEXTDM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 May 2007 15:03:12 -0400
In-Reply-To: <1180032699.16396.161.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi@vger.kernel.org

On Thu, 2007-05-24 at 20:51 +0200, Thomas Renninger wrote:
>  
> > dmesg  | grep ACPI | grep Error
> > [ 4763.428000] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C241] (Node df94c9dc), AE_AML_PACKAGE_LIMIT
> > [ 4763.428000] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C002.C0DC.C349._STM] (Node df94fba8), AE_AML_PACKAGE_LIMIT
> > [ 6417.528000] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C241] (Node df94c9dc), AE_AML_PACKAGE_LIMIT
> > [ 6417.528000] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C002.C0DC.C349._STM] (Node df94fba8), AE_AML_PACKAGE_LIMIT
> > 
> > Is this anything to worry about - should I post a dsdt for the new bios?
> 
> STR works (also the disk(s)?)?

STR works, and resume - works fine afterwards.
STD works, resumes, but crashes some minutes afterwards.

> This is strange, bug:
> http://bugzilla.kernel.org/show_bug.cgi?id=8456
> is about broken SATA disks after STR.
> 
> If you think this is related to bug #8456, you might want to add
> yourself there or open a new bug if you think it's not.
>
> You might want to add htejun@gmail.com (Tejun Heo), who did the latest
> ACPI SATA changes. Best you also add acpidump output and also CC me,
> pls.

I'll open a new bug (or bugs, keeping the STD issue separate) some time
next week when I'll have a little more time to play with debugging
things.

Thanks for your reply,

Regards.

-- 
Peter Clifton

Electrical Engineering Division,
Engineering Department,
University of Cambridge,
9, JJ Thomson Avenue,
Cambridge
CB3 0FA

Tel: +44 (0)7729 980173 - (No signal in the lab!)

