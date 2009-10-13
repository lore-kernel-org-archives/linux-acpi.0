From: Ricardo Jorge da Fonseca Marques Ferreira <storm@sys49152.net>
Subject: Re: [PATCH] pci: increase alignment to make more space for hidden code
Date: Tue, 13 Oct 2009 20:05:27 +0100
Message-ID: <200910132005.27487.storm@sys49152.net>
References: <200908072333.24631.storm@sys49152.net> <4AD38734.2040600@kernel.org> <1255414115.14484.47.camel@dc7800.home>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760649AbZJMTJX@vger.kernel.org>
In-Reply-To: <1255414115.14484.47.camel@dc7800.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jesse Barnes <jesse.barnes@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Yannick Roehlly <yannick.roehlly@free.fr>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, x86@kernel.org, andreaorru91@gmail.com, jjorge@free.fr
List-Id: linux-acpi@vger.kernel.org

On Tuesday 13 October 2009, Bjorn Helgaas wrote: 
> If anybody can try this, I'd really appreciate it.  Here's what I would
> like to see:
> 
>   - start with a current git tree (I used 2caa731819a633be)
>   - apply the patch below
>   - turn on CONFIG_PCI_DEBUG
>   - boot with "pci=earlydump", collect dmesg
>   - boot with "pci=earlydump,use_crs", collect dmesg
>   - boot Windows, collect Device Manager resources for 00:1c.4 and
> 07:00.0 

I just did what you requested and added the attachments to the original 
bugreport. I couldn't boot Windows because i don't have it installed anywhere 
in the laptop.

Booting both latest and 2.6.31 with pci=use_crs, fixes the problem.
