From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: Lenovo 3000 N100: no battery rate
Date: Thu, 05 Oct 2006 00:55:37 +0400
Message-ID: <45241FC9.2070806@linux.intel.com>
References: <1159994141.2821.12.camel@hughsie-laptop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:30751 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751111AbWJDUzn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Oct 2006 16:55:43 -0400
In-Reply-To: <1159994141.2821.12.camel@hughsie-laptop.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: hughsient@gmail.com
Cc: linux-acpi@vger.kernel.org

Please open bug at bugzilla.kernel.org against ACPI/battery and attach output from acpidump to it.

Thanks,
	Alex
Richard Hughes wrote:
> Hey,
> 
> My new Lenovo 3000 N100 works great with ACPI Linux of the box -- with
> one exception.
> 
> "cat /proc/acpi/battery/BAT1/state" *always* reports "present rate: 0
> mA" - which means I get no rate information for gnome-power-manager, and
> hence no graphs or data on the power usage.
> 
> As the author of gnome-power-manager this is a bad thing :-)
> 
> I've checked out my DSDT with iasl and there are no reported problems.
> I'm also running 2.6.18 and using the latest (1.02 bios) I don't know
> where or how to start debugging this so I'm asking for advice.
> 
> Thanks guys,
> 
> Richard Hughes
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
