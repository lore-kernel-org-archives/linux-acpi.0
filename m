Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941840;
	b=EkMzWAfEDMvuriY/RNAofVVKqxMHAln7VUOKkx+rDDW8Tfa9rnbBHwjSlXvkJdzgZm3o
	 5yOPPWVVT48wuI+lNQ5Btzpw59PwYAG9bgtl7QXRy0bbhqp0OT90g2lHQC9ZxlO/sgrG+
	 jhRnugijGacPgHdDlncVdiqw35b7b0TUekoqJqV/zddwOSnNlBoWenVaSJS7OBjeAaGLJ
	 HLKnLfUO3KBs5VOK3JkAEUfkxIP31P7pwt2gArWihNbwKLajAcB2hnYBawf7c1CRM1jW/
	 JR+TS3qFblI+GodXVxeHIA0u2aDwIMBsXhVQPMnheyQEVt5y9pUOmDVcekb01DXQFvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941840;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Ai3DgS7PjcLwlcV+R++7YBCvhY0t36X58NjShFSWSi0=;
	b=P38wiR0KWNTrWFeRl9+yWZR0xORhtrQCGlZZGvz0zNWrI5C3HIia8k8k8H67P6FTurQW
	 GNw2ekj0NkSFyun2eiZAzoI/U1e14YXCDw5GjyAleSonjn3z6qNcgPRBseVXiKs9ia1kH
	 Pt12OeyKgdROsk3IU88uBr6kZOGn0If+waty4XnLTn2QpuPaLMekQjTaPNvD3e3xRR3y4
	 XLaCcuhKaBkk+jtNdR1l1KSXnYhIKg17ML1+Ry374IErl39uV65Vm58V4y+9tBtOTmQQP
	 KiFQiVYq31p+dQkTT4L2NRiQRA+14QEf0dqY1Y7i4DMNBhj0Y20UrEADjr3hDtgnBgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FnUJs0VG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="isS1qaL/";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53759606A32C
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 18:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53759606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FnUJs0VG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=isS1qaL/
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQXhI4169471
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 18:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ai3DgS7PjcLwlcV+R++7YBCvhY0t36X58NjShFSWSi0=; b=FnUJs0VGpmIsPSSx
	0OKwgrGpmWx9fij0ipJCNPCF1kJBXnGJEHpppnRBRoCMnIjakk68amu5Hwami9kd
	zivqnaoWECqmSvelr4AS5WiDK5NfWIkR2KgVOHD/PA8vqsuaSiMlDfhepqMHepdC
	WFEkcbfR0P4zV+QlEN6uQCpprJvGgt7a1jBfWLQP4fB2gY7hG8bosqvD2MuMCm50
	OBIhCpX3HqrKTxhL/KJoZzQ33IWVuzk+DsqnlhEDOAyYWah6XLNZMWqg1LfrMflW
	bm7Dl8mNyPntbu/G1Jv5+AaMYOytMz+/B2rCeeUMyQLVTOWRd0MXnO26xI3K5q9N
	YO9lNw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hve344u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 18:57:19 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1af203073e0so131382c88.1
        for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 10:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794941839; x=1795546639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ai3DgS7PjcLwlcV+R++7YBCvhY0t36X58NjShFSWSi0=;
        b=isS1qaL/PMNRdmIB8ZuTSkHGVzX8ydFJJGkTQOkhyy0C5MU00M8unuhYk7jtGofJf3
         IXSEkZFJ5JpA2ftOGhXwMXOn0T4fLAtk1VqW+kkIu24AB2qurY3pQ8PoNhCNkZTr26BT
         itdBwTk3v9xSyRPPsOqosJmF0+WwLWgw04bjQQewWDDzugZ2bdMsRWPdiqP6iHscqtqu
         rT6CdOdUmsJ6lb7X+suo2urWXP+43uoMXpkpsleAoUmi5qDNZxR5lsbU76K4NXfpq63L
         Oxa6jOl0TfHOaKtFiMVKtYOt4/4Ic7CVJ6eLtZmEYhGBQmxGuBXPkFSkBeTKu4Ag/JYg
         UPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941839; x=1795546639;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ai3DgS7PjcLwlcV+R++7YBCvhY0t36X58NjShFSWSi0=;
        b=DRvv/8f64OnPsOz3IhE1SUx+UvOa+1ImL1bf1R/BZHYaQHGrgiP3Qrdk2lOEjIEe2+
         205axpUwapvXpsfCYUREvZGoMWV8MIrRssvT2oNHHGRh2jzyJ5KPSSHkxxZPzeK4bm2j
         WpFJxVX4PYuJoXLJ8vcJ0saIX9TJmiP7ylM+g096oP6ke2ebx9COvsk8DHEqTxlxin3L
         YLV5fxxNQuv4KWcATspiYGkzo5Wl4nwQMTqJuNILiJAS2yif2SL5uhHjE5QO7FlZqp86
         S/yp8TAdaR12EXBNwg8y/cABnHTlj6uwnMXA9LpoZH4kJ7l+KC4yMTHaZ9tUxbDTKWWm
         qBlQ==
