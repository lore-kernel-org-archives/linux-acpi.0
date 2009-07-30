From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [Bug 13865] [PATCH] hp-wmi: check that an input device exists
	in resume handler
Date: Thu, 30 Jul 2009 13:37:11 +0100
Message-ID: <20090730123711.GB14127@srcf.ucam.org>
References: <bug-13865-10028@http.bugzilla.kernel.org/> <200907292257.41573.rjw@sisk.pl> <200907301242.07973.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48572 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbZG3MhV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jul 2009 08:37:21 -0400
Content-Disposition: inline
In-Reply-To: <200907301242.07973.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, bugzilla-daemon@bugzilla.kernel.org, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, =?iso-8859-1?Q?C=E9dric?= Godin <cedric@belbone.be>

On Thu, Jul 30, 2009 at 12:42:05PM +0200, Frans Pop wrote:
> From: Frans Pop <elendil@planet.nl>
> Subject: hp-wmi: check that an input device exists in resume handler
>=20
> Some systems may not support input events, or registering the input
> handler may have failed. So check that an input device exists before
> trying to set the docking and tablet mode state during resume.
>=20
> Fixes: http://bugzilla.kernel.org/show_bug.cgi?id=3D13865
>=20
> Reported-and-tested-by: C=E9dric Godin <cedric@belbone.be>
> Signed-off-by: Frans Pop <elendil@planet.nl>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Acked-by: Matthew Garrett <mjg@redhat.com>

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
