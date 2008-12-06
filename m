From: Matthias Heinz <mheinz@cs.uni-frankfurt.de>
Subject: Re: samsung x360, acpi support
Date: Sat, 6 Dec 2008 18:28:28 +0100
Message-ID: <200812061828.29429.mheinz@cs.uni-frankfurt.de>
References: <200812041915.39971.mheinz@cs.uni-frankfurt.de> <200812061733.37471.mheinz@cs.uni-frankfurt.de> <20081206164247.GD7623@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.rbi.informatik.uni-frankfurt.de ([141.2.1.1]:44228 "EHLO
	hera.rbi.informatik.uni-frankfurt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751705AbYLFR2u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Dec 2008 12:28:50 -0500
In-Reply-To: <20081206164247.GD7623@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org

Am Samstag, 6. Dezember 2008 schrieb Matthew Garrett:
> Ok, that indicates that your system claims opregion support, which would
> explain the difference in behaviour since 2.6.26.

Which should be working, because its a GMA X4500... (if i understood 
correctly, what opregion is)


> And this indicates that there's a legacy backlight control event waiting
> to be handled, but no interrupt appears to have been raised. Does
> hitting the brightness key result in "Interrupts received" changing?

The brightness key(s) just send a keycode:
e.g.
atkbd.c: Unknown key pressed (translated set 2, code 0x83 on isa0060/serio0).
atkbd.c: Use 'setkeycodes e003 <keycode>' to make it known.
