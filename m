From: Tomas Salfischberger <tomas@salfischberger.nl>
Subject: Re: Acpi suspend to ram on Acer Aspire 5672
Date: Sun, 04 Nov 2007 22:59:58 +0100
Message-ID: <472E40DE.4090001@salfischberger.nl>
References: <472847A2.9020901@salfischberger.nl> <fgktis$ra8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rs6.shcomputers.nl ([88.198.238.124]:37524 "EHLO
	rs6.shcomputers.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331AbXKDWAE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Nov 2007 17:00:04 -0500
Received: from [192.168.1.101] (535315C8.cable.casema.nl [83.83.21.200])
	(Authenticated sender: tomas@shcomputers.nl)
	by rs6.shcomputers.nl (Postfix) with ESMTP id 835F4E000F
	for <linux-acpi@vger.kernel.org>; Sun,  4 Nov 2007 22:00:01 +0000 (UTC)
In-Reply-To: <fgktis$ra8$1@ger.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

Roman Rumisek wrote:
> I have this problem on ACER Extensa 5220.
> The "save to disk" is OK,but after "save to RAM" the notebook hangs
> and seems (for example when i press CapsLock key - nothing) one is dead.
>   

I also received an off-list reply from Peter Pregler about his Acer TM
3200 having the same issues.

What we need to debug this is some method of first finding out whether
the kernel-code is actually reached during the resume process. If it is
actually executing kernel-code, we need to debug at which point in
hardware initialization it gets stuck.

Peter mentioned we need serial-port access (or a special firewire-cable)
to debug. Do you have a docking-station?

An other approach would be to patch the kernel to use the system-speaker
to output some debug beeps. I'll look into that the next moment I have a
few spare hours, probably Thursday.

Just to get more details: Is the "Acer Extensa 5220" a dual core model?

Thanks for your reply,

Tomas
