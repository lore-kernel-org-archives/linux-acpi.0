From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [ACPI] Machines self-power-up with 2.6.9-rc3 (evo N620c, ASUS,
	...)
Date: Thu, 21 Oct 2004 08:31:18 +1000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1098311478.4989.100.camel@desktop.cunninghams>
References: <20041020191531.GC21315@elf.ucw.cz>
Reply-To: ncunningham@linuxmail.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S270530AbUJTWhm@vger.kernel.org>
In-Reply-To: <20041020191531.GC21315@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI mailing list <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Thu, 2004-10-21 at 05:15, Pavel Machek wrote:
> Hi!
> 
> I'm seeing bad problem with N620c notebook (and have reports of more
> machines behaving like this, for example ASUS L8400C.) If I shutdown
> machine with lid closed, opening lid will power the machine up. Ouch.
> 2.6.7 behaves okay.

:> Some people would love to have the machine power up when they open
the lid! Wish my XE3 would do that!

> Ouch, acpi=off makes it even worse [2.6.9-rc3, N620c]. I get some very
> strange show on the leds (battery charge led blinks fast?!), then
> machine powers up itself. This happens even with lid initially
> open. 2.6.7 works as expected.

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.
