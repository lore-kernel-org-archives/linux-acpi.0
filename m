From: Andreas Schwab <schwab@suse.de>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.23-rc1
Date: Sat, 28 Jul 2007 01:41:59 +0200
Message-ID: <jed4ydfm7s.fsf@sykes.suse.de>
References: <200707251238.50218.lenb@kernel.org> <46A98FF9.8060801@l4x.org>
	<1185553512.3849.46.camel@noname> <20070727230741.GD15129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20070727230741.GD15129@stusta.de> (Adrian Bunk's message of
	"Sat\, 28 Jul 2007 01\:07\:42 +0200")
Sender: linux-ia64-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Thomas Renninger <trenn@suse.de>, Jan Dittmer <jdi@l4x.org>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org. Sam Ravnborg" <sam@ravnborg.org>, tony.luck@intel.com, linux-ia64@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> I don't have an idea how this happens, but it sounds like an alignmen=
t=20
> issue:
>
> sizeof(struct acpi_device_id)=3D20

This is wrong.  The structure has 24 bytes (including 7(!) bytes of
padding).

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
