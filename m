From: Lorenzo Colitti <lorenzo@colitti.com>
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
Date: Tue, 15 Feb 2005 17:07:55 +0100
Message-ID: <42121E5B.2010503@colitti.com>
References: <20050214211105.GA12808@elf.ucw.cz> <200502150605.11683.s0348365@sms.ed.ac.uk> <4211E729.1090305@colitti.com> <200502151317.15633.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502151317.15633.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: s0348365@sms.ed.ac.uk
Cc: Pavel Machek <pavel@suse.cz>, ACPI mailing list <acpi-devel@lists.sourceforge.net>, kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

Alistair John Strachan wrote:
>>.config attached.
> 
> As recommended elsewhere in this thread, I'm not using any sort of framebuffer 
> driver, but vesafb IS compiled in (but no vga= option is present). Does it 
> need to be compiled out completely?

I don't remember, maybe you can deduce it from the .config I sent?

> I have acpi_sleep=s3_bios on cmdline. I am not using swsusp2 (and I can't see 
> how this is at all related to software suspend).

It works with or without swsusp2.

> Perhaps it is the machine BIOS. Which version do you have?

I think it's vF.0F from July 2004.


Cheers,
Lorenzo
