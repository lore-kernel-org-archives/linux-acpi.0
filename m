From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [ACPICA] EmbeddedControl region handling bug in PNP0C14
Date: Wed, 12 Dec 2007 14:10:14 +0000
Message-ID: <200712121410.15587.carlos@strangeworlds.co.uk>
References: <200711280350.08539.carlos@strangeworlds.co.uk> <B28E9812BAF6E2498B7EC5C427F293A403C0F46D@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:46759 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbXLLOLw (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Wed, 12 Dec 2007 09:11:52 -0500
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A403C0F46D@orsmsx415.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Wednesday 28 November 2007 18:08:44 Moore, Robert wrote:
> This will probably require a trace.

Here's the relevant ACPI error messages (with full ACPI debugging enabl=
ed)=20
from acer_acpi, with some comments as to which method is=20
being called and what arguments we're passing.

This user tested this on Kubuntu Gutsy (7.10) x86-64, with a custom 2.6=
=2E23.9=20
kernel (basically, just the ACPI debugging enabled so we can get a bett=
er=20
trace).

So, for reference, this is the DSDT we're working with:
http://files.strangeworlds.co.uk/5040.dsl

WMCA(1, 3, NULL):
[23375.726016] ACPI Error (evregion-0316): No handler for Region
[RAM_] (ffff81000132d1a0) [EmbeddedControl] [20070126]
[23375.726246] ACPI Error (exfldio-0289): Region EmbeddedControl(3)
has no handler [20070126]
[23375.726475] ACPI Exception (dswexec-0462): AE_NOT_EXIST, While
resolving operands for [Store] [20070126]
[23375.726708] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.AMW0.WMCA] (Node ffff8100013315f0), AE_NOT_EXIST

WMCA(1, 6, BUF(4 bytes) =3D 1):
[23444.490213] ACPI Error (evregion-0316): No handler for Region
[RAM_] (ffff81000132d1a0) [EmbeddedControl] [20070126]
[23444.490218] ACPI Error (exfldio-0289): Region EmbeddedControl(3)
has no handler [20070126]
[23444.490223] ACPI Exception (dswexec-0462): AE_NOT_EXIST, While
resolving operands for [LGreater] [20070126]
[23444.490228] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.AMW0.WMCA] (Node ffff8100013315f0), AE_NOT_EXIST
[23444.490263] acer_acpi: =A0 In: 0x00000001

-Carlos
--=20
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
