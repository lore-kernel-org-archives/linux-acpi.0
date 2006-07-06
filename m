From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: Linux v2.6.18-rc1
Date: Thu, 6 Jul 2006 13:34:57 +0100
Message-ID: <200607061334.57282.s0348365@sms.ed.ac.uk>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ptb-relay03.plus.net ([212.159.14.214]:53710 "EHLO
	ptb-relay03.plus.net") by vger.kernel.org with ESMTP
	id S1030231AbWGFMev (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Jul 2006 08:34:51 -0400
In-Reply-To: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Thursday 06 July 2006 05:26, Linus Torvalds wrote:
> Ok,
>  the merge window for 2.6.18 is closed, and -rc1 is out there (git trees
> updated, the tar-ball and patches are still uploading over my pitiful DSL
> line - and as usual it may take a short while before mirroring takes
> place and distributes things across the globe).
>
> The changes are too big for the mailing list, even just the shortlog. As
> usual, lots of stuff happened. Most architectures got updated, ACPI
> updates, networking, SCSI and sound, IDE, infiniband, input, DVB etc etc
> etc.

ACPI problem here. Doesn't seem to actively break anything, but the messages
look bad (HP NC6000 notebook). Haven't tried suspending. The error popped
up roughly 90 minutes after booting. Laptop has been on AC power throughout.

ACPI Error (exmutex-0248): Cannot release Mutex [C0E8], not acquired [20060623]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C044.C057.C0E7.C12F] (Node c1aeca40), AE_AML_MUTEX_NOT_ACQUIRED
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C12F] (Node c1aeecfc), AE_AML_MUTEX_NOT_ACQUIRED
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C137._BST] (Node c1aeec84), AE_AML_MUTEX_NOT_ACQUIRED
ACPI Exception (acpi_battery-0206): AE_AML_MUTEX_NOT_ACQUIRED, Evaluating _BST [20060623]

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
