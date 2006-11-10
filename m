From: "Lu, Yinghai" <yinghai.lu@amd.com>
Subject: RE: 2.6.19-rc5 x86_64 irq 22: nobody cared
Date: Thu, 9 Nov 2006 18:09:21 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA49071D4@ssvlexmb2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:33834 "EHLO
	outbound2-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1945965AbWKJCJh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Nov 2006 21:09:37 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olivier Nicolas <olivn@trollprod.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Adrian Bunk <bunk@stusta.de>, Stephen Hemminger <shemminger@osdl.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com, linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

Eric,

Can you confirm:
>From 2.6.19-rc1, the irq for devices that using io-apic will not change
between pci=routeirq and not.

Olivier,
Can you send lspci -vvxxx for pci=routeirq too?

YH




