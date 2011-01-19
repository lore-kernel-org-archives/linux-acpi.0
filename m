From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: [linux-pm] Resume from Memory very slow on 2.6.37+
Date: Wed, 19 Jan 2011 22:13:13 +0800
Message-ID: <AANLkTimf3B=z1DCA2q+yi-ccyAJwmjkB_g8EP=ZTehmn@mail.gmail.com>
References: <AANLkTimBEnKTuR5aQyXvpZX8grQPw1eCaVgP-k9yBXhv@mail.gmail.com>
	<201101182120.16835.rjw@sisk.pl>
	<AANLkTikay6g5rOyDnv_ocz49GvUcQN+OkrusrbcRPB0K@mail.gmail.com>
	<201101190238.18529.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37410 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab1ASONN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jan 2011 09:13:13 -0500
Received: by iyj18 with SMTP id 18so851550iyj.19
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jan 2011 06:13:13 -0800 (PST)
In-Reply-To: <201101190238.18529.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Jack Steiner <steiner@sgi.com>, Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Jan 19, 2011 at 9:38 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, January 19, 2011, Jeff Chua wrote:
>> On Wed, Jan 19, 2011 at 4:20 AM, Rafael J. Wysocki <rjw@sisk.pl> wro=
te:
>> > Please apply the appended patch (without the previous one) and pos=
t a dmesg
>> > log containing a suspend-resume cycle with the delay. =A0I wonder =
where exactly
>> > the delay occurs.
>> > + =A0 =A0 =A0 pr_info("%s: synchronize_rcu()\n", __func__);
>> > =A0 =A0 =A0 =A0synchronize_rcu();
>> > + =A0 =A0 =A0 pr_info("%s: iounmap(%p), physaddr: %llx, size: %u\n=
", __func__,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 map->virt, map->phys, map->size);
>>
>> Rafael,
>>
>> The 30 seconds is due to this ...
>>
>> PM: Syncing filesystems ... done.
>> Freezing user space processes ... _memory: synchronize_rcu()
>> acpi_os_unmap_memory: iounmap(ffffc90001c22000), physaddr: bb398000,=
 size: 4096
>> acpi_os_unmap_memory: synchronize_rcu()
>> acpi_os_unmap_memory: iounmap(ffffc90001c26000), physaddr: bb399000,=
 size: 4096
00), physaddr: bb79e000, size: 4096
>> Restarting tasks ... done.
>>
>> After this, I see my X windows.
>
> Are you able to say whether the synchronize_rcu() or the iounmap() ca=
lls block?

It's "synchronize_rcu()" that's causing the slow down. Removing it
solves the problem.

Does synchronize_rcu() triggers the limiting update rate as described
in Documentation/RCU/whatisRCU.txt?

        In addition, the synchronize_rcu() API has the nice property
        of automatically limiting update rate should grace periods
        be delayed.  This property results in system resilience in face
        of denial-of-service attacks.


Thanks,
Jeff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
