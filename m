From: "Daniel Smertnig" <daniel.smertnig@gmail.com>
Subject: C4 state missing on T60p (Intel Core Duo)
Date: Wed, 9 Aug 2006 19:29:58 +0200
Message-ID: <18dd01ff0608091029n4777966qc9588cf262db432e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:21719 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751275AbWHIR37 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Aug 2006 13:29:59 -0400
Received: by ug-out-1314.google.com with SMTP id m3so193533ugc
        for <linux-acpi@vger.kernel.org>; Wed, 09 Aug 2006 10:29:58 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I have recently noticed that my Thinkpad T60p doesn't expose a C4
state via ACPI, even when on battery, but instead shows a different
latency for C3:

AC:
daniel-mobile% cat /proc/acpi/processor/*/power
active state:            C2
max_cstate:              C8
bus master activity:     000c0000
states:
    C1:                  type[C1] promotion[C2] demotion[--]
latency[000] usage[00000010]
   *C2:                  type[C2] promotion[C3] demotion[C1]
latency[001] usage[04378697]
    C3:                  type[C3] promotion[--] demotion[C2]
latency[017] usage[02945663]
active state:            C3
max_cstate:              C8
bus master activity:     00000000
states:
    C1:                  type[C1] promotion[C2] demotion[--]
latency[000] usage[00000010]
    C2:                  type[C2] promotion[C3] demotion[C1]
latency[001] usage[04745508]
   *C3:                  type[C3] promotion[--] demotion[C2]
latency[017] usage[05832946]

battery:
daniel-mobile% cat /proc/acpi/processor/*/power
active state:            C2
max_cstate:              C8
bus master activity:     ffffff40
states:
    C1:                  type[C1] promotion[C2] demotion[--]
latency[000] usage[00000010]
   *C2:                  type[C2] promotion[C3] demotion[C1]
latency[001] usage[00000119]
    C3:                  type[C3] promotion[--] demotion[C2]
latency[057] usage[00000000]
active state:            C2
max_cstate:              C8
bus master activity:     ffffffec
states:
    C1:                  type[C1] promotion[C2] demotion[--]
latency[000] usage[00000010]
   *C2:                  type[C2] promotion[C3] demotion[C1]
latency[001] usage[00000158]
    C3:                  type[C3] promotion[--] demotion[C2]
latency[057] usage[00000000]


I've tracked this down to the ACPI which does not ever seem to return
a package for the C4-state from the _CST method [*].

I'm now wondering whether the C4 state will ever be used, i.e. will
the CPU/BIOS promote to it by itself from C3 or does Linux need to
actually know about C4 (and deep C4, I assume on the Intel Core
processors) to make use of it. What's strange is, that older models
seem to expose C4 as I've found out while browsing some DSDTs on
acpi.sf.net.

I would be very grateful to get clarification about this.

Thanks,
Daniel

[*] The relevant SSDT containing the _CST method is loaded by ACPI
code from a magic address with a Load() statement.

Schematically it looks something like this, note that the relevant
"CST4" definition only contains three packages:

Scope(\_PR.CPU0)
{
   Name (CST1, ...)
   {
       Package (...) {...}
   }
   Name (CST2, ...)
   {
       Package (...)  {...},
       Package (...)  {...}
   }
   Name (CST3, ...)
   {
       Package (...)  {...},
       Package (...)  {...},
       Package (...)  {...} // latency 17
   }
   Name (CST4, ...)
   {
       Package (...)  {...},
       Package (...)  {...},
       Package (...)  {...} // latency 57
   }

   Method(_CST,...)
   {
      if (\C2NA) { return CST1 }
      if (\C3NA) { return CST2 }
      if (\C4NA) { return CST3 }
      return CST4
   }
}
