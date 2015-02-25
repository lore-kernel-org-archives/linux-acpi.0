From: Scot Doyle <lkml14@scotdoyle.com>
Subject: RE: [PATCH] ACPI / EC: Remove non-standard log emphasis
Date: Wed, 25 Feb 2015 15:01:08 +0000 (UTC)
Message-ID: <alpine.LNX.2.11.1502251459001.14861@localhost>
References: <alpine.LNX.2.11.1502151932250.630@localhost> <7706896.L1jj2myRTu@vostro.rjw.lan>  <1AE640813FDE7649BE1B193DEA596E88026D8057@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.scotdoyle.com ([23.226.141.211]:36825 "EHLO
	mx1.scotdoyle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbbBYPDk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Feb 2015 10:03:40 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88026D8057@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, 25 Feb 2015, Zheng, Lv wrote:
...
> > I was using "+++++"/"#####"/"*****" to filter different EC log entries which makes debugging easier.
> > And, if we changed this from pr_info into pr_debug, then we will have nothing in the suspend/resume logs for the EC device.
> > While there are plenty of such log entries for each of other devices.
> > So I really doubt what's the meaning of such a change.
> > Could it improve anything or just make debugging more difficult for developers?
> 
> IMO, it's better to introduce such kind of code in the head of ec.c:
> 
> #ifdef DEBUG_FILTER
> #define EC_LOG_DEV "+++++"
> #define EC_LOG_CMD "*****"
> #define EC_LOG_EVT "#####"
> ...
> #else
> #define EC_LOG_DEV
> #define EC_LOG_CMD
> #define EC_LOG_EVT
> #endif
> 
> And wrap the pr_info, pr_debug using filter enabled new macros - ec_info, ec_debug so that we won't see the filters in the normal dmesg output and the filters are still available for the developers.
> 
> Thanks and best regards
> -Lv

I agree, would you be willing to submit it?
