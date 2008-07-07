From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Curious ACPI thermal_zone handling.
Date: Mon, 07 Jul 2008 18:11:44 +0800
Message-ID: <1215425504.18507.21.camel@yakui_zhao.sh.intel.com>
References: <4871E06E.80209@rol.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49166 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934AbYGGKBB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2008 06:01:01 -0400
In-Reply-To: <4871E06E.80209@rol.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kirill Berezin <kyb22@rol.ru>
Cc: linux-acpi@vger.kernel.org

On Mon, 2008-07-07 at 13:22 +0400, Kirill Berezin wrote:
> Hi!
> 
> Linux ACPI system exhibits a vary curious behavior  on my 
> Fujitsu-Siemens  pa1538 laptop. After an initial boot my laptop runs 
> with slowly rotating fan. Fan continues rotating during the linux boot, 
> gnome start and stops only when the temperature reaches active_trip 
> point and fells below passive_trip. IMHO it is a little bit strange to 
> hear rotating fan for a  core temperature less then 40 Celsius degrees.
> 
> google shows a lot of links, but I still cannot get what part of a 
> system is responsible for fan start/stop -- hardware, kernel of some 
> application?
> 
> And my second question is what is the preferable way to set trip points 
> for current kernels?
> 
> I appreciate any help.
Will you please attach the output of acpidump,dmesg?
Of course you can open a new bug in bugzilla and attach the output of
dmesg, acpidump.

http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

Thanks.
> 
> Kirill.
> 
> 

