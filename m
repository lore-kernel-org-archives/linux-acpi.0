From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: CPU temperature not detected
Date: Fri, 20 Jun 2008 10:17:21 +0800
Message-ID: <1213928241.3001.25.camel@rzhang-dt.sh.intel.com>
References: <BAY114-W5056724B82302477B1226BFAA80@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65454 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbYFTCQc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jun 2008 22:16:32 -0400
In-Reply-To: <BAY114-W5056724B82302477B1226BFAA80@phx.gbl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luke Sharkey <lukesharkey@hotmail.co.uk>
Cc: linux-acpi@vger.kernel.org


On Tue, 2008-06-17 at 23:30 +0100, Luke Sharkey wrote:
> Hi
> 
> I previously posted a question about my laptop overheating, but have since decided that it was too complex, and half of it probably belonged in the linux-laptopsmailing list.  I have therefore rephrased the question, and would be obliged if someone could help me?
> 
> I have an acpidump output, but it's all greek to me.  Could anyone interpret it for me?
> 
>  I would like to know why /proc/acpi/thermal_zone/THRM/temperature contains a reading of 0 C -
The temperature is gotten from somewhere in ec address space.
And now it seems that the value returned is totally wrong.
In order to see if EC is working correctly,
will you please attach the full dmesg output after boot?


> 1)   Firstly, does my cpu even have a sensor? (I have _only_ the on-die temperature, which is very hot).


> 2)    Secondly, can anyone shed some light on why /proc/acpi/fan is an empty directory?
this means that no ACPI Fan device available on your laptop, i.e. we can
not control the fan via ACPI, if there is any.
will you please check if there is any new BIOS released?
A BIOS upgrade would be helpful.


thanks,
rui

> 
> Thank you!!!
> (my specs:  hp pavilion dv5000 series with AMD turion 64 bit processor ML-32.  Any other details I don't know to provide, please just say.  Thanks)
> 
> _________________________________________________________________
> Great deals on almost anything at eBay.co.uk. Search, bid, find and win on eBay today!
> http://clk.atdmt.com/UKM/go/msnnkmgl0010000004ukm/direct/01/

