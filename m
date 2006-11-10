From: "Lu, Yinghai" <yinghai.lu@amd.com>
Subject: RE: 2.6.19-rc5 x86_64 irq 22: nobody cared
Date: Fri, 10 Nov 2006 10:20:58 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA49071D9@ssvlexmb2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:60009 "EHLO
	outbound2-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1161942AbWKJSZE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Nov 2006 13:25:04 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>, Olivier Nicolas <olivn@trollprod.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Stephen Hemminger <shemminger@osdl.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>


Andi,

The two patches solve the problems that irq nobody care.

They are already in your tree. But first one I wonder if you put correct
one in your tree.


YH

[PATCH] x86_64 irq: reuse vector for __assign_irq_vector 
http://lkml.org/lkml/2006/10/26/38
[PATCH] x86_64 irq: reset more to default when clear irq_vector for
destroy_irq
http://lkml.org/lkml/2006/10/28/16



