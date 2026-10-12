Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA821A3A80;
	Mon, 12 Oct 2026 03:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791776603; cv=none; b=qWoypWvB8oHh/aSV7q4/TccyMP1W58WqfitMWMI9s2tDcphKggZtAm+vCdAJHUiqUQFR6fvSGZ5sGgXYIf4GBHm16eF4rd1FAovSBK29PvZI20QhJ45UayaRwt0IOQ2/6Kn81JLBK3wuccwhD59ibZzEaLFcklw1jAQZ063zvUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791776603; c=relaxed/simple;
	bh=+15VJTlScHkmwF6EDp/JWVvg5R7Iq9tZn2hQ1zNNZSc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXiBLKl+8bXWcWGKIwcznaWJFv45UC1lsbvwHjBj6EQzlwI6gy/MnqBl2nKanLWnUhATK+/yR1KwwAVliBjf/RsunLgVZTvL0hZbPZirvS//EqYgtakRcaKh6fUPhdHLETAYpXQtSCIKxNR2Ox8fuq2mkqu/4J6of6YUNmLtbjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=kl51Bf+R; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="kl51Bf+R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1791776581;
	bh=/n6ZvoTw0KGEuu+Wu87P4J3fHQ7VrJmtaIjGce9zCOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kl51Bf+RJ1rztVUzy5WZEUXUZDRYENY3FTezmFGFX1bD/LiNlpRly4vbmNd392Kjn
	 dI+vImko1iMsYw6BSBqkximoa1MbUSXrblk33DLf4pEDlrbVj1Xadijd5hODeXKFDi
	 5pLgbFL6PQJ00hpEjMU0SU10Ep3s5aJWQVngBSZM=
Received: from [127.0.1.1] ([223.66.52.202])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id ABAAB8A5; Mon, 12 Oct 2026 11:42:58 +0800
X-QQ-mid: xmsmtpt1791776578tn12hqwcq
Message-ID: <tencent_7F39F02728B55CE3B1878AAB51BAA0FE2D07@qq.com>
X-QQ-XMAILINFO: OIPiZ4jSkGWA3Cjv3DJnTSSQ73dlA5FMM0kw9xUk0AvUjMdms0Akt6//vTTi3t
	 MISE2jj/hklArLa5sIrHlQroE8fIDsGuW2Z74GN0nCPA0cp/hwn8Xkx6dYfSAQgJxpqwG34tR13/
	 E1RVDZJgGYQxNtSlyPuVRwUN7743fxe7pT3ALQdW3IHbznc3BZQRQOSxUvE9kZM5x7GUyMQc2DiY
	 DDTkG23tPBLlvkMUGDyo1are2ay09nUNHRFxAhA+yFMQwaYfrESW3DkRDc2v7Kshm5aUfTNI+R89
	 Szkr+rgQjKLOGTuirKef4iIH8sv9FtpNSrP/0jzlwvHdIvtjsH5EnnAGhKMIIM7UfjkBnkG+BkG/
	 Y/JdZQQLuJyBqKOg1uHwZ6xy3G2ewZDrNtZu1XV8thskVTmzBx/1xlPjkSh5O7+6hr/KkqP3jV0W
	 l3TNhPlxp6c62aq3/tyB+m/NJeGRkCO7GpvxVTbSw8Ei6s9UtA5PM9MX/9AFLxkkjzS6Qnd5WehW
	 G9Q3xnto3oD5YjM7ginTVLBUFrNYZRpuuT5/2PteFzJGXuBytNTsqV5t00cPDt7h1Pzlpmqhly4z
	 4srhV45sP3Ff9njucj8P9YESHXnenrLA+EbaO4h4/g+CvOgAzwLOxTxdg20r7sTKk7qCYQ877nAu
	 Gu2pqycDMevMXIl2jvf8ix47j5Fcng1bLSMphZ27904HuUK5PEdnT68Tr87Ej0nej/53hzc86R/J
	 LSmB0QO+E6Ml7Y2+fEK9l8REm/lE8MXEVIPhQK+/0OBP7vrp5yzWaNEwAET1HKa0cNmoyvBT+fgb
	 OdjFYtvuHGfHkdBRfSJP9KCALnrSCsElE0Zho+Ibkr91g8jPcHtTmlJddQ3+h+RLOIJq6Z/9Z988
	 uJ0ohvaI4s013ALHdIrnqHLburMvoLo+76CbqEpgVz2iR60caEeKnmHMLPVy2yyIZetnq+KXaWBe
	 9glILkfD0/rVj+3+TaXTun9ao+4Hk9phNtCx2pCSHXNyb7byIYpj3WA5u56rrxiMvJwve6uVQXlZ
	 9bHet/FkCUYHPa9OnoA4/toQ0LPLv9KMcrRY+68HId7IbeOA35worhUsZ+sx2rMrqVLZ7DJD7z9d
	 cqeebSEluwIGjD2PQhEpLlyYsH6FGY/AK3KKeW4pVFZ13Kr476fvYg6UJ7I0TldqjlHAfQ
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Wu Zhipeng <zepwu@foxmail.com>
To: Alex Yeo <alexyeo362@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: Re: [RFC PATCH v3] platform/x86: panasonic-laptop: Add
 platform_profile support
