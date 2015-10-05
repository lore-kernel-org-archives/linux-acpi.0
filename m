From: =?iso-8859-1?Q?Niccol=F2_Belli?= <niccolo.belli@linuxsystems.it>
Subject: Re: [Dell XPS 13 9343] Random kernel Oops at boot with =?iso-8859-1?Q?"acpi=3Dht",_disappearing_with_"acpi=3Doff"?=
Date: Mon, 05 Oct 2015 15:41:09 +0200
Message-ID: <97e73880-b4a6-4118-bf11-6a90d2505fd1@linuxsystems.it>
References: <16367d85-fe84-4792-819a-d50a508409ef@linuxsystems.it>
 <20151002101919.GZ1551@lahna.fi.intel.com>
 <c4c8d5aa-d2ad-4448-9ca5-d381c30ba6d7@linuxsystems.it>
 <20151005104645.GA1506@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxsystems.it ([2.119.245.41]:49600 "EHLO
	mail.linuxsystems.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbbJENlS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2015 09:41:18 -0400
In-Reply-To: <20151005104645.GA1506@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Il luned=C3=AC 5 ottobre 2015 12:46:45 CEST, Mika Westerberg ha scritto=
:
> On Sat, Oct 03, 2015 at 12:11:54PM +0200, Niccol=C3=B2 Belli wrote:
>> On venerd=C3=AC 2 ottobre 2015 12:19:19 CEST, Mika Westerberg wrote:=
 ...
>
> What if you disable the whole ALSA SoC?
>
> CONFIG_SND_SOC=3Dn

Now I don't get any Oops but it doesn't reach the login anymore: instea=
d it=20
goes into emergency mode! :(
Log: https://bugzilla.kernel.org/attachment.cgi?id=3D189471

Thanks,
Niccol=C3=B2 Belli
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
