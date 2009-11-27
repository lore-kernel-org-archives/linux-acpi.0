From: andrej.gelenberg-KJIyc1CJxjQ@public.gmane.org
Subject: Re: eeepc-laptop: bugreport
Date: Fri, 27 Nov 2009 21:26:23 +0100
Message-ID: <cone.1259353583.101492.2926.1000@eeekiste>
References: <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com>
	<cone.1258211472.464906.1633.1000@eeekiste>
	<71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com>
	<cone.1258312767.545625.1812.1000@eeekiste>
	<71cd59b00911260703r284b5bfdn3144de4db74b7c3a@mail.gmail.com>
	<cone.1259253925.112628.13921.1000@eeekiste>
	<20091126164856.GA19208@srcf.ucam.org>
	<cone.1259320879.557715.3035.1000@eeekiste>
	<4B0FB7B9.9040902@tuffmail.co.uk>
	<cone.1259324857.296100.3035.1000@eeekiste>
	<20091127172522.GA5422@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: linux acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>, Corentin Chary <corentin.chary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,


from Documentation/rfkill.txt:

  1. Introduction

  The rfkill subsystem provides a generic interface to disabling any radio
  transmitter in the system. When a transmitter is blocked, it shall not
  radiate any power.

  The subsystem also provides the ability to react on button presses and
  disable all transmitters of a certain type (or all). This is intended for
  situations where transmitters need to be turned off, for example on
  aircraft.

  The rfkill subsystem has a concept of "hard" and "soft" block, which
  differ little in their meaning (block == transmitters off) but rather in
  whether they can be changed or not:
   - hard block: read-only radio block that cannot be overriden by software
   - soft block: writable radio block (need not be readable) that is set by
                 the system software.

The eepc-latop-rfkill should be hard block. If the LED is not on,
my wlan-card won't transmit. The eeepc-laptop is only driver
which use hotplug-subsystem to hide the hardware.
It work only until next pci-rescan.
Firmware must not tell you, where the wlan-card is,
it should only provide hard-rfkill (on 1005ha it does).
Or the wlan-driver should provide proper rfkill
(at least soft block).
The hardcoded bus and slot it not proper solution.

For example in miniPCI-pinout pin 13 is "RF Silent input",
also the firmware shuld only set the pin.
http://www.interfacebus.com/MiniPCI_Pinout_124Pin.html

Matthew Garrett writes:

> That's because the eee firmware gives us no control over which device is 
> unplugged. I think you're missing the point of how the eee rfkill code 
> works - we don't unplug any devices, the firmware does that. We then 
> need to tell Linux that the PCI device has vanished in order to prevent 
> drivers from attempting to use a piece of hardware that's no longer 
> accessible.

eeepc firmware does not unplug device, it set only a rfkill-pin,
so the wlan-card know, that it should not transmit any more.

> 
> -- 
> Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org


Regards,
Andrej

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