Date: Mon, 12 Oct 2026 11:42:58 +0800
X-OQ-MSGID: <179177657850.773507.11688468845994364693@foxmail.com>
In-Reply-To: <20261007190446.38862-1-alexyeo362@gmail.com>
References: <20261007190446.38862-1-alexyeo362@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7609684628121552823=="

--===============7609684628121552823==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Thanks for the RFC and for carrying the series through v3. I tested this
on a Panasonic CF-SV1-2 (product name "CFSV1-2" per dmidecode,
i5-1145G7, BIOS V2.00L23), which exposes the same SEFM/SEPL/CEFM/EPLE
method quartet and the same 4-state fan/TDP matrix your driver relies
on. The _SB.IETM._OSC region from this unit's dump is in the excerpt
below if it helps place it in your A/B grouping.

Summary of my findings:

1. CF-SV1-2 is not in v3's tested list or DMI table. Mirroring the v3
   CF-SR4 table, the mapping here is: active+locked -> COOL,
   passive+locked -> QUIET, active+unlocked -> PERFORMANCE, which
   leaves passive+unlocked to fall out as CUSTOM exactly as get()
   reports unmapped states. The startup default on this unit is
   CEFM=3D0 / EPLE=3D1, i.e. active+locked (COOL), the same shape as your
   per-model "Startup default" notes. One mapping note: COOL is
   currently SR4-only, but on the SV1 the active fan is likewise the
   aggressive setting (4 C cooler at the same package power, below),
   so SV1 would be a second COOL model. A quirk patch rebased onto
   your v3 is attached (a starting point, not for direct merge).
2. Measured on this unit, the fan toggle is the dominant lever: it
   moves the peak package temperature by +4 C on AC and +9..10 C on
   battery, with package power essentially flat (fan effect <=3D 0.05 W
   on AC and <=3D 0.25 W on battery). The TDP toggle moves much less:
   <=3D 0.05 W and +2 C on AC, <=3D 0.41 W and +5..6 C on battery. Even
   with EPP pinned to performance the package stayed at <=3D 2.6 GHz /
   ~10.5 W, and I could not establish from the OS side what still caps
   it; I flag this because it affects what "unlocked" should mean on
   this generation.
3. A few model-specific AML details I noticed (SSDT excerpts are appended
   below):
   =C2=B7 REFM writes a curve byte to EC register 0x79 and the values are
     model-specific: this SV1 uses 0x00 (CEFM=3D0) / 0x05 (CEFM=3D1) /
     0x02 under S0i3, while the SR4 REFM quoted in your fan-speed RFC
     v8 (its ssdt10.dsl) swaps the latter two. Only the SEFM boolean
     is portable, so the curve bytes shouldn't be documented as
     universal.
   =C2=B7 REPL has four outcomes, not a binary cap: EPLE=3D1 selects an IETM
     table PL (P140/P143 here; the battery locked runs land on
     P140 =3D 10 W) and EPLE=3D0 gives the 0xFF no-limit branch, so the
     effective wattage comes from the IETM tables rather than a fixed
     number. v3's EPLE read matches what the EC does.
   =C2=B7 _FST's second field is the fan setpoint (PEN1), not RPM.
   =C2=B7 While TFN1._FSL holds a nonzero override, the EC ignores the
     curve register, masking platform_profile set(). Your decision not
     to touch _FSL looks correct.
   =C2=B7 Consistent with the WAK -> REPL/REFM/... chain, the profile
     setting survives suspend/resume (verified with rtcwake).

