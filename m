From: Len Brown <lenb417@gmail.com>
Subject: Re: kernel panic
Date: Wed, 26 Oct 2011 06:00:15 -0400
Message-ID: <CAJvTdKmeEGVz8fXhaoFUOCtMM4bufTraTvztrf93880a1sVqKw@mail.gmail.com>
References: <4EA549C3.4080206@ntlworld.com>
	<CAErSpo4EtfhnhWGpahk-NfMUVEizZSk3igZ+Vy7x=+hY5b0bcw@mail.gmail.com>
Reply-To: lenb@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f66.google.com ([209.85.214.66]:56217 "EHLO
	mail-bw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932616Ab1JZKAR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Oct 2011 06:00:17 -0400
In-Reply-To: <CAErSpo4EtfhnhWGpahk-NfMUVEizZSk3igZ+Vy7x=+hY5b0bcw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: nick bray <nick.bray1@ntlworld.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

>> =A0after upgrading to linux kernel 3.xx I get kernel panic on boot u=
nless I
>> use ACPI=3Doff in the boot parameters this happens with both Ubuntu =
11.10 and
>> Fedora 16. The mainboard is an Intel S875WP1-E running a Pentuim 4 3=
ghz with
>> 3gig RAM in single-channel mode. I have performed a Bios upgrade jus=
t in
>> case tha ACPI tables were corrupt but it makes no difference. Curren=
tly
>> running 2.6.38-11-generic #50-Ubuntu SMP (Linux Mint) with no issues=
=2E

Is this problem new in 3.1, or is it also present in 2.6.39 or 3.0?

Also, do any other cmdline parmaters besides acpi=3Doff work-around it?
pci=3Dnoacpi
maxcpus=3D1

etc.

thanks,
Len Brown, Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
