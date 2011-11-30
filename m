From: Natanji <natanji@gmail.com>
Subject: Re: [ibm-acpi-devel] Regression in thinkpad-acpi events
Date: Wed, 30 Nov 2011 14:34:37 +0100
Message-ID: <4ED630ED.3070301@gmail.com>
References: <4EBAC3B5.5060405@gmail.com> <201111142031.06663.maciej.rutecki@gmail.com> <4EC16F8E.7060601@gmail.com> <201111142118.47256.maciej.rutecki@gmail.com> <CAG-2HqVnsmSyHVCvEVf+sZw5NxhR8qSDDB0AtR+igwCCFiwfgQ@mail.gmail.com> <20111115230305.GA23325@khazad-dum.debian.net> <20111127022346.32f11849@schlepp.lan> <4ED5F5D7.8020208@gmail.com> <20111130111507.GA32079@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64115 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109Ab1K3Neo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Nov 2011 08:34:44 -0500
In-Reply-To: <20111130111507.GA32079@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Henning Schild <henning@wh9.tu-dresden.de>, Tom Gundersen <teg@jklm.no>, ibm-acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, maciej.rutecki@gmail.com, lenb@kernel.org

Yes, there are dozens of acpi interrupts every second.

$ cat /proc/interrupts | grep acpi ; sleep 1; cat /proc/interrupts | 
grep acpi
  9:    1776309          0   IO-APIC-fasteoi   acpi
  9:    1776332          0   IO-APIC-fasteoi   acpi

On Wed 30 Nov 2011 12:15:07 PM CET, Henrique de Moraes Holschuh wrote:
> On Wed, 30 Nov 2011, Natanji wrote:
>> The standard Arch kernel does not use tuxonice, you need to build your
>> kernel manually if you want it. I also don't receive these events before
>> the first hibernation, so you might be having a different problem.
>
> Just a hunch: check /proc/interrupts.  One of them must be assigned to acpi,
> and it *must* increase when you press hotkeys, etc.
>
> Does it?
>
