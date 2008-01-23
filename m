From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode of HP Pavilion tx 1000
Date: Wed, 23 Jan 2008 00:47:33 -0500
Message-ID: <200801230047.34100.lenb@kernel.org>
References: <1190315351.3790.8.camel@lebioda> <200801182307.47527.lenb@kernel.org> <a54231290801221324g5a83e199l28919e775726a074@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59896 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753076AbYAWFrr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Jan 2008 00:47:47 -0500
In-Reply-To: <a54231290801221324g5a83e199l28919e775726a074@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jakub Ambrozewicz <jakub.ambrozewicz@googlemail.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday 22 January 2008 16:24, Jakub Ambrozewicz wrote:
> 2008/1/19, Len Brown <lenb@kernel.org>:
> >
> > Thanks for the dmidecode output.
> 
> No problem. It's rather me who should thank for your work. So I do:
> Big Thanks. :)
> 
> > Do you notice any functional difference when booting with
> >
> > "acpi_osi=Linux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=!Linux"       (default for 2.6.23 and later)
> >
> > Also, please send me the output from acpidump.
> 
> I am really sorry that it took so long, but here they are.
> Hand made 2.6.23.14 (config attached). I have not noticed any
> differences  between using Linux and !Linux
> I still need to use nolapic because systems hangs on bootup while
> setting the system clock. I suspect it has something to do with
> interrupts, and tried irqpoll irqdebug acpi_irq_balance but it did not
> help a lot. Since then I haven't done much testing.
> One thing has changed since I last checked: the suspend to ram now
> works, but works both on "Linux" and "!Linux".
> 
> I am also attaching dmidecode again, as I have upgraded the bios to
> F.1C and I do not know if it changes anything.
> 

Thanks for the acpidump.
It shows that OSI(Linux) will have absolutely no effect
on the tx 1000 -- because the OSYS value that it effects
gets immediately over-written by the values associated
with Windows before it is accessed.

thanks,
-Len


                If (CondRefOf (\_OSI, Local0))
                {
                    If (\_OSI ("Linux"))
                    {
                        Store (0x03E8, OSYS)
                    }

                    If (\_OSI ("Windows 2001"))
                    {
                        Store (0x07D1, OSYS)
                    }
