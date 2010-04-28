From: Manuel =?UTF-8?B?QXJnw7xlbGxlcw==?= <manuel.arguelles@gmail.com>
Subject: powernow-k8: No compatible ACPI _PSS objects found. (Asrock N68-S)
Date: Tue, 27 Apr 2010 23:35:05 -0500
Message-ID: <hr8dum$ivs$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:47102 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060Ab0D1EuI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Apr 2010 00:50:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-acpi-devel@m.gmane.org>)
	id 1O6zDn-000334-8M
	for linux-acpi@vger.kernel.org; Wed, 28 Apr 2010 06:50:03 +0200
Received: from 190.218.24.110 ([190.218.24.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2010 06:50:03 +0200
Received: from manuel.arguelles by 190.218.24.110 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2010 06:50:03 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I just bought an AsRock N68-S motherboard with an AMD Phenom II 955 
processor and I'm getting this message.

Cool 'n Quiet option is enabled on the bios, I retrieved the DSDT (from 
/proc/acpi/dsdt) and decoded it with iasl -d, couldn't find anything about 
_PSS on it.

I emailed AsRock support but no answer, the bios version that I have is 2.0, 
it was released on December 25, 2009.

I have read that it is possible to modify the DSDT to support this, but I 
have no idea how to do that, I haven't found much information either.

What do you recommend me to do?, should I try to get more into DSDT? is 
adding _PSS to a DSDT an easy task?

I haven't test it on windows, do you think that may help? is there any 
useful information that I cat get about it on windows? does windows also 
interacts with the Cool 'n Quiet feature using the bios' DSDT or something 
else? Will it be possible that it works fine on windows but not on linux? On 
the download page there's a Cool'n'Quiet driver for windows. (Is there 
anything that can be done with that?)

I also tried to recompile the DSDT and got one error and 7 warnings, the 
error was:

DSDT.dsl  4832:  Return (Zero)
Error    4080 -  ^ Invalid object type for reserved name (found ZERO, 
requires Buffer)

Which I suppose has nothing to do with this.

Regards