X-Forwarded-Encrypted: i=1; AL+hErHsZcUziPDVXaQJZcJ9g9yNqC/iC8czmEHo2K4ZbsLBcU0XUgV6Rf+QqqQQ1sNkoOzrj6Zv9272hmht@vger.kernel.org
X-Gm-Message-State: APuU4Z90d+xYVFPuanhlQVf9twyyOIKQgLG2yHi6ohyfOl3alzbsEsuw
	iKju163WDOEU/ZmUFZVBM2e7rYP5dsvRssk0YwO2vdAjA7M6sSxZfV5I4L84hJ0L5LvjyTwFvJd
	oOxUhLnJXGG8PxahVmRPReTsg5CTeYpFyeL+Wnps3G1tVtCNoG5tR3j0FplwWHyos
X-Gm-Gg: AYBFou3VMC+r+VFe47zscuDy72GT44wO8CKK2yx1q9g+5XaQt1e5HvyjPy/12VQibiL
	J72CNdh7QAGtosQ+VOY3p6c/UF8q4k89XKh9+iiKb0HE0wXLqdKpozlQevhkV4QgWpTiN3L0oYd
	Z3aY8uAM866uwDM7mSd+sB9Y2vNTVUwV+v9oEEGWa4AQ9obKIoNmJL7WMN9RrYBsCHcNQeXF08T
	1ILDQ8RzaNdSNfNGCejnWVoGoN5SVj6y4QTcM9WmEcg4dDq7TJuwAvnOzZmmnpF/2nU8Yfveo1P
	E+ikBCtjcajoQcTiCz74I7c246/7ECasPj1Uz7PfzWilbA+UAAd/CDg1EAqmB1U1roNdd2d73Al
	YYZy8QcouoOwfzkwdUJDMn5LGtcjbNagS1iPzuBxYyFLkLRRXSFuDJyvPyLZwPxXcjvSCqXC6os
	zgjbkJ3p3ezSWF59wsgV79RYIf4SE=
X-Received: by 2002:a05:7022:ea44:b0:1a4:4194:fc04 with SMTP id a92af1059eb24-1b543be37cdmr396873c88.28.1794941838458;
        Tue, 17 Nov 2026 10:57:18 -0800 (PST)
X-Received: by 2002:a05:7022:ea44:b0:1a4:4194:fc04 with SMTP id a92af1059eb24-1b543be37cdmr396840c88.28.1794941837727;
        Tue, 17 Nov 2026 10:57:17 -0800 (PST)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447c5b02sm146735c88.6.2026.11.17.10.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:17 -0800 (PST)
Date: Tue, 17 Nov 2026 10:57:13 -0800
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Pierre Gondois <pierre.gondois@arm.com>, Tony Luck
 <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        "Rafael J.
 Wysocki" <rafael@kernel.org>, linux-edac@vger.kernel.org,
        Vikram Sethi
 <vsethi@nvidia.com>,
        Ashok Raj <ashok.raj@oss.qualcomm.com>,
        James Morse
 <james.morse@arm.com>, Len Brown <lenb@kernel.org>,
        Shuai Xue
 <xueshuai@linux.alibaba.com>,
        Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>,
        Pawel Chmielewski
 <pawel.chmielewski@intel.com>,
        Breno Leitao <leitao@debian.org>, Ard
 Biesheuvel <ardb@kernel.org>,
        wanghuiqiang@huawei.com
