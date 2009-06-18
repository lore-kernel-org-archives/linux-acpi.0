From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Acpi questions relating wrong battery indications
Date: Thu, 18 Jun 2009 10:09:01 +0800
Message-ID: <1245290941.9076.103.camel@rzhang-dt>
References: <4A38DC8F.2000803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:2898 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754419AbZFRCIR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Jun 2009 22:08:17 -0400
In-Reply-To: <4A38DC8F.2000803@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Patrick Voegeli Olivera <patrick.voegeli@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

please file a new bug report at
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach the acpidump output there.

thanks,
rui

On Wed, 2009-06-17 at 20:07 +0800, Patrick Voegeli Olivera wrote:
> Hi there,
> 
> My laptop is having an odd problem, which happens under every linux 
> distribution I've tried: the battery state doesn't work as you'd expect.
> 
> While charging it, acpi -V correctly shows AC adapter on-line and 
> battery state "Charging", fine here. The problem appears once it has 
> fully charged: acpi -V will report AC adapter on-line and battery state 
> "Discharging - something about at zero rate, will never fully 
> discharge". Once I unplug the laptop from the AC source, the battery 
> state will change to "Charged" and the AC adapter to offline.
> 
> So, to sumarize, it has the charged and discharging states changed. The 
> AC adapter always reports properly wether plugged in or not.
> 
> I've looked into the acpi specs and have managed to track down where the 
> battery changes its charging and discharging bit in my dsdt, but 
> changing that ones only gave my discharging and charging mixed up. So 
> then acpi -V would report discharging while the battery whas charging. 
> Once it was fully charged it turned to charging and running from battery 
> went to charged.
> 
> I don't see anything in the ACPI specs where it says what to show when 
> the battery is full, how it is reported or whatever. I attach my dsdt 
> file, maybe someone could look into it. I'm interested if this is a 
> problem in acpi, my dsdt or if it is deeper BIOS stuff of something.
> 
> Thank you
> 
> PD: my laptop is a fujitsu-siemens esprimo u9200.

