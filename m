From: Tako Schotanus <quintesse@palacio-cristal.com>
Subject: PCI: Cannot allocate resource region messages on resume after hibernate
Date: Mon, 06 Feb 2006 16:41:09 +0100
Message-ID: <43E76E15.9070601@palacio-cristal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:16136 "EHLO
	smtp-vbr4.xs4all.nl") by vger.kernel.org with ESMTP id S932094AbWBFPlB
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Feb 2006 10:41:01 -0500
Received: from [127.0.0.1] (80-69-73-222.colo.transip.net [80.69.73.222])
	(authenticated bits=0)
	by smtp-vbr4.xs4all.nl (8.13.3/8.13.3) with ESMTP id k16FevF4022922
	for <linux-acpi@vger.kernel.org>; Mon, 6 Feb 2006 16:40:59 +0100 (CET)
	(envelope-from quintesse@palacio-cristal.com)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I sent a similar message some days ago to the swsusp2 mailing list and 
it's maintainer told me to try here.

What I wanted to know is if anybody knows what could be wrong if after 
every suspend (either from KDE or from runlevel 3) the resume freezes 
showing several lines of "PCI: Cannot allocate resource region" with 
some numbers and a couple of other lines saying something about 
"resource collisions".

They appear immediately after the kernel info but before the swsusp2 
message about restoring the kernel. The system never wakes up though.

The strange thing is that after rebooting/resetting it again it _will_ 
continue resuming without errors..

The pci messages never appear during a "normal" boot sequence.

Does anybody have any idea what could be wrong? Or what information 
should I provide to be able to figure this out?

Cheers,
 -Tako

