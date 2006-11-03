From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: [discuss] Linux 2.6.19-rc4: known unfixed regressions (v2)
Date: Fri, 03 Nov 2006 11:25:37 +0300
Message-ID: <454AFD01.4080306@linux.intel.com>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061103024132.GG13381@stusta.de> <20061103025623.GB8816@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:34202 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1752021AbWKCIZm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Nov 2006 03:25:42 -0500
In-Reply-To: <20061103025623.GB8816@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Christian <christiand59@web.de>

Could this be a problem?
--------------------
...
CONFIG_ACPI_PROCESSOR=m
...
CONFIG_X86_POWERNOW_K8=y
...

Regards,
	Alex.

Dave Jones wrote:
> On Fri, Nov 03, 2006 at 03:41:32AM +0100, Adrian Bunk wrote:
>  > This email lists some known regressions in 2.6.19-rc4 compared to 2.6.18
>  > that are not yet fixed in Linus' tree.
>  > 
>  > If you find your name in the Cc header, you are either submitter of one
>  > of the bugs, maintainer of an affectected subsystem or driver, a patch
>  > of you caused a breakage or I'm considering you in any other way possibly
>  > involved with one or more of these issues.
>  > 
>  > Due to the huge amount of recipients, please trim the Cc when answering.
>  > 
>  > Subject    : cpufreq not working on AMD K8
>  > References : http://lkml.org/lkml/2006/10/10/114
>  > Submitter  : Christian <christiand59@web.de>
>  > Status     : unknown
> 
> As Mark mentioned in his followup, powernow-k8 didn't change in .19 at all.
> I'm suspecting an ACPI change meant that we no longer find the PST tables
> correctly.
> 
> Christian, can you post the full dmesg's from the working/broken kernels.
> It may be useful to enable CONFIG_ACPI_DEBUG too.
> 
> 	Dave
> 
