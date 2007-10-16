From: John Sigler <linux.kernel@free.fr>
Subject: Re: halt does not shut the system down
Date: Tue, 16 Oct 2007 12:51:08 +0200
Message-ID: <4714979C.5010103@free.fr>
References: <470A58AF.9080402@free.fr> <470C9731.6030200@free.fr> <470F4535.3050004@free.fr> <470F4F58.4080900@gmail.com> <470F7264.8070205@free.fr> <471342C8.2030305@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:55087 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755190AbXJPKvK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Oct 2007 06:51:10 -0400
In-Reply-To: <471342C8.2030305@free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, robert.moore@intel.com, len.brown@intel.com

John Sigler wrote:

> Alexey Starikovskiy wrote:
>
>> Could you please open bug at bugzilla.kernel.org and put all these
>> files there?
>
> http://bugzilla.kernel.org/show_bug.cgi?id=9148
> 
> Writing 15361 (i.e. 0x3C01) to ACPI_REGISTER_PM1A_CONTROL appears to
> hang my system in acpi_os_write_port(). What can I do about that?

Another observation: if I connect a screen to the system's VGA port, 
when I call 'poweroff' the screen goes into power saving mode. This 
seems to indicate that the integrated video card is properly shut down.

So the fans keep spinning, the LEDs keep shining, the LCD keeps 
displaying, but the video card is shut down?

Might this help pinpoint the problem?

Regards.
