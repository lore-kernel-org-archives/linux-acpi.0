From: Stelian Pop <stelian@popies.net>
Subject: Re: [patch 0/9] [RFC] sonypi ACPI reimplementation (resend 3)
Date: Thu, 12 Apr 2007 11:20:10 +0200
Message-ID: <1176369610.5573.76.camel@localhost.localdomain>
References: <20070409081903.057292676@linux.it>
	 <200704101613.43751.lenb@kernel.org>
	 <20070410220423.GA4041@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sd291.sivit.org ([194.146.225.122]:2157 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161159AbXDLJUN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Apr 2007 05:20:13 -0400
In-Reply-To: <20070410220423.GA4041@inferi.kami.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

Le mercredi 11 avril 2007 =E0 00:04 +0200, Mattia Dongili a =E9crit :

> The only function that sony-laptop doesn't offer is the motion eye
> camera stuff, which the meye driver also depend on and which makes
> sonypi useful at least for a couple of vaio models.  I can add it to
> sony-laptop[1] but I can't test.

The meye stuff is quite trivial, I think you can try putting it in and
let the users test...

> I should probably add some printks in sonypi to suggest moving toward=
s
> sony-laptop and try to detect if the known ioports are being used by
> sony-laptop to better handle the sonypi load failure (see below).

This would be a good idea. Maybe let it printk a pointer to the sonypi
wiki.

I have also put links to the new wiki on my sonypi web pages, this
should help the users find the relevant information.

--=20
Stelian Pop <stelian@popies.net>

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
