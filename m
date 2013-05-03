From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: 3.9.0 + CONFIG_X86_INTEL_PSTATE=y  -> ThinkPad T420 with i5 lost
 ACPI functionality
Date: Fri, 03 May 2013 23:26:17 +0200
Message-ID: <51842B79.8060302@gmx.de>
References: <5183EC09.9080208@gmx.de> <3715884.H8PIhhjRXL@vostro.rjw.lan> <518427D4.3050104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <518427D4.3050104@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 05/03/2013 11:10 PM, Dirk Brandewie wrote:
>=20
> ignore_nice_load is a feature of the ondemand governor.
> The intel_pstate driver is seeing the load presented by the BOINC cli=
ent
> and is adjusting the pstate accordingly.

Is the intel_pstate driver a choice for a notebook and friends where a
grid software is running as a low-prio back ground job ?

Because the CPU will be running mostly at high(er) frequency - which
always results in a high temperature and short battery time.

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
