From: Manuel =?UTF-8?B?QXJnw7xlbGxlcw==?= <manuel.arguelles@gmail.com>
Subject: Re: powernow-k8: No compatible ACPI _PSS objects found. (Asrock N68-S)
Date: Wed, 28 Apr 2010 00:30:32 -0500
Message-ID: <hr8h5q$qt7$1@dough.gmane.org>
References: <hr8dum$ivs$1@dough.gmane.org> <4BD7C0FF.5030302@erley.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:47052 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751852Ab0D1Fao (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Apr 2010 01:30:44 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-acpi-devel@m.gmane.org>)
	id 1O6zr9-0007t5-Hh
	for linux-acpi@vger.kernel.org; Wed, 28 Apr 2010 07:30:43 +0200
Received: from cpe-000db902aab0.cpe.cableonda.net ([190.218.24.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2010 07:30:43 +0200
Received: from manuel.arguelles by cpe-000db902aab0.cpe.cableonda.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2010 07:30:43 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Pat Erley wrote:
> 
> I recently did something similar: http://pat.erley.org/Other/P4EISTSSDT
> 
> It wasn't 'too hard', but it was by no means easy... the _PSS values were
> kinda voodoo for me to come up with, and I'm not sure that I have them
> correct, just that they work.
> 
> Pat

Thanks a lot!! I took a look at my ssdt and it doesn't even looks complete:

DefinitionBlock ("SSDT.aml", "SSDT", 1, "A M I ", "POWERNOW", 0x00000001)
{

No idea how to get the values for my CPU, maybe contacting AMD?

One question, if I do something really really stupid, is it possible to fry 
the CPU? what can be the worst case scenario? 

Regards