Data -- AC, userspace fan governance parked so the firmware owns the
fan; per state: write SEFM/SEPL, 30 s settle, then sysbench cpu
--threads=3D8 --time=3D60 with 1 s RAPL package sampling. PkgWatt =3D mean
package power over the 60 s window (RAPL energy delta); temp =3D highest
package temperature in that window; medians over 3 interleaved runs,
min-max in parentheses:

  Configuration              PkgWatt sustained        sysbench   pkg max
  high(active)  + locked     6.28 W (6.21-6.33)     5510 e/s   41.0 C (41-42)
  quiet(passive) + locked    6.23 W (6.21-6.34)     5425 e/s   45.0 C (45-47)
  quiet(passive) + unlocked 6.22 W (6.19-6.26)     5412 e/s   47.0 C (47-48)
  high(active)  + unlocked  6.23 W (6.22-6.25)     5481 e/s   43.0 C (42-44)

  fan toggle (quiet - high)     : package -0.05 W, pkg max +4.0 C @locked
                                  package -0.02 W, pkg max +4.0 C @unlocked
  TDP toggle (unlocked - locked): package -0.05 W, pkg max +2.0 C @high fan
                                  package -0.02 W, pkg max +2.0 C @quiet fan

Battery -- same method, but EPP pinned to performance so the CPU asks
for more than the P140 table value; S0IX=3D0 / PWRS=3D0 throughout, i.e.
the P152/P154 branch never fires in working states (n=3D1, trend only):

  Configuration              PkgWatt sustained       pkg max
  high(active)  + locked     9.98 W                  48.0 C
  quiet(passive) + locked    10.01 W                 57.0 C
  quiet(passive) + unlocked  10.42 W                 63.0 C
  high(active)  + unlocked   10.20 W                 53.0 C

The locked states land on the P140 value (~10.0 W) and unlocking adds
only 0.2-0.4 W here, so the TDP toggle stays a minor lever on battery
as well.

Reproducibility: kernel 7.0.0-38-generic, iasl 20251212; a fresh
acpidump -b on the unit gives ssdt2.dat sha256
f0d92acff1f43c29c7921ebeb6951375f21d5fc554e7070426c6b9e8f62f5f61, and
decompiling it gives ssdt2.dsl sha256 913edf1cf5571f2b... (the regions
quoted above are appended below). Per-run samples and the raw dump stay
on my side and are available on request.

Attached as plain text: cf-sv1-platform_profile-quirk.patch
(git-format-patch against your v3) and the two summary tables above as
summary-ac.csv / summary-battery.csv. The SSDT excerpt is appended
below after the --- delimiter, and the full run logs are available on
request. Happy to build-test it here and send a Tested-by.

This message was drafted with the assistance of an AI coding agent;
all measurements and AML reading were reviewed by me against the raw
data.

Reported-by: Wu Zhipeng <zepwu@foxmail.com>

---

# Excerpt from ssdt2.dsl -- decompiled with iasl 20251212 from ssdt2.dat
# (sha256 f0d92acff1f43c29c7921ebeb6951375f21d5fc554e7070426c6b9e8f62f5f61,
#  acpidump -b on the CF-SV1-2 under kernel 7.0.0-38-generic; the
#  decompiled file's sha256 starts 913edf1cf5571f2b).
# Line numbers refer to the decompiled file.  The mail quotes the
# relevant parts inline (C1/C2); this file is the surrounding context.

# ---- \_SB.IETM._OSC : sets SEFM/SEPL from the OS capabilities ----
  355              Method (_OSC, 4, Serialized)  // _OSC: Operating System Ca=
