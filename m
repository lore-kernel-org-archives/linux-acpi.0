From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Mon, 1 Sep 2008 09:21:59 -0300
Message-ID: <20080901122158.GB21970@khazad-dum.debian.net>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59520 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752129AbYIAMWF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Sep 2008 08:22:05 -0400
Content-Disposition: inline
In-Reply-To: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: astarikovskiy@suse.de, linux-acpi@vger.kernel.org, lenb@kernel.org

On Mon, 01 Sep 2008, Zhao Yakui wrote:
>     Will the above two patches hit the upstream kernel? If the above two patches hits the upstream kernel, it 
> seems that the boot option of "ec_intr=" comes back again and EC can't be switched from interrupt mode to polling 
> mode if EC GPE interrupt is missing. In such case maybe the battery/AC/thermal driver can't work well if the info of
> battery/AC/thermal is related with EC. Maybe there exists the regression on some laptops.

Right now, the fact that it gives up on interrupt mode too easily IS causing
regressions on ThinkPads (like the T43 I own).  Since polling mode does
work, it is just a performance regression, so you won't get many reports
about it since most people don't look for such stuff in their kernel logs.

Some ECs trigger the interrupt/poll-mode checks just on small windows
(typically during resume -- might even be a bug somewhere in ACPICA or
Linux, and not on the EC).  We should not be giving up using interrupt mode
on these so easily.  Maybe retry enabling interrupt mode after some seconds
a few times (like 3 or 5)?  If it is a transient problem, that will avoid
the permanent performance regression of polled mode.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
