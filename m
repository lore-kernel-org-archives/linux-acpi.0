From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: kacpid and acpid
Date: Sun, 04 May 2008 16:57:31 +0800
Message-ID: <1209891451.28197.11.camel@yakui_zhao.sh.intel.com>
References: <fv9tlv$2v0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36479 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755788AbYEDBGX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 3 May 2008 21:06:23 -0400
In-Reply-To: <fv9tlv$2v0$1@ger.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Markus Feldmann <feldmann_markus@gmx.de>
Cc: linux-acpi@vger.kernel.org

On Wed, 2008-04-30 at 15:54 +0200, Markus Feldmann wrote:
> Hi All,
> 
> my Problem is that i can not install "acpid" and "acpi-support" 
> correctly, because another Process "kacpid" have got Access to
> /proc/acpi/event
Can you double check whether the /proc/acpi/event is accessed by
"kapcid"? (Please use the command "lsof /proc/acpi/event" to get the
process id).Kacpid is a kernel thread and /proc/acpi/event is the user
interface. 
> My System:
>   Debian Lenny 32bit with Kernel 2.6.25 from kernel.org
>   AMD Turion64 X2 Mobile
> 
> acpid is used for my Laptop to get my Buttons for Wireless and Sound
> Volume to work, as i think.
> 
> I do not know anything about "kacpid", but i think this is a Kernel
> Process.
> 
> Any Idea ?
> 
> Regards Markus
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

