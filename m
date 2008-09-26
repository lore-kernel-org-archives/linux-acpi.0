From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Is rfkill class really appropriate for eeepc-laptop?
Date: Fri, 26 Sep 2008 14:49:53 +0100
Message-ID: <48DCE881.5000501@tuffmail.co.uk>
References: <20080918133144.GA4338@silver.sucs.org> <48D564A8.7030009@xandros.com> <20080921102246.GA27071@silver.sucs.org> <48D660C5.6070204@xandros.com> <48D69052.1040908@tuffmail.co.uk> <48D6AC5E.70502@xandros.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:35455 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815AbYIZNt7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Sep 2008 09:49:59 -0400
Received: by nf-out-0910.google.com with SMTP id d3so356115nfc.21
        for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2008 06:49:57 -0700 (PDT)
In-Reply-To: <48D6AC5E.70502@xandros.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Woody Suwalski <woodys@xandros.com>, Sitsofe Wheeler <sits@sucs.org>, acpi4asus-user@lists.sourceforge.net, linux-acpi <linux-acpi@vger.kernel.org>

Woody Suwalski wrote:
> Alan Jenkins wrote:
>> Woody Suwalski wrote:
>>
>>> > I have found one of the earliest source code snippets we have got
>>> from
>>> > Asus (eeepc_hotkey.tar.gz), and the current one we are using on new
>>> > models (P901 an later - hopefully back compatible?).
<>
>>> > And also - how far is now kernel eeepc support from this acpi
>>> module? 
<>
>> The main difference in eeepc-laptop is the shiny new interface.  The
>> files are created in /sys/bus/platform/devices/eeepc, instead of
>> /proc/acpi/asus.  It uses a recently added generic backlight interface
>> (/sys/class/backlight/eeepc) - so it's the same as all the other "laptop
>> extras" modules.  In 2.6.27 it will implements the new generic "rfkill"
>> interface for the wireless toggle.  Plus it will generate real input
>> events (as opposed to acpi events) for hotkeys.
<>
> About the rfkill switch - be careful.
> The current /proc/acpi/asus/wlan implementation is actually killing
> the power from wireless chip - as  a result we had to do a lot of
> hooplas with pciehp or fakephp to bring the chip up "pci-wise" after
> the sleep.

Hmm, so it does.  I guess that makes it unsuitable for a straight port
to the rfkill interface.

    The rfkill switch subsystem exists to add a generic interface to
    circuitry that
    can enable or disable the signal output of a wireless *transmitter*
    of any
    type.  By far, the most common use is to disable radio-frequency
    transmitters.

Both the pre-installed OS and the community scripts play these games; I
think you have to reload the pciehp module with a "force" parameter.

I was wrong to say that rfkill support was already in mainline.  But it
is introduced by Matthew's patch "eeepc-laptop: Use standard
interfaces", as posted and reviewed on the linux-acpi list.  I think
this is a bad idea.  Surely the whole point of rfkill is to let
NetworkManager do power management *without* having to do different
things for different laptops?

> Luckily the newest model (e.g. S101) is now using "normal" kill of the
> antenna, which is easy to work with.

Sounds good in theory.  Maybe not so good if it does something different
in response to the exact same acpi method :-(.

Alan
