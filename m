From: Eric Valette <eric.valette-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH] Linux 2.6-pre-mm2 Fix crash on boot on ASUS L3800C if
 enabing APIC => add this machine to DMI black list
Date: Mon, 21 Jul 2003 10:07:19 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <3F1B9F37.509@free.fr>
References: <200307210114.h6L1El7M018996@harpo.it.uu.se>
Reply-To: eric.valette-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200307210114.h6L1El7M018996-gq7oiAaKCbRt3AgVzhmPzw@public.gmane.org>
To: Mikael Pettersson <mikpe-gJWeRRR3xd2zQB+pC5nmwQ@public.gmane.org>
Cc: akpm-3NddpPZAyC0@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Mikael Pettersson wrote:

> While I don't dispute your machine has some problem, please
> do the following first before we completely blacklist it:
> - ensure you have the latest BIOS (ftp.asuscom.de has the ones for
>   their desktop mainboards, presumably the laptop BIOSen are also there)

Have the latest BIOS from 3 June...

> - in what way is ACPI mandatory? does it fail to boot, or does it
>   just lose some specific feature? If you just want suspend support,
>   try APM if the machine has it

Many ACPI managed buttons, Fans, ...

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette-GANU6spQydw@public.gmane.org
