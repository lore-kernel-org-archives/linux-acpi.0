From: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: Re: 2.6.15-mm2 (acpi-cpufreq not loading)
Date: Thu, 19 Jan 2006 17:02:46 -0500
Message-ID: <43D00C86.3050403@ens-lyon.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CA52@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:60610 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1161157AbWASWCz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jan 2006 17:02:55 -0500
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CA52@hdsmsx401.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org

Brown, Len wrote:

>The dmesg you attached doesn't show a message showing
>that acpi-cpufreq failed to load.
>  
>
Yes, modprobe's error is not shown in dmesg (I don't know whether it is
configurable or not). I just double-checked my boot, I get :

ACPI: Processor [CPU] (supports 8 throttling states)
FATAL: Error loading acpi_cpufreq (/lib/modules/.../acpi_cpufreq.ko): No
such device
Machine check exception polling timer started.

instead of (2.6.15):

ACPI: Processor [CPU] (supports 8 throttling states)
acpi-cpufreq: CPU0 - ACPI performance management activated.
Machine check exception polling timer started.

In case if matters, acpi-cpufreq is loaded early (in /etc/modules on my
Debian), before any other acpi modules is loaded (except processor since
it depends on it).

Brice

