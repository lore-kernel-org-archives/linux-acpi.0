From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: acpi_apic_instance=2 and a question
Date: Mon, 27 Jun 2011 11:54:50 -0600
Message-ID: <BANLkTinwhwSGQJxtrGO_-K9DScitf861pQ@mail.gmail.com>
References: <1308756897.42310.YahooMailClassic@web26701.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:2521 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab1F0RzN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jun 2011 13:55:13 -0400
Received: from hpaq2.eem.corp.google.com (hpaq2.eem.corp.google.com [172.25.149.2])
	by smtp-out.google.com with ESMTP id p5RHtCxT002089
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jun 2011 10:55:12 -0700
Received: from ywt2 (ywt2.prod.google.com [10.192.20.2])
	by hpaq2.eem.corp.google.com with ESMTP id p5RHtAha006527
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jun 2011 10:55:11 -0700
Received: by ywt2 with SMTP id 2so2194905ywt.30
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jun 2011 10:55:10 -0700 (PDT)
In-Reply-To: <1308756897.42310.YahooMailClassic@web26701.mail.ukl.yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John S <johns9872003@yahoo.co.uk>
Cc: linux-acpi@vger.kernel.org

On Wed, Jun 22, 2011 at 9:34 AM, John S <johns9872003@yahoo.co.uk> wrot=
e:
> Hi,
>
> kernel 2.6.33.7
>
> laptop from ECS aka ELITEGROUP aka Uniwill
> model L75II0
> Intel Core2 Duo T5750 2GHz
> Phoenix BIOS
>
> It's different, maybe better, with acpi_apic_instance=3D2
>
> If you'd like more details / output from anything (dmesg? acpidump? d=
midecode? whatever) please ask.
>
> I'd like to get Linux running better on it - only starts 1 CPU wherea=
s sadly Vista starts both cores. =A0Any suggestions welcome!
>
> I've tried newer test kernels for ArchLinux (sorry, not yet kernel de=
vel / Linus ones) and both 32-bit and 64-bit only start 1 core.
>
> I'm currently looking at files such as smpboot.c and drivers/acpi/tab=
les.c but don't really know what I should be doing to try to understand=
 the sequence of events so I can try to work around what is no doubt a =
buggy BIOS. =A0No BIOS updates available from maker's websites.

As a start, I'd suggest opening a kernel bugzilla and attaching the
dmesg logs (with and without acpi_apic_instance=3D2) and acpidump to it=
=2E
 Here are some tips for doing that:
http://kernel.org/pub/linux/kernel/people/helgaas/debug .  It'd be
nicest if you could do this with a recent upstream kernel, e.g.,
3.0-rc4.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
