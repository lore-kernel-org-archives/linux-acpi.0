From: "Michael J. Kidd" <mjkidd@linuxkidd.com>
Subject: ACPI not setting up I/O Memory mappings
Date: Tue, 04 Apr 2006 12:11:43 -0400
Message-ID: <44329ABF.8070907@linuxkidd.com>
References: <442EB141.5040205@linuxkidd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wsip-70-169-128-52.hr.hr.cox.net ([70.169.128.52]:56453 "HELO
	wsip-70-169-128-52.hr.hr.cox.net") by vger.kernel.org with SMTP
	id S1750732AbWDDQMi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Apr 2006 12:12:38 -0400
In-Reply-To: <442EB141.5040205@linuxkidd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

ACPI not setting up I/O Memory mappings for USB and PCMCIA controllers 
on Averatec C3500 Laptop..  Can anyone help with this?  Please...

Michael J. Kidd

> Hello all,
> I have an Averatec C3500 Convertible Tablet PC.  With the initial bios 
> version that ships with the unit, USB and PCMCIA both work fine in 
> linux.  However, there is a terrible keyboard lag and dropped keys.  
> The follow-on bios revisions fixed the keyboard issues, but caused USB 
> and PCMCIA to both stop working.  Note: All devices continue to 
> operate fine in Windows.  I'm posting this here in hopes that someone 
> will take interest in this issue ( there are several others trying to 
> use linux on these laptops. )  I've captured dmesg output after 
> enabling CONFIG_USB_DEBUG and CONFIG_PCMCIA_DEBUG in the kernel 
> config, and the output from lspci -vvxxx, as well as the DSDT output 
> from both the original BIOS ( USB working / Keyboard not ) and the 
> latest BIOS revision ( USB Not working / Keyboard works great ).
>
> The link for all this captured data is: 
> http://www.linuxkidd.com/c3500   I've detailed the machine hardware, 
> running kernel, etc.. as well as linked to all the above described 
> captures.
>
> After posting the above request to the linux-usb list, Alan Stern 
> responded with:
> ----------------------------------------------------------------------
> According to the log, the I/O memory mappings for the USB and PCMCIA
> controllers aren't getting set up. It's not a USB or PCMCIA issue at all;
> you should ask for help on the PCI and ACPI mailing lists.
> ----------------------------------------------------------------------
>
> So, here I am...
>
> If there's anything else I can provide to assist in troubleshooting,
> Please ask!  I'd really like to get this working.
>
> Thanks in advance for any help!
> Michael J. Kidd
>