pabilities
  356              {
  357                  CreateDWordField (Arg3, Zero, STS1)
  358                  CreateDWordField (Arg3, 0x04, CAP1)
  359                  If ((Arg1 !=3D One))
  360                  {
  361                      STS1 &=3D 0xFFFFFF00
  362                      STS1 |=3D 0x0A
  363                      Return (Arg3)
  364                  }
  365 =20
  366                  If ((Arg2 !=3D 0x02))
  367                  {
  368                      STS1 &=3D 0xFFFFFF00
  369                      STS1 |=3D 0x02
  370                      Return (Arg3)
  371                  }
  372 =20
  373                  If (CondRefOf (\_SB.APSV))
  374                  {
  375                      If ((PSEM =3D=3D Zero))
  376                      {
  377                          PSEM =3D One
  378                          PTRP =3D \_SB.APSV /* External reference */
  379                      }
  380                  }
  381 =20
  382                  If (CondRefOf (\_SB.AAC0))
  383                  {
  384                      If ((ASEM =3D=3D Zero))
  385                      {
  386                          ASEM =3D One
  387                          ATRP =3D \_SB.AAC0 /* External reference */
  388                      }
  389                  }
  390 =20
  391                  If (CondRefOf (\_SB.ACRT))
  392                  {
  393                      If ((YSEM =3D=3D Zero))
  394                      {
  395                          YSEM =3D One
  396                          YTRP =3D \_SB.ACRT /* External reference */
  397                      }
  398                  }
  399 =20
  400                  If ((Arg0 =3D=3D ToUUID ("b23ba85d-c8b7-3542-88de-8de2=
ffcfd698") /* Unknown UUID */))
  401                  {
  402                      If (~(STS1 & One))
  403                      {
  404                          If ((CAP1 & One))
  405                          {
  406                              If ((CAP1 & 0x02))
  407                              {
  408                                  \_SB.AAC0 =3D 0x6E
  409                                  \_SB.PC00.LPCB.EC0.SEFM (One)
  410                              }
  411                              Else
  412                              {
  413                                  \_SB.AAC0 =3D ATRP /* \_SB_.IETM.ATRP =
*/
  414                                  \_SB.PC00.LPCB.EC0.SEFM (Zero)
  415                              }
  416 =20
  417                              If ((CAP1 & 0x04))
  418                              {
  419                                  \_SB.APSV =3D 0x6E
  420                                  \_SB.PC00.LPCB.EC0.SEPL (Zero)
  421                                  \_SB.PC00.TCPU.TDPL ()
  422                              }
  423                              Else
  424                              {
  425                                  \_SB.APSV =3D PTRP /* \_SB_.IETM.PTRP =
*/
  426                                  \_SB.PC00.LPCB.EC0.SEPL (One)
  427                              }
  428 =20
  429                              If ((CAP1 & 0x08))
  430                              {
  431                                  \_SB.ACRT =3D 0xD2
  432                                  \_TZ.ETMD =3D Zero
  433                              }
  434                              Else
  435                              {
  436                                  \_SB.ACRT =3D YTRP /* \_SB_.IETM.YTRP =
*/
  437                                  \_TZ.ETMD =3D One
  438                              }
  439                          }
  440                          Else
  441                          {
  442                              \_SB.ACRT =3D YTRP /* \_SB_.IETM.YTRP */
  443                              \_SB.APSV =3D PTRP /* \_SB_.IETM.PTRP */
  444                              \_SB.AAC0 =3D ATRP /* \_SB_.IETM.ATRP */
  445                              \_TZ.ETMD =3D One
  446                          }
  447 =20
  448                          If (CondRefOf (\_TZ.TZ00))
  449                          {
  450                              Notify (\_TZ.TZ00, 0x81) // Information Ch=
ange

# ---- SEFM / REFM : CEFM -> fan curve byte (C1) ----
 3640          Name (CEFM, Zero)
 3641          Method (SEFM, 1, Serialized)
 3642          {
 3643              CEFM =3D Arg0
 3644              REFM ()
 3645          }
 3646 =20
 3647          Method (REFM, 0, Serialized)
 3648          {
 3649              If ((\S0IX =3D=3D 0x03))
 3650              {
 3651                  \_SB.PC00.LPCB.EC0.EC88 (0xB5, 0x79, 0x02, Zero)
 3652              }
 3653              ElseIf ((CEFM =3D=3D Zero))
 3654              {
 3655                  \_SB.PC00.LPCB.EC0.EC88 (0xB5, 0x79, Zero, Zero)
 3656              }
 3657              Else
 3658              {
 3659                  \_SB.PC00.LPCB.EC0.EC88 (0xB5, 0x79, 0x05, Zero)
 3660              }
 3661          }

# ---- SEPL / REPL : EPLE/S0IX/PWRS -> power limit table (C2) ----
 3663          Name (EPLE, One)
 3664          Method (SEPL, 1, Serialized)
 3665          {
 3666              EPLE =3D Arg0
 3667              REPL ()
 3668          }
 3669 =20
 3670          Method (REPL, 0, Serialized)
 3671          {
 3672              Name (EPL1, 0xFF)
 3673              Name (EPL2, 0xFF)
 3674              Name (EPLT, Zero)
 3675              If (((\S0IX =3D=3D One) && (\PWRS =3D=3D Zero)))
 3676              {
 3677                  EPL1 =3D \_SB.IETM.P152
 3678                  EPL2 =3D \_SB.IETM.P154
 3679                  EPLT =3D \_SB.PC00.TCPU.CTN2 (\_SB.IETM.P153)
 3680              }
 3681              ElseIf ((\S0IX =3D=3D 0x03))
 3682              {
 3683                  EPL1 =3D \_SB.IETM.P164
 3684                  EPL2 =3D \_SB.IETM.P166
 3685                  EPLT =3D \_SB.PC00.TCPU.CTN2 (\_SB.IETM.P165)
 3686              }
 3687              ElseIf ((EPLE =3D=3D One))
 3688              {
 3689                  EPL1 =3D \_SB.IETM.P140
 3690                  EPL2 =3D \_SB.IETM.P143
 3691                  EPLT =3D \_SB.PC00.TCPU.CTN2 (\_SB.IETM.P142)
 3692                  If ((\_SB.PC00.LPCB.EC0.EC34 () > \_SB.IETM.CTOK (\_SB=
.IETM.P145)))
 3693                  {
 3694                      EPL1 =3D \_SB.IETM.P141
 3695                  }
 3696              }
 3697              Else
 3698              {
 3699              }
 3700 =20
 3701              \_SB.PC00.LPCB.EC0.EC88 (0xB5, 0xCA, EPL1, EPLT)
 3702              \_SB.PC00.LPCB.EC0.EC88 (0xB5, 0xCB, EPL2, Zero)
 3703          }

# ---- \_SB.IETM.WAK : re-applies REPL/REFM/REFD/SCGR after resume ----
 3717          Method (WAK, 1, Serialized)
 3718          {
 3719              \_SB.PC00.LPCB.EC0.REPL ()
 3720              \_SB.PC00.LPCB.EC0.REFM ()
 3721              \_SB.PC00.LPCB.EC0.REFD ()
 3722              \_SB.PC00.LPCB.EC0.SCGR (Zero)
 3723          }

--===============7609684628121552823==
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cf-sv1-platform_profile-quirk.patch"
MIME-Version: 1.0

RnJvbSBjNzYzNmFmNzJkYjdhNGM2NDk5MTRmZjNmZTliYjY3YjE4NGExNmQ5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXdSBaaGlwZW5nIDx6ZXB3dUBmb3htYWlsLmNvbT4KRGF0ZTog
TW9uLCAxMiBPY3QgMjAyNiAxMTozNToyMSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHBsYXRmb3Jt
L3g4NjogcGFuYXNvbmljLWxhcHRvcDogYWRkIHBsYXRmb3JtX3Byb2ZpbGUgcXVpcmsKIGZvciBD
Ri1TVjEtMgoKQWRkIGEgcGxhdGZvcm1fcHJvZmlsZSBxdWlyayBmb3IgdGhlIFBhbmFzb25pYyBD
Ri1TVjEtMiAoTGV0J3MgTm90ZSwKVGlnZXIgTGFrZSksIHZlcmlmaWVkIG9uIGhhcmR3YXJlIHdp
dGggQklPUyBWMi4wMEwyMy4gIFRoZSBmaXJtd2FyZQpleHBvc2VzIHRoZSBzYW1lIGZhbiBhbmQg
VERQIHBvbGljeSBjb250cm9scyBhcyBDRi1TUjQgKENFRk0vRVBMRSBzdGF0ZQp2YXJpYWJsZXMs
IF9TQi5JRVRNIFAxNHgvUDE1eCBwb3dlciB0YWJsZXMsIGFuZCB0aGUgV0FLIC0+ClJFUEwvUkVG
TS9SRUZEL1NDR1IgcmUtYXBwbHkgY2hhaW4pLCBzbyB0aGUgbW9kZWwgbWFwcyBvbnRvCkNPT0wv
UVVJRVQvUEVSRk9STUFOQ0UgZm9sbG93aW5nIHRoZSBDRi1TUjQgdGFibGU7IHRoZSByZW1haW5p
bmcKZmFuL1REUCBjb21iaW5hdGlvbiBpcyByZXBvcnRlZCBhcyBDVVNUT00gYnkgZ2V0KCkuCgpN
ZWFzdXJlZCBvbiB0aGUgdW5pdCwgdGhlIGZhbiBwb2xpY3kgdG9nZ2xlIGRvbWluYXRlczogaW4g
dGhlCnBvd2VyLXNhdmVyIHJlZ2ltZSB0aGUgQ1BVIHRlbXBlcmF0dXJlIGRpZmZlcnMgYnkgNS4w
IEMgYmV0d2VlbiB0aGUKaGlnaC1mYW4gYW5kIHF1aWV0IGN1cnZlcyAoNy04IEMgd2l0aCBhIG1v
cmUgYWdncmVzc2l2ZSBFUFApLCB3aGlsZQp0aGUgVERQIHRvZ2dsZSBtb3ZlcyBwYWNrYWdlIHBv
d2VyIGJ5IDw9IDAuMSBXIGluIHRoYXQgcmVnaW1lIGFuZCBieQp+MC41IFcgYXQgbW9zdCBpbiB0
aGUgb3RoZXJzLgoKTW9kZWwtc3BlY2lmaWMgYmVoYXZpb3VyIGlzIGNhcHR1cmVkIGluIGNvbW1l
bnRzIGJlY2F1c2UgaXQgZG9lcyBub3QKZ2VuZXJhbGlzZSBhY3Jvc3MgbW9kZWxzOiB0aGUgU0VG
TSBjdXJ2ZS1ieXRlIHZhbHVlcyBhcmUgc3dhcHBlZAphZ2FpbnN0IENGLVNSNCwgRVBMRS9TRVBM
IHNlbGVjdCBhbiBJRVRNIHRhYmxlIFBMIHJhdGhlciB0aGFuIGEgZml4ZWQKVERQIGNhcCwgX0ZT
VFsxXSBpcyBhIGZhbiBzZXRwb2ludCBhbmQgbm90IFJQTSwgYW5kIGEgbm9uemVybyBURk4xLl9G
U0wKb3ZlcnJpZGUgbWFza3MgYSBwcm9maWxlIGNoYW5nZSB1bnRpbCBpdCBpcyByZWxlYXNlZC4K
ClNpZ25lZC1vZmYtYnk6IFd1IFpoaXBlbmcgPHplcHd1QGZveG1haWwuY29tPgotLS0KU3RhcnRp
bmcgcG9pbnQgYWdhaW5zdCBSRkMgdjMsIG5vdCBmb3IgZGlyZWN0IG1lcmdlLiAgUmViYXNlZCBv
bnRvIHRoZQp2MyBwY2NfcHJvZmlsZSBwbGF0Zm9ybV9kcml2ZXI7IG1vZGVsIG5vdGVzIHVwZGF0
ZWQgdG8gdjMncyBtZXRob2QKbmFtZXMgKENFRk0vRVBMRSByZWFkLCBTRUZNL1NFUEwgd3JpdGUp
IGFuZCB0aGUgQ1VTVE9NIGhhbmRsaW5nCmFsaWducyB3aXRoIGdldCgpIHJlcG9ydGluZyB1bnJl
Y29nbmlzZWQgc3RhdGVzIGFzIENVU1RPTS4KLS0tCiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9wYW5h
c29uaWMtbGFwdG9wLmMgfCA0MyArKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hh
bmdlZCwgNDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2
L3BhbmFzb25pYy1sYXB0b3AuYyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L3BhbmFzb25pYy1sYXB0
b3AuYwppbmRleCBjNGIxM2EzLi5hYWJjNzgxIDEwMDY0NAotLS0gYS9kcml2ZXJzL3BsYXRmb3Jt
L3g4Ni9wYW5hc29uaWMtbGFwdG9wLmMKKysrIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvcGFuYXNv
bmljLWxhcHRvcC5jCkBAIC0zMDcsNiArMzA3LDQxIEBAIHN0YXRpYyBzdHJ1Y3QgcGNjX3Byb2Zp
bGVfcXVpcmsgcXVpcmtfY2Zfc3I0ID0gewogCX0sCiB9OwogCisvKgorICogTW9kZWwgbm90ZXMs
IENGLVNWMS0yICh2ZXJpZmllZCBvbiBoYXJkd2FyZSwgQklPUyBWMi4wMEwyMyk6CisgKiAtIFRo
ZSBmYW4gcmVxdWVzdCBpdHNlbGYgaXMgYSBib29sZWFuIChTRUZNL0NFRk0pLCBidXQgdGhlIGN1
cnZlIGJ5dGUKKyAqICAgdGhlIEVDIG1hcHMgaXQgdG8gaXMgbW9kZWwgc3BlY2lmaWMgKENGLVNW
MTogMHgwMCBjb29sIC8gMHgwNSBxdWlldCAvCisgKiAgIDB4MDIgaW4gUzBpMywgaS5lLiB0aGUg
cXVpZXQgYW5kIFMwaTMgYnl0ZXMgYXJlIHN3YXBwZWQgcmVsYXRpdmUgdG8KKyAqICAgQ0YtU1I0
KS4gIE9ubHkgdGhlIGJvb2xlYW4gaXMgcG9ydGFibGU7IGRvIG5vdCBkb2N1bWVudCB0aGUgY3Vy
dmUKKyAqICAgYnl0ZSB2YWx1ZXMgYXMgdW5pdmVyc2FsLgorICogLSBFUExFIHJlcG9ydHMgdGhl
IFREUCBzdGF0ZSBhbmQgU0VQTCBhcHBsaWVzIGl0OyBFUExFID0gMSBzZWxlY3RzIGFuCisgKiAg
IElFVE0gdGFibGUgUEwgYW5kIEVQTEUgPSAwIG1lYW5zIG5vIGxpbWl0IChFUEwxID0gRVBMMiA9
IDB4RkYpLiAgVGhlCisgKiAgIEVDIGRlcml2ZXMgdGhlIGFjdHVhbCB2YWx1ZSBmcm9tIHRoZSBJ
RVRNIFAxNHgvUDE1eCB0YWJsZXMsIHNvIHRoZQorICogICByZXN1bHRpbmcgbGltaXQgaXMgbm90
IGEgc2luZ2xlIGZpeGVkIG51bWJlci4KKyAqIC0gX0ZTVFsxXSBpcyB0aGUgZmFuIHNldHBvaW50
IChQRU4xKSwgbm90IFJQTS4KKyAqIC0gV2hpbGUgVEZOMS5fRlNMIGhvbGRzIGEgbm9uemVybyBv
dmVycmlkZSB0aGUgRUMgaWdub3JlcyB0aGUgY3VydmUKKyAqICAgcmVnaXN0ZXIsIHNvIGEgcHJv
ZmlsZSBjaGFuZ2UgaXMgbWFza2VkIHVudGlsIHRoZSBvdmVycmlkZSBpcworICogICByZWxlYXNl
ZDsgdGhpcyBkcml2ZXIgZGVsaWJlcmF0ZWx5IGRvZXMgbm90IHRvdWNoIF9GU0wuCisgKiAtIEF0
IGJvb3QgdGhlIEVDIGNvbWVzIHVwIHdpdGggQ0VGTSA9IDAgYW5kIEVQTEUgPSAxICh0aG9zZSBh
cmUgdGhlCisgKiAgIEFNTCByZXNldCB2YWx1ZXMpLCBpLmUuIGFjdGl2ZSArIGxvY2tlZCAvIENP
T0wuCisgKi8KK3N0YXRpYyBzdHJ1Y3QgcGNjX3Byb2ZpbGVfcXVpcmsgcXVpcmtfY2Zfc3YxID0g
eworCS5wbGF0Zm9ybV9wcm9maWxlcyA9IHsKKwkJW1BMQVRGT1JNX1BST0ZJTEVfUVVJRVRdID0g
eworCQkJLmZhbl9tb2RlID0gUENDX0ZBTl9NT0RFX1BBU1NJVkUsCisJCQkudGRwX21vZGUgPSBQ
Q0NfVERQX01PREVfTE9DS0VELAorCQl9LAorCQlbUExBVEZPUk1fUFJPRklMRV9DT09MXSA9IHsK
KwkJCS5mYW5fbW9kZSA9IFBDQ19GQU5fTU9ERV9BQ1RJVkUsCisJCQkudGRwX21vZGUgPSBQQ0Nf
VERQX01PREVfTE9DS0VELAorCQl9LAorCQlbUExBVEZPUk1fUFJPRklMRV9QRVJGT1JNQU5DRV0g
PSB7CisJCQkuZmFuX21vZGUgPSBQQ0NfRkFOX01PREVfQUNUSVZFLAorCQkJLnRkcF9tb2RlID0g
UENDX1REUF9NT0RFX1VOTE9DS0VELAorCQl9LAorCX0sCit9OworCiBzdGF0aWMgc3RydWN0IHBj
Y19wcm9maWxlX3F1aXJrIHF1aXJrX2NmX3F2OSA9IHsKIAkucGxhdGZvcm1fcHJvZmlsZXMgPSB7
CiAJCVtQTEFURk9STV9QUk9GSUxFX0JBTEFOQ0VEXSA9IHsKQEAgLTM1NSw2ICszOTAsMTQgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBkbWlfc3lzdGVtX2lkIHBjY19wcm9maWxlX3F1aXJrc1tdID0g
ewogCQl9LAogCQkuZHJpdmVyX2RhdGEgPSAmcXVpcmtfY2Zfc3I0LAogCX0sCisJeworCQkuaWRl
bnQgPSAiUGFuYXNvbmljIENvcnBvcmF0aW9uIENGU1YxLTIiLAorCQkubWF0Y2hlcyA9IHsKKwkJ
CURNSV9NQVRDSChETUlfU1lTX1ZFTkRPUiwgIlBhbmFzb25pYyBDb3Jwb3JhdGlvbiIpLAorCQkJ
RE1JX01BVENIKERNSV9QUk9EVUNUX05BTUUsICJDRlNWMS0yIiksCisJCX0sCisJCS5kcml2ZXJf
ZGF0YSA9ICZxdWlya19jZl9zdjEsCisJfSwKIAl7CiAJCS5pZGVudCA9ICJQYW5hc29uaWMgQ29y
cG9yYXRpb24gQ0ZRVjktMSIsCiAJCS5tYXRjaGVzID0gewotLSAKMi41My4wCgo=

--===============7609684628121552823==
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="summary-ac.csv"
MIME-Version: 1.0

c3RhdGUsbixwa2dXX21lYW5fd2luZG93LHBrZ1dfbWluLHBrZ1dfbWF4LHBrZ190ZW1wX21heF9D
X21lZGlhbixub3RlcwpoaWdoKGFjdGl2ZSkrbG9ja2VkLDMsNi4yOCw2LjIxLDYuMzMsNDEuMCxT
RUZNL1NFUEw9MF8xCnF1aWV0KHBhc3NpdmUpK2xvY2tlZCwzLDYuMjMsNi4yMSw2LjM0LDQ1LjAs
U0VGTS9TRVBMPTFfMQpxdWlldChwYXNzaXZlKSt1bmxvY2tlZCwzLDYuMjIsNi4xOSw2LjI2LDQ3
LjAsU0VGTS9TRVBMPTFfMApoaWdoKGFjdGl2ZSkrdW5sb2NrZWQsMyw2LjIzLDYuMjIsNi4yNSw0
My4wLFNFRk0vU0VQTD0wXzAK

--===============7609684628121552823==
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="summary-battery.csv"
MIME-Version: 1.0

c3RhdGUsbixwa2dXX21lYW5fd2luZG93LHBrZ190ZW1wX21heF9DLG5vdGVzCmhpZ2goYWN0aXZl
KStsb2NrZWQsMSw5Ljk4LDQ4LjAsU0VGTS9TRVBMPTBfMTsgRVBQPXBlcmZvcm1hbmNlOyBTMElY
PVBXUlM9MApxdWlldChwYXNzaXZlKStsb2NrZWQsMSwxMC4wMSw1Ny4wLFNFRk0vU0VQTD0xXzE7
IEVQUD1wZXJmb3JtYW5jZTsgUzBJWD1QV1JTPTAKcXVpZXQocGFzc2l2ZSkrdW5sb2NrZWQsMSwx
MC40Miw2My4wLFNFRk0vU0VQTD0xXzA7IEVQUD1wZXJmb3JtYW5jZTsgUzBJWD1QV1JTPTAKaGln
aChhY3RpdmUpK3VubG9ja2VkLDEsMTAuMjAsNTMuMCxTRUZNL1NFUEw9MF8wOyBFUFA9cGVyZm9y
bWFuY2U7IFMwSVg9UFdSUz0wCg==

--===============7609684628121552823==--

