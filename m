From: Jan-Simon =?utf-8?q?M=C3=B6ller?= <dl9pf@gmx.de>
Subject: Re: Fwd: FSC Esprimo Mobile V5505 - dmidecode
Date: Wed, 13 Feb 2008 09:51:48 +0100
Message-ID: <200802130951.49058.dl9pf@gmx.de>
References: <200710122357.46851.dl9pf@gmx.de> <200802122132.48419.dl9pf@gmx.de> <200802122316.19918.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:39583 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753732AbYBMIvw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Feb 2008 03:51:52 -0500
In-Reply-To: <200802122316.19918.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Am Mittwoch, 13. Februar 2008 05:16:19 schrieb Len Brown:
[...]
> > For the WMI: Could acer_wmi be extended for this as Alex suggested ?
> > Another FSC model is listed in their hw-db.
>
> yes, but rather than extending acer_wmi, it would probably be more
> appropriate to fork it into fsc_wmi...
Sure ...

> > Atm this is fine for me - being able to adjust the brightness in "some"
> > way. But this is not good for user/newbie xyz. How should he know the
> > kernel-cmdline.
>
> I saw your comments in bugzilla 9939.
> One possibility is that we could add a DMI entry
> that automatically does acpi_osi="!Windows 2006" for you.
For me its ok to use the option. BUT if there's no better way atm then for 
user "Jony smith" its better to do that automagically.


Best regards
Jan-SImon
