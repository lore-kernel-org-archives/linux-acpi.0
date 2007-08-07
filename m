From: "Maciej Rutecki" <maciej.rutecki@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Tue, 7 Aug 2007 23:28:00 +0200
Message-ID: <8db1092f0708071428lde63dc7o2b422ed81797a16e@mail.gmail.com>
References: <fa.bsWpbo79BZgHoaIGhEMfTEBxs54@ifi.uio.no>
	 <8db1092f0708071309h5cf6f68bo80b44d9a2fbeabeb@mail.gmail.com>
	 <200708072233.52500.rjw@sisk.pl> <200708072241.24091.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <200708072241.24091.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Michael Sedkowski <sedmich@gmail.com>, trenn@suse.de, Tejun Heo <htejun@gmail.com>, Robert Hancock <hancockr@shaw.ca>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

> > Well, on my box (nx6325) with the appended (experimental) patch applied
> > on top of 2.6.23-rc1 with the patchset from
>
> s/2.6.23-rc1/2.6.23-rc2/
>

HP nx 6310, _old_ shutdown 2.6.23-rc2+above patches:

1. Before:
rutek:/home/maciek# /usr/sbin/smartctl --all -d ata /dev/sda | grep
Power-Off_Retract_Count
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age
Always       -       61

2. Try suspend to disk, double spin down doesn't exist

3. Normal shutdown, double spin down exists, BUT NOTE: I have still
old shutdown utility from Debian package.

4. After:
rutek:/home/maciek# /usr/sbin/smartctl --all -d ata /dev/sda | grep
Power-Off_Retract_Count
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age
Always       -       61

(it doesn't change=61).

I wait for Michael, He has new shutdown from Sidux, and the same notebook.

-- 
Maciej Rutecki
http://www.maciek.unixy.pl
