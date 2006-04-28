From: Stefan Seyfried <seife@suse.de>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Fri, 28 Apr 2006 19:43:57 +0200
Message-ID: <20060428174357.GA16838@suse.de>
References: <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com> <mj+md-20060420.165714.18107.albireo@ucw.cz> <4447C020.3010003@linux.intel.com> <20060420220731.GF2352@ucw.cz> <444C761F.6010603@linux.intel.com> <20060424083102.GE26345@elf.ucw.cz> <444CE310.7030006@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:10978 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751577AbWD1RqI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Apr 2006 13:46:08 -0400
Content-Disposition: inline
In-Reply-To: <444CE310.7030006@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Martin Mares <mj@ucw.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, pavel@suse.cz

On Mon, Apr 24, 2006 at 06:39:12PM +0400, Alexey Starikovskiy wrote:
> Any new machine will have this same functionality if booted with=20
> acpi=3Doff,ht etc, and this is done automatically on recent SUSE inst=
alls.

I am doing many "recent SUSE" installs and have not seen one where a
acpi=3D.. line was present without the user doing something strange.
--=20
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write.=
"
SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Co=
hen
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
