From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Fri, 12 Jul 2013 09:37:23 +0200
Message-ID: <6802146.fKe43BS873@skinner.arch.suse.de>
References: <1373544870-15135-1-git-send-email-oliver@neukum.org> <1373575822.7539.74.camel@linux-s257.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48287 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027Ab3GLHhY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jul 2013 03:37:24 -0400
In-Reply-To: <1373575822.7539.74.camel@linux-s257.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: oliver@neukum.org, lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, Oliver Neukum <oneukum@suse.de>

On Friday, July 12, 2013 04:50:22 AM joeyli wrote:
> =E6=96=BC =E5=9B=9B=EF=BC=8C2013-07-11 =E6=96=BC 14:14 +0200=EF=BC=8C=
oliver@neukum.org =E6=8F=90=E5=88=B0=EF=BC=9A
=2E..
> On the other hand, I saw another BIOS changed hardware_signature beca=
use
> the VGA detect output resolution changed when S4 resume. It's a probl=
em
> for sometimes BIOS widely used hardware_signature on non-critical
> hardware change.

I wonder how Windows is handling that.
The spec is rather clear and OS should abort the resuming:
------
5.2.10 Firmware ACPI Control Structure (FACS)
=2E..
If the values are not the same, OSPM assumes
that the saved non-volatile image is from a different hardware
configuration and cannot be restored.
------
I would say either:
   - someone checks Windows behavior and if they do it wrong
     and still resume, resuming unconditionally is an option.
     But they might fix this at some point of time and force vendors
     to do things right, then we would still try to resume even we
     must not.

  - a boot parameter for the poor souls with such BIOS defects
    so that they can still resume


My 2 cents,

           Thomas
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
