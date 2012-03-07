From: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Subject: Re: [Patch] Eject button for button driver
Date: Wed, 07 Mar 2012 10:48:10 +0100
Message-ID: <4F572EDA.3040903@ts.fujitsu.com>
References: <4F57155B.6080401@ts.fujitsu.com> <20120307090540.GA3379@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51]:18745 "EHLO
	dgate20.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab2CGJsM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Mar 2012 04:48:12 -0500
In-Reply-To: <20120307090540.GA3379@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Matthew,

Am 07.03.2012 10:05, schrieb Matthew Garrett:
> - binding this in the button driver would make it impossible to write=
 a=20
> full driver. There's an existing driver floating around under the nam=
e=20
> "quickstart". A better approach would be to tidy that up and make sur=
e=20
> it works for your case, and then submit that.

Thanks for that info. I will check that quickstart driver now.

Regards
Rainer
--=20
Dipl.-Inf. (FH) Rainer Koenig
Project Manager Linux Clients
Dept. PDG WPS R&D SW OSE

=46ujitsu Technology Solutions
B=FCrgermeister-Ullrich-Str. 100
86199 Augsburg
Germany

Telephone: +49-821-804-3321
Telefax:   +49-821-804-2131
Mail:      mailto:Rainer.Koenig@ts.fujitsu.com

Internet         ts.fujtsu.com
Company Details  ts.fujitsu.com/imprint.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
