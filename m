From: John Sigler <linux.kernel@free.fr>
Subject: Re: halt does not shut the system down
Date: Tue, 16 Oct 2007 15:08:39 +0200
Message-ID: <4714B7D7.7090005@free.fr>
References: <470A58AF.9080402@free.fr> <470C9731.6030200@free.fr> <470F4535.3050004@free.fr> <470F4F58.4080900@gmail.com> <470F7264.8070205@free.fr> <471342C8.2030305@free.fr> <4714979C.5010103@free.fr> <Pine.LNX.4.61.0710160835160.11232@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:36070 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932141AbXJPNIm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Oct 2007 09:08:42 -0400
In-Reply-To: <Pine.LNX.4.61.0710160835160.11232@chaos.analogic.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dick Johnson <linux-os@analogic.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, robert.moore@intel.com, len.brown@intel.com

Dick Johnson wrote:

> John Sigler wrote:
> 
>> http://bugzilla.kernel.org/show_bug.cgi?id=9148
>>
>> Writing 15361 (i.e. 0x3C01) to ACPI_REGISTER_PM1A_CONTROL appears to
>> hang my system in acpi_os_write_port(). What can I do about that?
>>
>> Another observation: if I connect a screen to the system's VGA port,
>> when I call 'poweroff' the screen goes into power saving mode. This
>> seems to indicate that the integrated video card is properly shut down.
>>
>> So the fans keep spinning, the LEDs keep shining, the LCD keeps
>> displaying, but the video card is shut down?
>>
>> Might this help pinpoint the problem?
> 
> Check the BIOS to see if the "Power Button" is configured to
> shut the system down. Some BIOS configure APM to do what
> the power button does!

Here is the relevant BIOS menu.

         Phoenix - AwardBIOS CMOS Setup Utility
                 Power Management Setup
+=====================================================+
|    ACPI Function             [Enabled]              |
|    MODEM Use IRQ             [NA]                   |
|    Soft-Off by PWR-BTTN      [Instant-Off]          |
|    CPU THRM-Throttling       [50.0%]                |
|    Resume by Alarm           [Disabled]             |
|  x  Date(of Month) Alarm       0                    |
|  x  Time(hh:mm:ss) Alarm       0 :  0 :  0          |
|                                                     |
|    ** Reload Global Timer Events **                 |
|    Primary IDE 0             [Disabled]             |
|    Primary IDE 1             [Disabled]             |
|    Secondary IDE 0           [Disabled]             |
|    Secondary IDE 1           [Disabled]             |
|    FDD,COM,LPT Port          [Disabled]             |
|    PCI PIRQ[A-D]#            [Disabled]             |
|                                                     |
+=====================================================+

          +===================================+
          | Soft-Off by PWR-BTTN              |
          |-----------------------------------|
          | Instant-Off  ..... [v]            |
          | Delay 4 Sec. ..... [ ]            |
          |                                   |
          |-----------------------------------|
          |  ^V:Move ENTER:Accept ESC:Abort   |
          +===================================+

'Instant-Off' is the appropriate setting, right?

In a different menu, there are two other (relevant?) options:

     PWRON After PWR-Fail      [On]
     Watch Dog Timer Select    [Disabled]

Regards.
