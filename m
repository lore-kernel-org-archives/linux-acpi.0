From: Len Brown <lenb@kernel.org>
Subject: Re: Revert "ACPICA: Remove obsolete acpi_os_validate_address interface"
Date: Tue, 11 Aug 2009 23:43:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908112331250.8449@localhost.localdomain>
References: <alpine.LFD.2.00.0908021306270.3293@sony-vgn-z540>
 <20090803074620.GA2285@phenom2.trippelsdorf.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_dG9pxZbNjwOXezgnvsj4tA)"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755811AbZHLDoE@vger.kernel.org>
In-reply-to: <20090803074620.GA2285@phenom2.trippelsdorf.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org
List-Id: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_dG9pxZbNjwOXezgnvsj4tA)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

(cc: lm-sensors)

> >     Revert "ACPICA: Remove obsolete acpi_os_validate_address interface"
> >     
> >     This reverts commit f9ca058430333c9a24c5ca926aa445125f88df18.
> >     
> >     which caused a regression:
> >     
> >     http://bugzilla.kernel.org/show_bug.cgi?id=13620
> >     
> 
> This revert breaks it8720 hardware monitoring on my machine:
> 
> ACPI: I/O resource it87 [0x295-0x296] conflicts with ACPI region ECRE [0x290-0x2af]
> ACPI: Device needs an ACPI driver

Thanks for the report, but I don't have a simple answer for you.

The mechanism that is restored to 2.6.29 behaviour here
is intended to address an extremely severe bug in Linux
where native sensor drivers access the same registers
as AML, causing fun things like change of temperature units and
spurious critical thermal shutdowns.
The commit that we reverted here was an oversight in 2.6.30,
and so the current plan is to revert that commit in 2.6.30.stable too.

The mechanism prevents the sensor driver from loading when
such a potential conflict is detected.

If you can attach the output of acpidump from your machine
to a new bugzilla entry, we can verify that the mechanism
is indeed not mistaken on your box.

thanks,
Len Brown, Intel Open Source Technology Center

> Reverting the revert solves the problem:
> 
> markus@phenom2 ~ % sensors
> it8720-isa-0290
> Adapter: ISA adapter
> in0:         +0.00 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
> in1:         +1.65 V  (min =  +0.00 V, max =  +4.08 V)
> in2:         +1.14 V  (min =  +0.00 V, max =  +4.08 V)
> in3:         +3.09 V  (min =  +0.00 V, max =  +4.08 V)
> in4:         +4.08 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
> in5:         +4.08 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
> in6:         +4.08 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
> in7:         +4.08 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
> in8:         +3.41 V
> fan1:       1175 RPM  (min =    0 RPM)
> fan2:       1175 RPM  (min =    0 RPM)
> fan3:        859 RPM  (min =    0 RPM)
> temp1:       +37.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor = thermistor
> temp2:       +41.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor = thermistor
> temp3:      -128.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor = disabled
> cpu0_vid:   +1.550 V
> 
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:       +37.8°C
> 
> dmesg and .config is attached.
> 
> -- 
> Markus
> 

--Boundary_(ID_dG9pxZbNjwOXezgnvsj4tA)--
