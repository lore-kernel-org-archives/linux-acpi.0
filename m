From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Frequency scaling, Dell Inspiron 6000
Date: Mon, 30 Jul 2007 01:44:24 +0100
Message-ID: <20070730004423.GA27398@srcf.ucam.org>
References: <46AC9E33.3020008@molgaard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 78-32-9-130.no-dns-yet.enta.net ([78.32.9.130]:45269 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S965519AbXG3BUm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Jul 2007 21:20:42 -0400
Content-Disposition: inline
In-Reply-To: <46AC9E33.3020008@molgaard.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sune =?iso-8859-1?Q?M=F8lgaard?= <sune@molgaard.org>
Cc: linux-acpi@vger.kernel.org

On Sun, Jul 29, 2007 at 04:03:31PM +0200, Sune M=F8lgaard wrote:

> The CPU of the machine is labeled as centrino compliant, but is in fa=
ct=20
> a Celeron-M, and hence does not support _Enhanced_ Speedstep. However=
, I=20
> clearly remember having frequency scaling working with Ubuntu kernel=20
> 2.6.15, but failing with Ubuntu 2.6.17 (possibly with some 2.6.18 cod=
e=20
> backported).

It doesn't support Speedstep at all. You were probably using p4-clockmo=
d=20
in the past, which is a mechanism for temperature control rather than=20
any sort of useful power saving.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
