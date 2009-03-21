From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Sat, 21 Mar 2009 14:55:02 +0000
Message-ID: <20090321145502.GA28452@srcf.ucam.org>
References: <20090319212123.GA24700@srcf.ucam.org> <20090320085213.GC4743@kamineko.org> <20090320140004.GA4882@srcf.ucam.org> <20090321040010.GD3834@kamineko.org> <20090321043513.GA20519@srcf.ucam.org> <20090321063229.GE3834@kamineko.org> <20090321140654.GA28039@srcf.ucam.org> <20090321143717.GA21091@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50861 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608AbZCUOzG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Mar 2009 10:55:06 -0400
Content-Disposition: inline
In-Reply-To: <20090321143717.GA21091@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

On Sat, Mar 21, 2009 at 11:37:18PM +0900, Mattia Dongili wrote:

> Oh, do you have a vaio type P DSDT to share?

Attached. I'm now fairly sure that the second byte returned by SN00(4) 
is the gross version, with the leading byte being a subversion(!?). 
Machines with 0x4a in the second byte have the following set of methods 
(as called by SN07):

   0x33:  0x34:  0x36:  0x37:
0, 0x0101 0x0101 0x0101 0x0101
1, 0x0102 0x0102 0x0102 0x0102
2, 0x0100 0x0100 0x0100 0x0100
3, 0x0104        0x0104
4, 0x0107 0x010F 0x0107 0x010F
5,               0x0106 0x0106
6,               0x0000 0x0113
7,        0x0111        0x010A
C,               0x010C
D,               0x010D 0x010D
E, 0x0105 0x0105 0x0105 0x0105
F, 0x0103 0x0103 0x0103

They're indexed by the leading byte. Machines with 0x4d as the second 
byte have:

0, 0x0100
1, 0x0101
2, 0x0113
3, 0x0124
4, 0x0126
5, 0x0125
6, 0x011D
7, 0x0121
8, 0x0105
9, 0x0114
a, 0x0119
b, 0x0122
c, 0x0128
d, 0x0115
e, 0x0131
f, 0x12f

Machines with 0x55 as the second byte (only the P, as far as I can 
tell):

0, 0x100
1, 0x101
2, 0x113
3, 0x124
4, 0x132
5, 0x125
6, 0x11d
7, 0x121
8, 0x105
9, 0x114
a, 0x119
b, 0x122
c, 0x130
d, 0x115
e, 0x131

This actually makes me think I've been taking the wrong approach. I'm 
now guessing that the numbers returned by SN00 in the 20-2f range are 
method signatures - 0x100 is hotkeys, 0x124 is rfkill. This fits with 
the fact that SN07(0) looks to return hotkey values on the Z, whereas 
that's SN07(2) on the older hardware. Both have 0x100 returned by 
SN00(0x20). I think if we rewrite the code on this basis we can merge 
the functionality. I'll try to do that tomorrow and also (with luck) get 
the hotkey stuff on the Z back up.

> Sure, if you're ok I'll apply the patch you sent just changing the
> rfkill_free and send the whole patch-set to Len tomorrow morning (JST).

Mind waiting until I've tried this rewrite? It'd be nice to know what a 
bunch more of these methods do, but I guess that's less urgent.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
