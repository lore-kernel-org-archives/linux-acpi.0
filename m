From: "Brown, Len" <len.brown@intel.com>
Subject: RE:  Re: 2.6.15-mm2 (acpi-cpufreq not loading)
Date: Fri, 20 Jan 2006 03:31:09 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CEFF@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr13.intel.com ([192.55.52.67]:20103 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750732AbWATIbg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2006 03:31:36 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: GregR <grcore@usamtb.com>, Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org


>Brice Goglin <Brice.Goglin <at> ens-lyon.org> writes:
>
>> Yes, modprobe's error is not shown in dmesg (I don't know 
>> whether it is configurable or not). I just double-checked my boot, I get :
>
>[SNIP]
>
>> In case if matters, acpi-cpufreq is loaded early (in 
>/etc/modules on my
>> Debian), before any other acpi modules is loaded (except 
>processor since
>> it depends on it).
>
>If it helps, I had the same problem with 2.6.15, and I ended 
>up building it in [*], as opposed to a module [M] at compile time.
>Worked fine after that.

Brice, does building =y help?

thanks,
-Len
