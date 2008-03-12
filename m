From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Wed, 12 Mar 2008 20:36:37 +0100
Message-ID: <20080312193637.GA27873@ics.muni.cz>
References: <20080225230035.GA14503@khazad-dum.debian.net> <20080312133529.GB21290@khazad-dum.debian.net> <20080312135521.GE8141@ics.muni.cz> <200803121952.42666.arekm@maven.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755156AbYCLThe@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200803121952.42666.arekm@maven.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arkadiusz Miskiewicz <arekm@maven.pl>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Jens Axboe <jens.axboe@oracle.com>, Alexey Starikovskiy <aystarik@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 12, 2008 at 07:52:41PM +0100, Arkadiusz Miskiewicz wrote:
> I'm also seeing regression on my thinkpad z60m where with git tree (t=
ested=20
> again with 2 days old git) "thinkvantage" button stopped working (pre=
ssing it=20
> was previously seen by some userspace kde which run konsole).
>=20
> On 2.6.24 presses are seen.

well, on 2.6.25-rc4, some keys are not reported as input (xev does not =
see any
key press), some keys are. Is this desired? Or all the keys (fn+f1-12 +=
 volume
+ backlight + think vantage) should be reported as some input event and=
 thus
acpid makes no sense any more?

--=20
Luk=E1=B9 Hejtm=E1nek
