From: limp <johnkyr83@hotmail.com>
Subject: RE: Necessity of SMM/SMI use on ACPI x86 systems
Date: Mon, 4 Apr 2011 14:41:45 +0100
Message-ID: <SNT111-DS15AC3C0257159ED491332BA7A30@phx.gbl>
References: <SNT111-DS81E1BD67986CA3A41C144A7A00@phx.gbl> <20110403153436.GA30667@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from snt0-omc2-s38.snt0.hotmail.com ([65.55.90.113]:11871 "EHLO
	snt0-omc2-s38.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751288Ab1DDNls (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Apr 2011 09:41:48 -0400
In-Reply-To: <20110403153436.GA30667@srcf.ucam.org>
Content-Language: en-gb
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: 'Matthew Garrett' <mjg59@srcf.ucam.org>

Thanks for the reply Matthew,

> It's a turing-complete language with full access to the hardware, so 
> there's no reason why you can't entirely eliminate SMIs. The usual 
> reason not to would be to retain commonality of code for non-ACPI 
> environments like the setup screen.

So, there is no case that SMIs can be irreplaceable? For example, when you
go to S5 I know from coreboot developers that you need to disable bus
mastering on all devices or the machine will not power off. Since the OS
does not know this, and neither does acpi, the S5 sleep command will cause
an SMI that disables BM and then goes to S5.

Furthermore, is ACPI AML BIOS code interruptible or not? 
That is, what happens if an interrupt occurs during ACPI code execution? 
Will it be pended and get served after the completion of ACPI code
execution? 
Furthermore, can a SMI interrupt ACPI code or not? 

One last question is regarding the location in memory of ACPI tables. Are
they written to standard RAM or to a specially protected RAM similar to
SMRAM? How ACPI tables can prevent the OS from corrupting them?

Sorry for the large amount of questions raised ;)

Kind regards,

John K.






-----Original Message-----
From: Matthew Garrett [mailto:mjg59@srcf.ucam.org] 
Sent: Sunday, April 03, 2011 4:35 PM
To: limp
Cc: linux-acpi@vger.kernel.org
Subject: Re: Necessity of SMM/SMI use on ACPI x86 systems

On Sun, Apr 03, 2011 at 12:40:47PM +0100, limp wrote:

> Can anyone advise me if it's possible to write ACPI AML BIOS code that
does
> whatever it was intended to be executed in SMM? In general, is there any
> *strong* argument saying that (at least) current systems cannot completely
> eliminate the use of SMIs?

It's a turing-complete language with full access to the hardware, so 
there's no reason why you can't entirely eliminate SMIs. The usual 
reason not to would be to retain commonality of code for non-ACPI 
environments like the setup screen.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

