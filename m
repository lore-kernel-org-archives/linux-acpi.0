From: Maciek Rutecki <maciej.rutecki@gmail.com>
Subject: Re: SATA error while resume
Date: Sun, 19 Aug 2007 18:25:12 +0200
Message-ID: <46C86EE8.1020803@gmail.com>
References: <46C80999.1060700@gmail.com> <46C852DE.8040701@rtr.ca> <46C85ED8.5080801@gmail.com> <46C8666F.4080603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <46C8666F.4080603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

Tejun Heo pisze:

> Hmmmm... Does Power-Off_Retract_Count increase after suspend/resume cycle?
>


No.

Before:

rutek:/home/maciek# smartctl -A -d ata /dev/sda  | grep
Power-Off_Retract_Count
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always
      -       66


Tested:

2.6.22.1 OK (double spin down of disk issue).

2.6.23-rc2 with patches [1] (prevent double spin down while suspend to
disk), also was tested ealier [2] OK

[1] http://www.ussg.iu.edu/hypermail/linux/kernel/0708.0/2655.html
[2] http://www.ussg.iu.edu/hypermail/linux/kernel/0708.0/2784.html


After:
rutek:/home/maciek# smartctl -A -d ata /dev/sda  | grep
Power-Off_Retract_Count
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always
      -       66


-- 
Maciej Rutecki
http://www.maciek.unixy.pl
