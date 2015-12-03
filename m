From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2 1/3] dell-wmi: Use a C99-style array for
 bios_to_linux_keycode
Date: Thu, 3 Dec 2015 15:32:49 -0800
Message-ID: <20151203233249.GB1800@malice.jf.intel.com>
References: <cover.1448931589.git.luto@kernel.org>
 <c30cf7923f0059d21ba3d8a63b7eb47fe7e475a4.1448931589.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40183 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbbLCXcx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2015 18:32:53 -0500
Content-Disposition: inline
In-Reply-To: <c30cf7923f0059d21ba3d8a63b7eb47fe7e475a4.1448931589.git.luto@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>

On Mon, Nov 30, 2015 at 05:01:59PM -0800, Andy Lutomirski wrote:
> It's currently hard to follow what maps to what, and it's hard to edi=
t
> the array.  Redo it as a C99-style array.
>=20
> I generated this using emacs regexes and a python one-liner.
> objdump says this didn't change the table.
>=20
> Acked-by: Pali Roh=E1r <pali.rohar@gmail.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

I already have this one in next and I don't see a per-patch changelog f=
or this
one - has it changed?

--=20
Darren Hart
Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
