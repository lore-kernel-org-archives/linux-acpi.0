From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-pm] Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Tue, 9 Jun 2009 16:48:09 +0200
Message-ID: <200906091648.09659.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0906091032260.28447-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:37978 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbZFIOrX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jun 2009 10:47:23 -0400
In-Reply-To: <Pine.LNX.4.44L0.0906091032260.28447-100000@netrider.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Am Dienstag, 9. Juni 2009 16:33:12 schrieb Alan Stern:
> On Tue, 9 Jun 2009, Oliver Neukum wrote:
> > But the problem here is STR or STD. How do you notify drivers that =
the
> > BIOS has resumed their device instead of autoresume() being called?=
 A
> > driver has to know that its device has become active without its
> > knowledge.
>
> That would be a wonderful contradiction in terms. =A0:-)

A practical application of the uncertainty principle in quantum computi=
ng.

But you have to notify a driver if you notice that a device's power sta=
te
has been changed without the knowledge of its driver.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
