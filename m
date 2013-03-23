From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: 3.9-rc3+: reports battery as 0 mWh capacity on thinkpad x60
Date: Sat, 23 Mar 2013 14:00:23 +0100
Message-ID: <87zjxu9spk.fsf@nemi.mork.no>
References: <20130323114011.GA11092@amd.pavel.ucw.cz>
	<1364045783.tg02458AIS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:35347 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056Ab3CWNBk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Mar 2013 09:01:40 -0400
In-Reply-To: <1364045783.tg02458AIS@vostro.rjw.lan> (Rafael J. Wysocki's
	message of "Sat, 23 Mar 2013 13:32:19 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:
> On Saturday, March 23, 2013 12:40:12 PM Pavel Machek wrote:
>> Hi!
>>=20
>> pavel@amd:~$ cat /proc/acpi/battery/BAT0/info=20
>> present:                 yes
>> design capacity:         0 mWh
>> last full capacity:      0 mWh
>> battery technology:      rechargeable
>> design voltage:          14400 mV
>>=20
>> This worked before... at least it works in 2.6 kernel used by debian=
=2E
>
> This works for me in 3.9-rc3.  May I see your .config?

Well, if this works, then maybe the Kconfig help text should be updated=
:

config ACPI_PROCFS_POWER
        bool "Deprecated power /proc/acpi directories"
        depends on PROC_FS
        help
          For backwards compatibility, this option allows
          deprecated power /proc/acpi/ directories to exist, even when
          they have been replaced by functions in /sys.
          The deprecated directories (and their replacements) include:
          /proc/acpi/battery/* (/sys/class/power_supply/*)
          /proc/acpi/ac_adapter/* (sys/class/power_supply/*)
          This option has no effect on /proc/acpi/ directories
          and functions, which do not yet exist in /sys
          This option, together with the proc directories, will be
          deleted in 2.6.39.


Time to call the bluff now :)


Bj=C3=B8rn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
