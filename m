From: Jos Hulzink <josh-bQi0YA1h5vk@public.gmane.org>
Subject: Re: Vaio doesn't poweroff with 2.4.22
Date: Sun, 21 Sep 2003 16:50:18 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200309211650.18881.josh@stack.nl>
References: <Pine.GSO.4.21.0309191053140.4488-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.GSO.4.21.0309191053140.4488-100000-Q9iLAqk50tFNk+PO8Cj175kigfUh6rMo@public.gmane.org>
Content-Disposition: inline
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Roger Luethi <rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Development <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday 20 Sep 2003 15:17, Geert Uytterhoeven wrote:
> If I turn off CONFIG_X86_UP_APIC I get:
> | ACPI disabled because your bios is from 00 and too old
> | You can enable it with acpi=force
> | Sony Vaio laptop detected.
>
> and ACPI is disabled. Halt doesn't work.
>
> If I then pass `acpi=force' to explicitly enable ACPI, `halt' works again
> and powers off the machine, but `reboot' causes a black screen with IDE
> disk spun down, but no restart.
>
> Gr{oetje,eeting}s,

My PIII 650 with 2000 BIOS boots linux with acpi disabled for the same reason, 
unless force ACPI support. It reboots fine with ACPI forced. The ACPI support 
of this Intel BX mobo is good, so this is a false negative IMHO. (I wonder if 
the check is correct, shouldn't it say 2000 instead of 00 ?)

Jos
