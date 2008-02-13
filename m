From: Frans Pop <elendil@planet.nl>
Subject: Re: [2.6.25-rc1] System no longer powers off after shutdown
Date: Wed, 13 Feb 2008 10:24:26 +0100
Message-ID: <200802131024.27443.elendil@planet.nl>
References: <200802111623.38478.elendil@planet.nl> <200802122245.09444.elendil@planet.nl> <20080212235442.005aea9e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml11.KPNXCHANGE.COM ([213.75.38.111]:14930 "EHLO
	hpsmtp-eml11.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760058AbYBMJYa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Feb 2008 04:24:30 -0500
In-Reply-To: <20080212235442.005aea9e.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday 13 February 2008, you wrote:
> On Tue, 12 Feb 2008 22:45:09 +0100 Frans Pop <elendil@planet.nl> wrote:
> > Symptom is that the system shuts down normally and completely, it just
> > does not power off.
>
> I've been struggling with an identically-manifesting regression on one of
> my test machines for a week.  It's due to softlockup changes, and setting
> CONFIG_DETECT_SOFTLOCKUP=n "fixes" it.
>
> It sounds unlikely, but I'd suggest that you see if it's the same on your
> machine so we're not both chasing the same bug.

Unsetting CONFIG_DETECT_SOFTLOCKUP does not help in my case, but thanks for 
the suggestion.
