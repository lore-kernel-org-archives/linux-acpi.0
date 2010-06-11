From: Jeffrey Merkey <jeffmerkey@gmail.com>
Subject: Re: Linux 2.6.34 causes system lockup on Compaq Presario 2200 Laptop
Date: Fri, 11 Jun 2010 15:19:09 -0600
Message-ID: <AANLkTimYYAD3hKRi9IXPSn428YqeGnR1Ig02FpVIbVgL@mail.gmail.com>
References: <AANLkTil6GGSoc8TpzRacr1LZBZS3ee3H1ejYDSqfdul4@mail.gmail.com>
	<20100529202253.0bd18bbd.akpm@linux-foundation.org>
	<alpine.LFD.2.00.1006091821060.1402@localhost.localdomain>
	<AANLkTilrLYu6H3GtAcP-cHpFvrm3v22uCw2EUeW_ZK0k@mail.gmail.com>
	<alpine.LFD.2.00.1006111258430.6282@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39981 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274Ab0FKVnK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jun 2010 17:43:10 -0400
In-Reply-To: <alpine.LFD.2.00.1006111258430.6282@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Jun 11, 2010 at 11:07 AM, Len Brown <lenb@kernel.org> wrote:
> On Fri, 11 Jun 2010, Jeffrey Merkey wrote:
>
>> Len,
>>
>> I am having trouble getting a trace of this because its down hard to
>> reproduce. =A0The reason is the lockup happens before I log into the
>> laptop. =A0i.e. I boot 2.6.34 and if I let the laptop just sit there=
 is
>> happens. =A0If I log in and start doing work on it, it does not seem=
 to
>> happen. =A0It's related to using the laptop on battery mode with the
>> charger removed. =A0I have a 2U appliance setup I am working on toda=
y
>> and this frees up the laptop to try to reproduce this. =A0The flaky
>> battery power misreporting was in fact accurate. =A0The battery in t=
hat
>> laptop is 6 years old and does have low power. =A0I am certain the
>> lockup if related though. =A0I will try to reproduce today and setup=
 the
>> trace to run after boot. =A0I have had it sitting there for an =A0ho=
ur and
>> it has not reoccurred. =A0Let me try through today and if I cannot
>> reproduce, close the bug.
>
> Good to know, Jeff.
>
> One possibility is that the old battery is confusing
> the embedded controller -- possibly exposing a firmware bug.
> The EC, in turn, is fully capable of hanging the OS.
>
> If you *can* reproduce it, it may be interesting to bisect
> recent changes to drivers/acpi/ec.c
>
> Also, if you can reproduce it, it would be good to verify
> that the problem occurs only when the battery driver is loaded.
>
> thanks,
> -Len
>
>> > Please attach the output of acpidump here:
>> >
>> > https://bugzilla.kernel.org/show_bug.cgi?id=3D16136
>
> We could still use this output -- note that you can
> capture it at any time, independent of the failure,
> and independent of the kernel -- as it is simply
> a copy of the tables that the BIOS is exporting to Linux.
>
> thanks,
> -Len Brown, Intel Open Source Technology Center
>

I can tell you for certain it does only happen when the battery driver
is loaded.  Still has not ocurred.  Just rebooted it 15 minutes ago --
trying again.

Jeff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
