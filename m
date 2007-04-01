From: koko <citizenr@gmail.com>
Subject: Re: repost: read the spd on A7V133 | without UTF-8
Date: Sun, 1 Apr 2007 21:33:16 +0200
Message-ID: <3df49b7b0704011233g3e5686dvd3433b3e5ee36d1e@mail.gmail.com>
References: <3df49b7b0703311542l79ea2595pcfd8546aab4b07ac@mail.gmail.com>
	 <3df49b7b0703311629t317db7abt64e10cec7f661a04@mail.gmail.com>
	 <3df49b7b0704011025n397b164boc2d8c714c86ed9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:8617 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933928AbXDATdR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Apr 2007 15:33:17 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1334849wra
        for <linux-acpi@vger.kernel.org>; Sun, 01 Apr 2007 12:33:17 -0700 (PDT)
In-Reply-To: <3df49b7b0704011025n397b164boc2d8c714c86ed9e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lm-sensors@lm-sensors.org
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

On 4/1/07, koko <citizenr@gmail.com> wrote:
> >blabal

hmmm

> Mux 0 Asus IO mux, IO 0000e44dh, Ext 4267320

rasz@capek:~$ cat /proc/ioports|grep e4
e400-e47f : motherboard
  e400-e403 : ACPI PM1a_EVT_BLK
  e404-e405 : ACPI PM1a_CNT_BLK
  e408-e40b : ACPI PM_TMR
  e410-e415 : ACPI CPU throttle
  e420-e423 : ACPI GPE0_BLK

I decompiled ACPI DSDT from my bios and found this :

    OperationRegion (\SGPO, SystemIO, 0xE44C, 0x04)
    Field (SGPO, ByteAcc, NoLock, Preserve)
    {
        GPO0,   1,
                Offset (0x01),
        GPO8,   1,
            ,   2,
        GP11,   1,
                Offset (0x04)
    }

1 is my  ACPI broken? it doesnt claim 0xe44d as motherboard resource?
Or is Kernel ACPI handling broken? there are other e4xx regions in my
DSDT that are not claimed.
   OperationRegion (GPOB, SystemIO, 0xE42A, 0x02)
   OperationRegion (GPSC, SystemIO, 0xE42F, 0x01)
2 which bits exactly should I fiddle with? and how, is there a simple
way to play with them (like isaset/isadump for ports)?
3 Is work on i2c-virtual desired? or is this idea abandoned completely
by now and I should write a hack just for me?

-- 
Who logs in to gdm? Not I, said the duck.
