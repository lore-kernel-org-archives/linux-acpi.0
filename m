From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] x86/PCI: fix boot-time memory leak
Date: Mon, 17 Oct 2011 13:59:10 -0600
Message-ID: <CAErSpo4fo+qJei5XeCqWd3kK7h=EPVtpuP0K5EvicCwnheMG5A@mail.gmail.com>
References: <20111017194037.7778.11572.stgit@bhelgaas.mtv.corp.google.com> <20111017194652.GA22656@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:52965 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab1JQT7c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Oct 2011 15:59:32 -0400
Received: from wpaz13.hot.corp.google.com (wpaz13.hot.corp.google.com [172.24.198.77])
	by smtp-out.google.com with ESMTP id p9HJxVcR017290
	for <linux-acpi@vger.kernel.org>; Mon, 17 Oct 2011 12:59:31 -0700
Received: from qabg27 (qabg27.prod.google.com [10.224.20.219])
	by wpaz13.hot.corp.google.com with ESMTP id p9HJobUE014848
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 17 Oct 2011 12:59:30 -0700
Received: by qabg27 with SMTP id g27so8293473qab.3
        for <linux-acpi@vger.kernel.org>; Mon, 17 Oct 2011 12:59:30 -0700 (PDT)
In-Reply-To: <20111017194652.GA22656@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Simon Kirby <sim@hostway.ca>, Catalin Marinas <catalin.marinas@arm.com>

On Mon, Oct 17, 2011 at 1:46 PM, Greg KH <greg@kroah.com> wrote:
> On Mon, Oct 17, 2011 at 01:40:37PM -0600, Bjorn Helgaas wrote:
>> From: Catalin Marinas <catalin.marinas@arm.com>
>>
>> If we're not using _CRS, the host bridge's bus name and resource str=
uctures
>> were allocated but never freed. =A0This patch fixes that.
>>
>> Reported-by: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>
>> Reported-by: Simon Kirby <sim@hostway.ca>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Is this something for the 3.0-stable tree as well?

It could be applied to 3.0-stable, but it only fixes a boot-time leak
of a couple hundred bytes (approx 16-byte name + typically 4 56-byte
struct resources), so I don't think it qualifies as any kind of a
critical fix.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
