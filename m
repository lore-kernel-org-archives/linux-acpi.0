From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: non functionable snd-ad1816a in Kernel 2.6.18-rc2
Date: Mon, 24 Jul 2006 13:40:56 -0600
Message-ID: <200607241340.56353.bjorn.helgaas@hp.com>
References: <20060718093434.60450@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:10931 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932294AbWGXS5X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Jul 2006 14:57:23 -0400
In-Reply-To: <20060718093434.60450@gmx.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Uwe Bugla <uwe.bugla@gmx.de>
Cc: akpm@osdl.org, castet.matthieu@free.fr, linux-acpi@vger.kernel.org, len.brown@intel.com, ambx1@neo.rr.com

On Tuesday 18 July 2006 03:34, Uwe Bugla wrote:
> Just a reminder for everybody listening:
> My soundcard (snd-ad1816a) does not work in Kernel 2.6.18-rc2.
> I guess the reason for this is that Matthieu=B4s material is still re=
siding in the mm-branch. Can I please have a constructive feedback wher=
e things are hanging after all that immense amount of time I spent to f=
orward this issue?
> A thousands of thanks for Matthieu=B4s work one more time!
> The bug ID is 6292, and the ACPI_PRODUCER reject patch is still missi=
ng in the main vanilla tree.

Yup, the patch is in the -mm tree, and should make its way to
the mainline vanilla kernel eventually.  It does take a while,
because we want to make sure it doesn't break somebody else's
system while fixing yours.

Bjorn
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
