From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [2.6.25-rc1] System no longer powers off after shutdown
Date: Fri, 15 Feb 2008 00:41:43 -0800
Message-ID: <86802c440802150041x3a9f3e61na12cd1661696ec5e@mail.gmail.com>
References: <200802111623.38478.elendil@planet.nl>
	 <200802122139.14840.elendil@planet.nl>
	 <20080212205622.GA21986@suse.de>
	 <200802131239.14305.elendil@planet.nl>
	 <20080213165837.GA10129@suse.de>
	 <86802c440802141538m44d64b6as827426174874979d@mail.gmail.com>
	 <20080215065230.GA8625@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:30401 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764937AbYBOIlp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Feb 2008 03:41:45 -0500
Received: by rv-out-0910.google.com with SMTP id k20so444293rvb.1
        for <linux-acpi@vger.kernel.org>; Fri, 15 Feb 2008 00:41:43 -0800 (PST)
In-Reply-To: <20080215065230.GA8625@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Feb 14, 2008 at 10:52 PM, Greg KH <gregkh@suse.de> wrote:
>
>  Ugh, sorry, I was mistaken, it's not a cpufreq issue, it's a
>  CONFIG_DETECT_SOFTLOCKUP issue.  Or that is what I was told before.
>

could  be two issues:
one in cpufreq, and one in detect softlockup...

YH
