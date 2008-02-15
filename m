From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Subject: Re: [Bugme-new] [Bug 9995] New: 2.6.25-rc1 regression - IBM ACPI
	backlight controlls do not work
Date: Fri, 15 Feb 2008 23:51:09 +0100
Message-ID: <20080215225109.GE4269@ics.muni.cz>
References: <bug-9995-10286@http.bugzilla.kernel.org/> <20080215122137.629c612d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from minas.ics.muni.cz ([147.251.4.40]:50379 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763871AbYBOWvb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2008 17:51:31 -0500
Content-Disposition: inline
In-Reply-To: <20080215122137.629c612d.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bugme-daemon@bugzilla.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

On Fri, Feb 15, 2008 at 12:21:37PM -0800, Andrew Morton wrote:
> I've lost the plot on what's happening with backlight.  I think you'r=
e
> about to find that this is not-a-bug, even though it stopped working.

Why do you think that it is not-a-bug even if it stopped working? I don=
't
think it is a feature as acpi video driver should control backlight lev=
els on
laptop that provides generic ACPI based backlight support which is the =
case of
ThinkPad T61. Or at least it used to be with up to 2.6.24 kernels.

I can read sane values from /sys/class/backlight/acpi_video0/* but chan=
ging them
has no effect on the backlight.

--=20
Luk=E1=B9 Hejtm=E1nek
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
