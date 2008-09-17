From: "Corentin Chary" <corentin.chary@gmail.com>
Subject: Re: Toggling VGA out on Eee 901
Date: Wed, 17 Sep 2008 21:47:24 +0200
Message-ID: <71cd59b00809171247y74ae25b6h580fcf024f7d4575@mail.gmail.com>
References: <71cd59b00809170813hba237e8y2bb3b4b2e7604d04@mail.gmail.com>
	 <1221679864736@dmwebmail.dmwebmail.chezphil.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:47212 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbYIQTr1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Sep 2008 15:47:27 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1853605nfc.21
        for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2008 12:47:25 -0700 (PDT)
In-Reply-To: <1221679864736@dmwebmail.dmwebmail.chezphil.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Phil Endecott <phil_hmpau_endecott@chezphil.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>

On Wed, Sep 17, 2008 at 9:31 PM, Phil Endecott
<phil_hmpau_endecott@chezphil.org> wrote:
> Corentin Chary wrote:
>>
>> you can try the "disp" file under /sys/device/platform/eeepc-laptop/
>> Try echo 1, echo 0, etc ... It may do something
>
> Thanks for the suggestion.  It doesn't work, though I think it's trying to
> do something.  The code for the "disp" file checks a capabilities bitmask in
> which I think the DISPLAYSWITCH bit is set, and writes call a method called
> SDSP, which eventually seems to do an I/O byte write (I think).  I'm well
> out of my depth here so I'm going to move on to the next problem, but I'm
> willing to try out any suggestions that people have.
>
> Cheers,  Phil

It may be like http://acpi4asus.sourceforge.net/README
 4.1.1 Display switching

  Note: the display switching code is currently considered EXPERIMENTAL.

  Switching works for the following models:
    L3800C
    A2500H
    L5800C
    M5200N
    W1000N (albeit with some glitches)
    M6700R
    A6JC
    F3J

  Switching doesn't work for the following:
    M3700N
    L2X00D (locks the laptop under certain conditions)

  To switch the displays, echo values from 0 to 15 to
  /sys/devices/platform/asus-laptop/display. The significance of those values
  is as follows:

  +-------+-----+-----+-----+-----+-----+
  | Bin   | Val | DVI | TV  | CRT | LCD |
  +-------+-----+-----+-----+-----+-----+
  + 0000  +   0 +     +     +     +     +
  +-------+-----+-----+-----+-----+-----+
  + 0001  +   1 +     +     +     +  X  +
  +-------+-----+-----+-----+-----+-----+
  + 0010  +   2 +     +     +  X  +     +
  +-------+-----+-----+-----+-----+-----+
  + 0011  +   3 +     +     +  X  +  X  +
  +-------+-----+-----+-----+-----+-----+
  + 0100  +   4 +     +  X  +     +     +
  +-------+-----+-----+-----+-----+-----+
  + 0101  +   5 +     +  X  +     + X   +
  +-------+-----+-----+-----+-----+-----+
  + 0110  +   6 +     +  X  +  X  +     +
  +-------+-----+-----+-----+-----+-----+
  + 0111  +   7 +     +  X  +  X  +  X  +
  +-------+-----+-----+-----+-----+-----+
  + 1000  +   8 +  X  +     +     +     +
  +-------+-----+-----+-----+-----+-----+
  + 1001  +   9 +  X  +     +     +  X  +
  +-------+-----+-----+-----+-----+-----+
  + 1010  +  10 +  X  +     +  X  +     +
  +-------+-----+-----+-----+-----+-----+
  + 1011  +  11 +  X  +     +  X  +  X  +
  +-------+-----+-----+-----+-----+-----+
  + 1100  +  12 +  X  +  X  +     +     +
  +-------+-----+-----+-----+-----+-----+
  + 1101  +  13 +  X  +  X  +     +  X  +
  +-------+-----+-----+-----+-----+-----+
  + 1110  +  14 +  X  +  X  +  X  +     +
  +-------+-----+-----+-----+-----+-----+
  + 1111  +  15 +  X  +  X  +  X  +  X  +
  +-------+-----+-----+-----+-----+-----+

  In most cases, the appropriate displays must be plugged in for the above
  combinations to work. TV-Out may need to be initialized at boot time.

  Debugging:
  1) Check whether the Fn+F8 key:
     a) does not lock the laptop (try disabling CONFIG_X86_UP_APIC or boot with
        noapic / nolapic if it does)
     b) generates events (0x6n, where n is the value corresponding to the
        configuration above)
     c) actually works
     Record the disp value at every configuration.
  2) Echo values from 0 to 15 to /sys/devices/platform/asus-laptop/display.
     Record its value, note any change. If nothing changes, try a broader range,
     up to 65535.
  3) Send ANY output (both positive and negative reports are needed, unless your
     machine is already listed above) to the acpi4asus-user mailing list.

  Note: on some machines (e.g. L3C), after the module has been loaded, only 0x6n
  events are generated and no actual switching occurs. In such a case, a line
  like:

    echo $((10#$arg-60)) > /sys/devices/platform/asus-laptop/display

  will usually do the trick ($arg is the 0000006n-like event passed to acpid).

  Note: there is currently no reliable way to read display status on xxN
  (Centrino) models.
