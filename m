From: Francesco Biscani <biscani@pd.astro.it>
Subject: Re: ACPI error in 2.6.16 (AE_TIME, Returned by Handler for EmbeddedControl)
Date: Thu, 23 Mar 2006 04:01:58 +0100
Message-ID: <200603230401.58507.biscani@pd.astro.it>
References: <F7DC2337C7631D4386A2DF6E8FB22B30067BF1BC@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:56966 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S932526AbWCWDCI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Mar 2006 22:02:08 -0500
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30067BF1BC@hdsmsx401.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "Yu, Luming" <luming.yu@intel.com>, Jiri Slaby <slaby@liberouter.org>

On Thursday 23 March 2006 02:45, Brown, Len wrote:
> does this go away if you boot with "ec_intr=3D0"?

So far it seems like that option solves the problem. But since the bug =
appears=20
very erratically I think it's better to wait for a few more reboots.

BTW, when I was testing _without_ ec_intr=3D0 I got this in the log (th=
is=20
happened the first reboot after the one mentioned in my previous mail):

Mar 23 03:48:50 kurtz ACPI: read EC, IB not empty
Mar 23 03:48:50 kurtz ACPI: read EC, OB not full
Mar 23 03:48:50 kurtz ACPI Exception (evregion-0409): AE_TIME, Returned=
 by=20
Handler for [EmbeddedControl] [20060127]
Mar 23 03:48:50 kurtz ACPI Exception (dswexec-0458): AE_TIME, While res=
olving=20
operands for [AE_NOT_CONFIGURED] [20060127]
Mar 23 03:48:50 kurtz ACPI Error (psparse-0517): Method parse/execution=
 failed=20
[\_SB_.PCI0.ISA_.EC0_._Q20] (Node c13ecbc0), AE_TIME

This is an hp pavilion ze5616ea laptop, FYI.

Thanks and best regards,

  Francesco

--=20
Dr. Francesco Biscani
Dipartimento di Astronomia
Universit=E0 di Padova
biscani@pd.astro.it
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
