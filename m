From: =?iso-8859-1?Q?Niccol=F2_Belli?= <niccolo.belli@linuxsystems.it>
Subject: Re: [Dell XPS 13 9343] Random kernel Oops at boot with =?iso-8859-1?Q?"acpi=3Dht",_disappearing_with_"acpi=3Doff"?=
Date: Mon, 05 Oct 2015 17:59:38 +0200
Message-ID: <481e7bc8-b4c4-4acd-9988-f3e0e5ea87b3@linuxsystems.it>
References: <16367d85-fe84-4792-819a-d50a508409ef@linuxsystems.it>
 <20151002101919.GZ1551@lahna.fi.intel.com>
 <c4c8d5aa-d2ad-4448-9ca5-d381c30ba6d7@linuxsystems.it>
 <20151005104645.GA1506@lahna.fi.intel.com>
 <97e73880-b4a6-4118-bf11-6a90d2505fd1@linuxsystems.it>
 <20151005135449.GF1506@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxsystems.it ([2.119.245.41]:50484 "EHLO
	mail.linuxsystems.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbbJEP7m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2015 11:59:42 -0400
In-Reply-To: <20151005135449.GF1506@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Il luned=C3=AC 5 ottobre 2015 15:54:49 CEST, Mika Westerberg ha scritto=
:
> On Mon, Oct 05, 2015 at 03:41:09PM +0200, Niccol=C3=B2 Belli wrote:
>> Il luned=C3=AC 5 ottobre 2015 12:46:45 CEST, Mika Westerberg ha scri=
tto: ...
>
> It says:
>
> Mounting /boot...
> [FAILED] Failed to mount /boot.
> See 'systemctl status boot.mount' for details.
> [DEPEND] Dependency failed for Local File Systems.
>
> Did you run 'systemctl status boot.mount'?

Please do not consider my previous e-mail, becuase the failure was due =
to=20
file loss: in fact sometimes the system hangs while shutting down (I th=
ink=20
because of this bug) and so some modules of my just compiled kernel wer=
e=20
loss. I recompiled the kernel once again and synced the disks just to b=
e=20
sure: I still get random crashes even with CONFIG_SND_SOC=3Dn.
See the new log: https://bugzilla.kernel.org/attachment.cgi?id=3D189481

Thank you very much for your help, it's much apreciated.
Niccol=C3=B2 Belli
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
