From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Subject: Re: 2.6.25-rc1 regression - suspend to ram
Date: Tue, 12 Feb 2008 18:14:25 +0100
Message-ID: <20080212171425.GC4582@ics.muni.cz>
References: <20080211225811.GB4343@ics.muni.cz> <200802120010.55021.Rafal.Wysocki@fuw.edu.pl> <20080211232213.GB8206@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from minas.ics.muni.cz ([147.251.4.40]:36682 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757897AbYBLROv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Feb 2008 12:14:51 -0500
Content-Disposition: inline
In-Reply-To: <20080211232213.GB8206@linux-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Mon, Feb 11, 2008 at 03:22:13PM -0800, Venki Pallipadi wrote:
> Just sent this patch to fix a regression in acpi processor_idle.c on =
another
> thread. Can you try the patch below and check whether that helps.

Yeah, it seems that it fixed suspend troubles.

--=20
Luk=E1=B9 Hejtm=E1nek
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
