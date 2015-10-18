From: =?iso-8859-1?Q?Niccol=F2_Belli?= <niccolo.belli@linuxsystems.it>
Subject: Re: [Dell XPS 13 9343] Random kernel Oops at boot with =?iso-8859-1?Q?"acpi=3Dht",_disappearing_with_"acpi=3Doff"?=
Date: Mon, 19 Oct 2015 00:18:54 +0200
Message-ID: <75739899-c216-46ab-9ba5-dee9e07c77af@linuxsystems.it>
References: <16367d85-fe84-4792-819a-d50a508409ef@linuxsystems.it>
 <20151002101919.GZ1551@lahna.fi.intel.com>
 <c4c8d5aa-d2ad-4448-9ca5-d381c30ba6d7@linuxsystems.it>
 <20151005104645.GA1506@lahna.fi.intel.com>
 <97e73880-b4a6-4118-bf11-6a90d2505fd1@linuxsystems.it>
 <20151005135449.GF1506@lahna.fi.intel.com>
 <481e7bc8-b4c4-4acd-9988-f3e0e5ea87b3@linuxsystems.it>
 <20151008100615.GO1506@lahna.fi.intel.com>
 <9517e70c-d3ec-4dd0-8064-a06546812d16@linuxsystems.it>
 <20151008102816.GP1506@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxsystems.it ([2.119.245.41]:54301 "EHLO
	mail.linuxsystems.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbbJRWS6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 18 Oct 2015 18:18:58 -0400
In-Reply-To: <20151008102816.GP1506@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

I tried to use Ubuntu's kernel with Ubuntu's initramfs on Arch, but som=
ehow=20
I didn't manage to boot the system.

So I kept the Ubuntu kernel and I generated a new initramfs for it: I s=
till=20
get crashes at boot, maybe a bit less frequently.

Then I decided to build a kernel statically without using initramfs at =
all:=20
I don't get crashes anymore!!!

So even Ubuntu's kernel *IS* bugged, but somehow only Arch's initramfs=20
exposes the bug.

Unfortunately my laptop uses dm-crypt, so I *need* an initramfs to boot=
 it=20
(I was booting a flash drive in my tests).

Niccol=C3=B2 Belli
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
