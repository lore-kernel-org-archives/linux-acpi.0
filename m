From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH 1/3] ipmi: Turn off default probing of interfaces
Date: Mon, 24 Feb 2014 10:57:55 -0600
Message-ID: <530B7A13.3030907@mvista.com>
References: <1393208616-16500-1-git-send-email-minyard@acm.org> <1393208616-16500-2-git-send-email-minyard@acm.org> <20140224165320.GA26479@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:42580 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbaBXQ56 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Feb 2014 11:57:58 -0500
Received: by mail-oa0-f41.google.com with SMTP id o6so7253982oag.14
        for <linux-acpi@vger.kernel.org>; Mon, 24 Feb 2014 08:57:57 -0800 (PST)
In-Reply-To: <20140224165320.GA26479@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, minyard@acm.org
Cc: OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>, Linux Kernel <linux-kernel@vger.kernel.org>, Russ Anderson <rja@sgi.com>, Matthew Garrett <matthew.garrett@nebula.com>, lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org

On 02/24/2014 10:53 AM, Dmitry Torokhov wrote:
> Hi Corey,
>
> On Sun, Feb 23, 2014 at 08:23:34PM -0600, minyard@acm.org wrote:
> Would not
>
> static bool          si_trydefaults = IS_ENABLED(CONFIG_IPMI_SI_PROBE_DEFAULTS);
>
> work better here?
>
> Thanks.
>
Certainly.  I will update it.  Thanks,

-corey
