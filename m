From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PATCH v3.1] thinkpad-acpi changes for the merge window (part 1)
Date: Sun, 23 Sep 2007 22:43:56 -0400
Message-ID: <200709232243.56477.lenb@kernel.org>
References: <11905583473293-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60134 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755184AbXIXCoI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Sep 2007 22:44:08 -0400
In-Reply-To: <11905583473293-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Okay, 
previous series replaced with this one.

thanks,
-Len

On Sunday 23 September 2007 10:38, Henrique de Moraes Holschuh wrote:
> Len,
> 
> Here is the third version (fixed) of the first batch of changes for
> thinkpad-acpi, targetted at the next merge window.   They're mostly
> non-critical fixes.
> 
> I have found a stupid bug on v2 and v2.1 of patch 6, and fixed it
> (hopefully correctly, this time). I am *really* sorry about that.
> 
> I have also added two new patches, that were going to be sent as part 2,
> but I might as well just send them in right now.
> 
> Patches 8 and 9 *fix* a big ABI problem with the way thinkpad-acpi was
> exporting the hwmon attributes, which precluded it from working with
> lm-sensors(!).  Since I am already touching the ABI, it also prepares
> the thinkpad-acpi sensors ABI for a module split (so I can shunt all the
> hwmon code to a new module later, and userspace won't even notice).
> 
> Please merge this batch to acpi-test.  It replaces previous versions of
> "thinkpad-acpi changes for the merge window (part 1)".
> 
> As usual, the patch set is available at:
> git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test
> 
> Shortlog of the above branch:
> 
> Henrique de Moraes Holschuh (9):
>       ACPI: thinkpad-acpi: make room for more features in tp_features bitfield
>       ACPI: thinkpad-acpi: issue EV_SYNC after EV_SWITCH
>       ACPI: thinkpad-acpi: add mutex-based locking to input device event send path
>       ACPI: thinkpad-acpi: keep track of module state
>       ACPI: thinkpad-acpi: check version of hot key firmware
>       ACPI: thinkpad-acpi: dequeue all pending hot key events at once (v2.2)
>       ACPI: thinkpad-acpi: fix regression on HKEY LID event handling
>       ACPI: thinkpad-acpi: use a separate platform device for hwmon and name it
>       ACPI: thinkpad-acpi: duplicate driver attributes to new hwmon pdrv
> 
> Thanks.
> 
