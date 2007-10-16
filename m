From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Subject: Re: halt does not shut the system down
Date: Tue, 16 Oct 2007 08:37:12 -0400
Message-ID: <Pine.LNX.4.61.0710160835160.11232@chaos.analogic.com>
References: <470A58AF.9080402@free.fr> <470C9731.6030200@free.fr> <470F4535.3050004@free.fr> <470F4F58.4080900@gmail.com> <470F7264.8070205@free.fr> <471342C8.2030305@free.fr> <4714979C.5010103@free.fr>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764783AbXJPMh3@vger.kernel.org>
Content-class: urn:content-classes:message
In-reply-to: <4714979C.5010103@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, robert.moore@intel.com, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org


On Tue, 16 Oct 2007, John Sigler wrote:

> John Sigler wrote:
>
>> Alexey Starikovskiy wrote:
>>
>>> Could you please open bug at bugzilla.kernel.org and put all these
>>> files there?
>>
>> http://bugzilla.kernel.org/show_bug.cgi?id=9148
>>
>> Writing 15361 (i.e. 0x3C01) to ACPI_REGISTER_PM1A_CONTROL appears to
>> hang my system in acpi_os_write_port(). What can I do about that?
>
> Another observation: if I connect a screen to the system's VGA port,
> when I call 'poweroff' the screen goes into power saving mode. This
> seems to indicate that the integrated video card is properly shut down.
>
> So the fans keep spinning, the LEDs keep shining, the LCD keeps
> displaying, but the video card is shut down?
>
> Might this help pinpoint the problem?
>
> Regards.
> -

Check the BIOS to see if the "Power Button" is configured to
shut the system down. Some BIOS configure APM to do what
the power button does!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.59 BogoMips).
My book : http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