Subject: Re: RFC: ACPI code first proposal, _OSC to negotiate use of Memory
 Section 2 CPER.
Message-ID: <20261117105713.00003def@oss.qualcomm.com>
In-Reply-To: <20261102090016.00006389@oss.qualcomm.com>
References: <20261030143802.0000231d@oss.qualcomm.com>
	<20261031120053.0141d7ab@foz.lan>
	<20261102090016.00006389@oss.qualcomm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NSBTYWx0ZWRfXwqbohM8djc41
 qNfbBgEQ25nrVMtLf6Kn81zu8twYFOyhk+1Q92l8qON1lPH138OXm4Am2JMxcROb6frGcbitE30
 ZGRlDWKm+URT974BUIcNklMHDFmPms4=
X-Proofpoint-GUID: VZSDJngJMhF_AwazRiLNeoWcfYnORpxc
X-Proofpoint-ORIG-GUID: VZSDJngJMhF_AwazRiLNeoWcfYnORpxc
X-Authority-Analysis: v=2.4 cv=dqhOmFg4 c=1 sm=1 tr=0 ts=6afca38f cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=eZ8MDn2BLpX0kuXUVFYA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NSBTYWx0ZWRfXxDihSO4AfTT0
 JG+V4oe+4auE4Nrb0knMJEjxrLjAeVimstvctpSHQlowNU2+cHa0OEEH03Y+1S3J5Aw1T6Ws5tr
 QPEY/g/WJkS3suOa5l9uufsz+VuXb1HFVhkg9N3gqYQEb7RKOmj9PZmdnfUUA1rcj/eMMHXhlie
 LiZW5o49SpGO5Fv0sFQ0JH4AeWDoK5FooJSNf54dErMhfzBuLmYqIzrvGuzCujWAMhiA3w0qS4X
 n46Dk0S7vuHTzUvZBERRjwozgbIqo22p0FDtZc2pHt85lU3iekjYK7qa7S+mYadbplL553xIO+B
 M/qQ8eXvvbj/49NdwcgssYYilTQrxcB8p9RuXy2qghDYf913GlN0CI0Us1uJwdcGd1PFWbKnN4Z
 o+uHSjbaKDaNStNDO7K7NxLF2iUCZ2S1DRzxZwZOJHbrnkaViMpdty583gc5R0nAf3ByS9omZzS
 MaT5MVbCievWKbXygSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170075

On Mon, 2 Nov 2026 09:00:16 -0800
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> On Sat, 31 Oct 2026 12:00:53 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>=20
> > On Fri, 30 Oct 2026 14:38:02 -0700
> > Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:
> >  =20
> > > Hi All,
> > >=20
> > > In the discussion of Pierre's patch #1 the question of how a firmware
> > > could know to send the newer Memory Error Section 2 CPER rather than =
the
> > > older record given it currently has no way of knowing what the OS sup=
ports.
> > >=20
> > > Having discussed the problem inside Qualcomm, we can to the same conc=
lusion
> > > as in Pierre's thread - an _OSC is probably the easiest way to solve =
this.
> > > Andrei then drew up a code first ECN proposal.  The text is below, tw=
eaked
> > > for plain text rendering. Link to proposal #2
> > >=20
> > > Please draw the attention of others to this. Feedback welcome either =
on
> > > this thread, Pierre's thread or directly on the tianocore ticket.   =
=20
> >=20
> > This sounds to be the best approach on my eyes.
> >  =20
> > >=20
> > > thanks,
> > >=20
> > > Jonathan
> > >=20
> > >=20
> > > # Title: OS support for CPER Memory Error Section 2 records
> > > ## Status: Draft
> > > ## Document: ACPI Specification Version 6.6
> > > ## License: SPDX-License-Identifier: CC-BY-4.0
> > > ## Submitters: Qualcomm
> > >=20
> > > ## Summary of the change
> > > Reserves an additional Platform-Wide OSPM Capability bit to negotiate=
 supported CPER
