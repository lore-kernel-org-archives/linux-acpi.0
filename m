From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Help with Averatec C3500
Date: Tue, 4 Apr 2006 13:26:45 -0600
Message-ID: <200604041326.45510.bjorn.helgaas@hp.com>
References: <442EB141.5040205@linuxkidd.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:23256 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750825AbWDDT0u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Apr 2006 15:26:50 -0400
In-Reply-To: <442EB141.5040205@linuxkidd.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Michael J. Kidd" <mjkidd@linuxkidd.com>
Cc: linux-acpi@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>

On Saturday 01 April 2006 09:58, Michael J. Kidd wrote:
>  I have an Averatec C3500 Convertible Tablet PC.  With the initial bios 
> version that ships with the unit, USB and PCMCIA both work fine in 
> linux.  However, there is a terrible keyboard lag and dropped keys.  The 
> follow-on bios revisions fixed the keyboard issues, but caused USB and 
> PCMCIA to both stop working.  Note: All devices continue to operate fine 
> in Windows.  I'm posting this here in hopes that someone will take 
> interest in this issue ( there are several others trying to use linux on 
> these laptops. )  I've captured dmesg output after enabling 
> CONFIG_USB_DEBUG and CONFIG_PCMCIA_DEBUG in the kernel config, and the 
> output from lspci -vvxxx, as well as the DSDT output from both the 
> original BIOS ( USB working / Keyboard not ) and the latest BIOS 
> revision ( USB Not working / Keyboard works great ).
> 
> The link for all this captured data is: http://www.linuxkidd.com/c3500   
> I've detailed the machine hardware, running kernel, etc.. as well as 
> linked to all the above described captures.

Thanks for your effort in debugging this.  Can you please open a
bug report at http://bugzilla.kernel.org?

> After posting the above request to the linux-usb list, Alan Stern 
> responded with:
> ----------------------------------------------------------------------
> According to the log, the I/O memory mappings for the USB and PCMCIA
> controllers aren't getting set up. It's not a USB or PCMCIA issue at all;
> you should ask for help on the PCI and ACPI mailing lists.

I don't know enough about USB to know what you're referring to.
Can you point out the messages that suggest a PCI or ACPI issue?

Bjorn
