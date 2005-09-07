From: "Brown, Len" <len.brown@intel.com>
Subject: battery status events (RE: Kernel 2.6.13 repeated ACPI events?)
Date: Wed, 7 Sep 2005 16:10:07 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30048646E9@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751294AbVIGUK0@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Jan De Luyck <lkml@kcore.org>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>, "Yu, Luming" <luming.yu@intel.com>
List-Id: linux-acpi@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jan De Luyck
>Sent: Monday, September 05, 2005 9:17 AM
>To: linux-kernel@vger.kernel.org
>Subject: Re: Kernel 2.6.13 repeated ACPI events?
>
>I'm seeing repeated ACPI events too, but of the battery kind:
>
>[Mon Sep  5 15:13:52 2005] received event "battery BAT2 
>00000080 00000001"
>[Mon Sep  5 15:13:52 2005] completed event "battery BAT2 
>00000080 00000001"
>[Mon Sep  5 15:14:53 2005] received event "battery BAT1 
>00000080 00000001"
>[Mon Sep  5 15:14:53 2005] completed event "battery BAT1 
>00000080 00000001"
>[Mon Sep  5 15:14:53 2005] received event "battery BAT2 
>00000080 00000001"
>[Mon Sep  5 15:14:53 2005] completed event "battery BAT2 
>00000080 00000001"
>[Mon Sep  5 15:15:55 2005] received event "battery BAT1 
>00000080 00000001"
>[Mon Sep  5 15:15:55 2005] completed event "battery BAT1 
>00000080 00000001"
>[Mon Sep  5 15:15:55 2005] received event "battery BAT2 
>00000080 00000001"
>[Mon Sep  5 15:15:55 2005] completed event "battery BAT2 
>00000080 00000001"
>
>going on forever and ever...
>
>Jan

The kernel doesn't created these messages -- presumably
they're from acpid or some other user-level daemon
that is monitoring /proc/acpi/event.  Unlikely that
logging these events is necessary...

Event 0x80 on the battery device is a "Battery Status Changed"
which you'd expect to see when plugging/charging/discharging
a battery.  How frequent they are depends on the rate,
the battery and the firmware that is talking to it.

Is there a GUI or something reading the battery status files?
Do these events stop when running in text mode?

Did this not happen on this box with earlier kernels?

Do the /proc/acpi/battery* files look sane --
is the status really changing?

thanks,
-Len