> > > record format for Memory Error Section (older MES vs newer and richer=
 MES2).
> > > Memory Error Section 2 records are defined in UEFI 2.11, Section N.2.=
6 (Appendix N, page
> > > 2171).
> > >=20
> > > ## Benefits of the change
> > > Memory Error Section 2 (MES2) records were added in UEFI Specificatio=
n 2.11, yet no
> > > mechanism to negotiate OSPM support for the new record type (Linux ke=
rnel support is still
> > > being added upstream at the moment).
> > >=20
> > > This change proposes using a new Platform-Wide OSPM Capability to neg=
otiate between
> > > firmware and the OS for enabling the new format. Until the added _OSC=
 bit is reported by
> > > OSPM, the older Memory Error Section records will be used. Although t=
his means a platform
> > > may in practice have to support generating both record formats, this =
is seen as a better than
> > > always emitting old- and new- style records which would leave the
> > > deduplication/reconciliation up to OSPM.
> > >=20
> > > ## Impact of the change
> > > Platform firmware should only generate CPER MES2 records if OSPM decl=
ared support for
> > > MES2 records. Otherwise, platform firmware should only generate the o=
lder MES records.
> > >=20
> > > ## Detailed description of the change [normative updates]
> > >=20
> > >=20
> > > 6.2.11.2 Platform-Wide OSPM Capabilities
> > > =E2=80=A6
> > >=20
> > > Table 6.13: Platform-Wide _OSC Capabilities DWORD 2
> > > +---------+--------------------------+-------------------------------=
-------------------+
> > > | Bits    | Field Name               | Definition                    =
                   |
> > > +---------+--------------------------+-------------------------------=
-------------------+
> > > | =E2=80=A6       |                          |                       =
                           |
> > > +---------+--------------------------+-------------------------------=
-------------------+
> > > | 22      | Functional Fixed         | The OS sets this bit to indica=
te support for     |
> > > |         | Hardware                 | the usage of Functional FixedH=
ardware            |
> > > |         |                          | (FFixedHW) OperationRegions.  =
                   |
> > > +---------+--------------------------+-------------------------------=
-------------------+
> > > | 23      | CPER Memory Error        | The OS sets this bit to indica=
te support for     |
> > > |         | Section 2 Support        | MES2 CPER records. If not set,=
 OS support for    |
> > > |         |                          | older CPER MES records is assu=
med.               |
> > > +---------+--------------------------+-------------------------------=
-------------------+
> > > | 31:24   |                          | Reserved (must be 0)          =
                   |
> > > +---------+--------------------------+-------------------------------=
-------------------+   =20
> >=20
> > My only concern is that it may run out of bits soon if we use those
> > for each new incompatible types on CPER records. =20
>=20
> I had the same concern.  Not sure we need to agree it on the code first s=
ide of
> this proposal (as doesn't really affect implementation) but perhaps it ma=
kes
> sense to have a separate OSC for RAS features.  Alternative is that we end
> up with a top level _OSC number 2 when we run out of bits.
>=20
> Jonathan

Seems we need to move to a highter bit.  The plan is currently to keep it
in this DWORD though as easy enough to add more DWORDs as needed.

If anyone has additional feedback please reply to this thread or the github=
 issue in the
next week as we'd like to move this forward.

If anyone plans to look at this and wants more time, let me know and we can=
 slow
things down to allow for that!

thanks,

Jonathan

>=20
>=20
> >  =20
> > >=20
> > > [1] https://lore.kernel.org/all/20261019203915.2019037-1-pierre.gondo=
is@arm.com/
> > > [2] https://github.com/tianocore/edk2/issues/13430
> > >=20
> > >    =20
> >=20
> >=20
> >=20
> > Thanks,
> > Mauro =20
>=20

