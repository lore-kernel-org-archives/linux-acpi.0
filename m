From: Andreas Schwab <schwab@suse.de>
Subject: Re: some new unaligned access while booting ia64 (HP rx2620)
Date: Mon, 13 Feb 2006 23:57:15 +0100
Message-ID: <je7j7yc1f8.fsf@sykes.suse.de>
References: <971FCB6690CD0E4898387DBF7552B90E0452B0D7@orsmsx403.amr.corp.intel.com>
	<43F0D526.5010806@suse.de> <200602131533.53905.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <200602131533.53905.bjorn.helgaas@hp.com> (Bjorn Helgaas's
	message of "Mon, 13 Feb 2006 15:33:53 -0700")
Sender: linux-ia64-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Thomas Renninger <trenn@suse.de>, "Moore, Robert" <robert.moore@intel.com>, "Luck, Tony" <tony.luck@intel.com>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Bjorn Helgaas <bjorn.helgaas@hp.com> writes:

> I looked at both of those paths, and I don't see anything wrong.  I
> tried unsuccessfully to reproduce it with an rc1-mm4 kernel on an
> rx2600.=20

Please try rx7620 or rx8640.  Apparently this only happens on the NUMA
systems.

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
-
To unsubscribe from this list: send the line "unsubscribe linux-ia64" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
