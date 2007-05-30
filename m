From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPICA vs. Linux status
Date: Wed, 30 May 2007 11:43:52 +0400
Message-ID: <465D2B38.6000407@gmail.com>
References: <200705291815.09493.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:9113 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbXE3HoA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 May 2007 03:44:00 -0400
Received: by ug-out-1314.google.com with SMTP id j3so123129ugf
        for <linux-acpi@vger.kernel.org>; Wed, 30 May 2007 00:43:59 -0700 (PDT)
In-Reply-To: <200705291815.09493.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: robert.moore@intel.com, linux-acpi@vger.kernel.org

Len,

Do you still plan to do "git cvsimport" of ACPICA and put it somethere
visible?

Regards,
Alex.

Len Brown ?????:
>> Subject: [Patch 1/8] ACPICA: Update _OSI string list
> 
> applied
> 
>> Subject: [Patch 2/8] ACPICA: Changes for Cygwin compatibility
> 
> applied
> 
>> Subject: [Patch 3/8] ACPICA: Support for external package objects as method arguments
> 
> applied after hand editing.
> Unclear why hand-ending was necessary, as there were no Linux specific
> changes to this file beneath this delta.
> Must be either Lindent weirdness or 0x20070320, mentioned below.
> 
>> Subject: [Patch 4/8] ACPICA: Fixed possible corruption of global GPE list
> 
> applied
> 
>> Subject: [Patch 5/8] ACPICA: Fix for update of the Global Lock Handle
> 
> did not apply, as it conflicts with the pre-existing Linux fix here,
> which I decided to keep for the time being.
> 
>> Subject: [Patch 6/8] ACPICA: Change to make Notify() operator completely synchronous
> 
> While the patch applied, it did not work, and is thus rejected.
> It caused "cat temperature" on my nx6325 to deadlock someplace
> in the region of a trip point.
> 
>> Subject: [Patch 7/8] ACPICA: Clear reserved fields for incoming ACPI 1.0 FADTs
> 
> applied.
> 
>> Subject: [Patch 8/8] ACPICA: Update version to 20070508
> 
> did not apply, and didn't hand-apply it for two reasons:
> 1. we don't yet include all the changes from 20070508.
> 
> 2. It expects ACPICA version 0x20070320 underneath,
> but Linux doesn't have that version, it is at 0x20070126.
> 
> Bob, Please send the patch series for 0x20070320.
> 
> thanks,
> -Len
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

