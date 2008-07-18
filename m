From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI: Provide a spec conform OSI interface to the BIOS
Date: Fri, 18 Jul 2008 19:22:11 +0200
Message-ID: <200807181922.11728.trenn@suse.de>
References: <1216316268-24042-1-git-send-email-trenn@suse.de> <48804349.607@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48236 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbYGRR4R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jul 2008 13:56:17 -0400
In-Reply-To: <48804349.607@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

On Friday 18 July 2008 09:16:25 am Andi Kleen wrote:
> Thomas Renninger wrote:
> > Introduce acpi_osi=windows_false boot parameter
> > Introduce CONFIG_ACPI_OSI_SPEC_CONFORM config option
>
> Why are you adding the CONFIG option? 
> In what circumstances would one 
> set it? If anything I think this should be a boot option only for now.
E.g. for OEMs that do not need to support all BIOSes in the world who 
can just check for the config option and then know it behaves as written in 
the spec and being able to support Linux and Windows through the same BIOS.

But you are right, the compile option only makes sense if acpi_osi="Windows 
2006" can be used to simulate a specific Windows OS via boot param, which is 
not the case.

But I want the boot param. This one makes very much sense to test BIOSes 
whether they stick to the ACPI spec and work fine on Linux without Windows 
simulation. Is that ok?

> Probably needs more discussion first.
I always wanted to write down the arguments again, but this takes a lot time.
Will you accept the boot param only?

       Thomas
