From: "Octavio Alvarez" <alvarezp@alvarezp.com>
Subject: Re: [PATCH v2] ACPI: Leave Bus Master Arbitration enabled for
 suspend/resume
Date: Sun, 08 Jul 2012 13:43:59 -0700
Message-ID: <op.wg5ajlqi6g6bxc@localhost.localdomain>
References: <op.wg3en6ij6g6bxc@localhost.localdomain>
 <201207082143.04099.rjw@sisk.pl> <20120708194519.GA8807@burratino>
 <201207082208.19664.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from spider.alvarezp.com ([207.210.217.159]:36678 "EHLO
	spider.alvarezp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab2GHUpX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Jul 2012 16:45:23 -0400
In-Reply-To: <201207082208.19664.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>, Bob Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, Shaohua Li <shli@kernel.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 08 Jul 2012 13:08:19 -0700, Rafael J. Wysocki <rjw@sisk.pl> wrote:

>> This is an old suspend/resume lockup fix:
>>
>> 	commit 2780cc4660e1
>> 	Author: Len Brown <len.brown@intel.com>
>> 	Date:   Thu Dec 23 13:43:30 2004 -0500
>>
>> 	    [ACPI] Fix suspend/resume lockup issue
>> 	    by leaving Bus Master Arbitration enabled.
>> 	    The ACPI spec mandates it be disabled only for C3.
>>
>> The bug snuck back in in commit 2feec47d4c5f (ACPICA: ACPI 5: Support
>> for new FADT SleepStatus, SleepControl registers, 2012-02-14),
>> presumably by copy/pasting a copy of the code without that fix for the
>> legacy case.
>>
>> On affected machines, after that commit, the machine locks up hard on
>> resume from suspend.  The same fix as seven years ago still works.
>>
> Applied to the linux-next branch of the linux-pm.git tree.
>
> I think I'll push it for v3.6, since the bug is serious and is a  
> regression.
>
> Bob, I think we should incorporate this into ACPICA, shouldn't we?

This bug affects since 3.4. I'd like to ask for this to be applied in the
stable branches too, considering Jonathan's comments that this is a replay
of an old and proven fix.

(I don't know if 3.3 is affected too. I know 3.2 is not affected by this.)

Thanks.

-- 
Octavio.
