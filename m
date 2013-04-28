From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [regression] suspend is flakey, "shutdown -h now" does not power
 off
Date: Sun, 28 Apr 2013 09:27:56 +0800
Message-ID: <517C7B1C.3000600@intel.com>
References: <4EC27F88.9070209@gmail.com> <20111116044358.GB5889@elie.hsd1.il.comcast.net> <4EC95C07.6030706@gmail.com> <517BE0C6.4070107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11073 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894Ab3D1B01 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 27 Apr 2013 21:26:27 -0400
In-Reply-To: <517BE0C6.4070107@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthieu Dubuget <matthieu.dubuget@gmail.com>
Cc: linux-acpi@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>

Filed a bug report for you here:
https://bugzilla.kernel.org/show_bug.cgi?id=57231

Thanks,
Aaron

On 04/27/2013 10:29 PM, Matthieu Dubuget wrote:
> Hello,
> 
> I have some shutdown problems with my notebook, and it seems to be an
> (old) regression, since it used to work.
> 
> (http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=648754#38)
> 
> I compared two acpidump outputs with a working and with a non working
> kernel: it appears that the only difference is that there is no RSDT
> table in the non working one.
> 
> Is it something expected, or could it be an explanation of my
> problems?
> 
> How could I solve this?
> 
> Thanks in advance for any advice.
> 
> Salutations
> 
> Matthieu Dubuget
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

