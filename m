From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: [2.6.25-rc1] System no longer powers off after shutdown
Date: Wed, 13 Feb 2008 16:23:11 +0800
Message-ID: <b6a2187b0802130023m2fba0688u5ab7d4e80f2f1139@mail.gmail.com>
References: <200802111623.38478.elendil@planet.nl>
	 <200802122139.14840.elendil@planet.nl>
	 <20080212205622.GA21986@suse.de>
	 <200802122245.09444.elendil@planet.nl>
	 <20080212235442.005aea9e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:18742 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756700AbYBMIXP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Feb 2008 03:23:15 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3242985wah.23
        for <linux-acpi@vger.kernel.org>; Wed, 13 Feb 2008 00:23:11 -0800 (PST)
In-Reply-To: <20080212235442.005aea9e.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Frans Pop <elendil@planet.nl>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Feb 13, 2008 3:54 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Tue, 12 Feb 2008 22:45:09 +0100 Frans Pop <elendil@planet.nl> wrote:
>
> > Symptom is that the system shuts down normally and completely, it just does
> > not power off.
>
> I've been struggling with an identically-manifesting regression on one of
> my test machines for a week.  It's due to softlockup changes, and setting
> CONFIG_DETECT_SOFTLOCKUP=n "fixes" it.

I don't have CONFIG_DETECT_SOFTLOCKUP defined in .config and there's
not option using menuconfig to select this.

I don't know whether my problem is related or not on Lenovo X60s. I
can power-off on shutdown and suspend-to-ram, but screen turns green,
and doesn't power-off on suspend-to-disk. I've to manually press and
hold the power switch to switch off. System is able to resume later.
It was working as recent as last week, but something changed past few
days.


Jeff.
