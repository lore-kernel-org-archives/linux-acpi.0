From: John Sigler <linux.kernel@free.fr>
Subject: Re: halt does not shut the system down
Date: Mon, 15 Oct 2007 12:36:56 +0200
Message-ID: <471342C8.2030305@free.fr>
References: <470A58AF.9080402@free.fr> <470C9731.6030200@free.fr> <470F4535.3050004@free.fr> <470F4F58.4080900@gmail.com> <470F7264.8070205@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:52615 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753761AbXJOKg5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Oct 2007 06:36:57 -0400
In-Reply-To: <470F7264.8070205@free.fr>
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

Writing 15361 (i.e. 0x3C01) to ACPI_REGISTER_PM1A_CONTROL appears to 
hang my system in acpi_os_write_port(). What can I do about that?

Is it a BIOS issue? a kernel issue? a hardware issue?

(All my results are attached to the bug report.)

Regards.
