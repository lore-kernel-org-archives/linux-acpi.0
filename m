From: "Uwe Bugla" <uwe.bugla@gmx.de>
Subject: non functionable snd-ad1816a in Kernel 2.6.18-rc2
Date: Tue, 18 Jul 2006 11:34:34 +0200
Message-ID: <20060718093434.60450@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.21]:38565 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932105AbWGRJef (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Jul 2006 05:34:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: castet.matthieu@free.fr, bjorn.helgaas@hp.com, linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org, ambx1@neo.rr.com

Hi everybody,

Just a reminder for everybody listening:
My soundcard (snd-ad1816a) does not work in Kernel 2.6.18-rc2.
I guess the reason for this is that Matthieu=B4s material is still resi=
ding in the mm-branch. Can I please have a constructive feedback where =
things are hanging after all that immense amount of time I spent to for=
ward this issue?
A thousands of thanks for Matthieu=B4s work one more time!
The bug ID is 6292, and the ACPI_PRODUCER reject patch is still missing=
 in the main vanilla tree.

Regards

Uwe

--=20


Echte DSL-Flatrate dauerhaft f=FCr 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
