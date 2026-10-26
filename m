Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792990260;
	b=JVneODcYN6Zsh15MnrJkceF6pD5qvI9QgbkalRC97+g37pZ9xtmzzr2sV+KrcI3qgxGP
	 3xQ9JasTh9nYNLHVfzTf71Wylga4cXVY9csHu5XTEmlf8ZS4rbIDgknILErgIPVg5QrUy
	 eswlGdHzpvAOaPRw/9vQakzVtcP1s44O5fGuSQpNPr2qHTAaqtI2biPsCFnWR8oGytDLr
	 V7q2a+KDwIolei5WbmJGaROvTD1obsXsJas+ReBOczWN4unk2IaqJO4ECA3/Of2a5o3Th
	 JDzZGBphcfNuN1WJZGV6yeWd7oRkaT31uoGrVwtMpvvadtlF6JEv6Iw+iqJFAxEhgYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792990260;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:Reply-To:From:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/zLeMuPnq+PRN+qUyA9Lb/wfh2++JYWPj9vtOQkTlII=;
	b=nuYfZcW5+aNbK2n9KWOR21rM3EMVrrCMTE2CXATx7FbaYVmh/Be4JuDlMI3oAwy0vp3l
	 UeeHhwesfNbHgLwi2Lf1NhlIwgRa6jQcUljByQ4uYF7xvAwiW8udt5e44zCbm1NTPT9CH
	 R9wB0s/9SD+94tqF57iUdMKQ7nldv2YAWjANwnG7IiwnmN2u7+bqd/SGQrxL2hwBjMtWu
	 MMCcffE1JWXMYi6TSn9yL7DTWn33tN49a5tvJyjGMlvn3LLL2LwBItgxvc8I2b2Lqh/oL
	 5O++d2n7u8TEXoTQws1cKy7emB8cgfjQ5YIbRFIkCBdDthNSweju6lyC6OnfhvCNpmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WHSA6vnM;
	dkim=temperror header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GniKnp2v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEA8606A31A
	for <linux-acpi@vger.kernel.org>; Mon, 26 Oct 2026 04:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CEA8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WHSA6vnM;
	dkim=temperror header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GniKnp2v
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4arOd1181762
	for <linux-acpi@vger.kernel.org>; Mon, 26 Oct 2026 04:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=/zLeMuPnq+PRN+qUyA9Lb/wfh2++JYWPj9vtOQkTlII=; b=WH
	SA6vnMeCiMR8EvqgM6oo6Jm+PcVod2kyYd0RTXrstfPX7B3R32jVXL1XESsGVPsR
	Nkmn2wkJ48nfu23C9n0UmaxhrHE0i0AIfVnDx4mXh2dlc/AevMLhtenFLnhfnCXJ
	1TiVRaew67e+KU/JDhT/p6+Z3BBl2vcVMBwq/5PmECq1ixQzOmijMjthIx4XuAaF
	A1SksU9VR02CqrAST/cSBURfou8lIdHAcOwBzTFoUsbvlBX0+a7yc+eov9YN56bu
	YSeHmU2N0FCEAPsWFdvvUNuiRGdZV0QWqoJqDr7fmEWqsU1C7ZKCWdJTtJjjIpj0
	9Qn0pINW4udquARjtmuw==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27vssq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 26 Oct 2026 04:50:58 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-679f81e0f96so4240722d50.3
        for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2026 21:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792990258; cv=none;
        d=google.com; s=arc-20260327;
        b=rhoOUnt3eQA37ujkB6zaLfJjyJKgQf8tvB11oWufnXPYghdOAJugQhdnVPRw4sXCO9
         10E1BsP+U2iQjiA30DDI7Wih+pywtPtzORMBim5X52RnsV88CiiimVbkYgnNFopB9N2r
         msQMIl+EoTcGKtoe5wZ9fyc38U7u77rq6KqqDhafeKZYITLW0R5g4x5sZda0i5HHyiQ1
         cqD5BO+/o7OLx3mSUuLNIYxuFQIIIdeRNHs2LlJfEfPHvKAF6aoVwSwcOub0JDwMvviA
         nIDnFgX4EDWEN8WfNMpsmfwcEe9jSKFS0WB6yPLciF2clW1ojyFV0EfY5kUSLKGLeqPS
         eAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=/zLeMuPnq+PRN+qUyA9Lb/wfh2++JYWPj9vtOQkTlII=;
        fh=RZ6MGqFVovCnTF7/ZRUByLtZGcda+eFnF5WmJsORdTM=;
        b=I9pxHl6Ke1w7uN8/380aeYsdpSz6LjHtzeHNDv1ADBKfW3QQr8GlnKL/DlNTqN6YTr
         QOBQAr71zboSqE7ou+rEKtrupS5ruTdLJzadNVbV/R/u5NhlcvYJsijNE93poMtqfUD1
         VDHP814RzFj6RLoo9P3RVzf4cfHhOkwjFCiplIX2f/yf4MQZn4v22WCZjpM5SPB8TOik
         2vcei0ICUHSb2MjhJYhQn89Ag+0tg4DCDELfcSB5AX6C1kQdFbRr/6wxUVy/VIUafteT
         68EhjUR7ckpzAk9ML4TA3TUMhkfiOqVyAKmPcFSAgHqzldptTDocmx53z+BRZ6qRxM+G
         XiZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792990258; x=1793595058; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/zLeMuPnq+PRN+qUyA9Lb/wfh2++JYWPj9vtOQkTlII=;
        b=GniKnp2v2PmvrxqAX6cS4Rji+TbzlsQo9MhFVtE/md2cewROEO69qmzj8b4n4sXQFn
         ileBFc0/EaAYzF9RDe0SMFod5pE2ONdE+lL1xDCDZG9v1sYHjBMuRDOYMFpD2y5L+ap0
         g3PzLMpbliiGwzZuX8Nk8JHXEictfSlcxTBV4b74S3FvoGn1kV1WnC2v38wVoGW6KUlV
         MknMTYJrJsmboc2rTcqot9FjNT2PeJhMnag0XjdrHkRyRyIGo8o/lUV2Gk5EcGpRk9Dw
         ZvpDLtrsEBOSipN6r4GSfgdR3hsPINFFGTDgrueioN2Nn7T5mFwb2pnotToXIwMQ8X92
         ewTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792990258; x=1793595058;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/zLeMuPnq+PRN+qUyA9Lb/wfh2++JYWPj9vtOQkTlII=;
        b=1imW/V13h5AoTYJISKZBx90aL0zD0BHrHAFG43AeFkGNItvMZjkwOIqo4FZ+VpNUOl
         4I4BIPD9Bc8M/RKJcQdYSbN9EwoSEA0OnnbcO6BXsCS7bz7Qoja+92tYWjKbHcyuwA44
         WCRmuLlr0bvS+Cwn4ItEx8GIYM8CM2sXv+fbcgFM6i/blWwiadp1FQ0QRH6HwTEMZQri
         FP/caWkq/cDtOV2sT9lgHLmsSRkz/lkgvxKRkn0ny5aNU7aqEYowTS3KXBebYGftAhH4
         DRDMDg1gn2uyZCaaLCJLJXQFgx3TjH50TL9BYbYc51lDhCc4bhYMeJXR/AVjvoXDwSOi
         TvHQ==
X-Forwarded-Encrypted: i=1; AKwUvByrKmzzTtxTgg5sk3JDXl4K38+BW9X7k2kW0lNiIvZ8VNexdpZGZ+wPZMB2175Ey44PJDfe7idE5jLg@vger.kernel.org
X-Gm-Message-State: AFq9FYIG5yN2c2A/Yq/9Dt3DYZGp1ivoZJ5SIn7knaU0/zWq9z90CETT
	r+oXWp9suA9g10hpm1PV7SDl1jBKZ66rKtlsr/46owimFd/RI19yF/CIpoqKL/t5DfQKFhZCbuS
	hdxDez3Y5TQG/uZ0IZ4+X7QbcjuyWI0Wal37R40M64kKNhcoXQfi+eCJxFOWLzQSop/WGCkMCsw
	L1sn9KNKoeK7mvVedaEZdeWYpkyE7f/EbZkcgSUbM=
X-Gm-Gg: AYBFou3SytkNT4IfBQTEb54MZuBtERD3wat/PIj8axPRcf3cwHFTtHeZ61f1Wo9IGtk
	rmo6WpM9kaF9h0ZyQSJAtPPvPPdIpEzFGgxAY9zo4kiE5Uxmv9J1oPHhX4ZvTROyR8A1SBugU9+
	lmM0slKnxWu1n3TwwUP31UtJ3IQ3S7uExTFPtcuhfpNZ15DjeNRi23gJrJnXM=
X-Received: by 2002:a05:690e:1182:b0:66f:d560:32f1 with SMTP id 956f58d0204a3-67a45498ae7mr3358058d50.39.1792990257594;
        Sun, 25 Oct 2026 21:50:57 -0700 (PDT)
X-Received: by 2002:a05:690e:1182:b0:66f:d560:32f1 with SMTP id
 956f58d0204a3-67a45498ae7mr3357961d50.39.1792990251177; Sun, 25 Oct 2026
 21:50:51 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <arqSqcoWAkhy-8do@red-moon> <d1720b63-65bf-4019-bc19-1852555f7993@arm.com>
 <asieTvinZ7c2QpQm@red-moon> <CAJZ5v0hVLSJs1j8J1TV3yJ8Psyaf=B_0UfHsYSMtM5xTup0B_Q@mail.gmail.com>
 <atXyIadz1TEKSodg@red-moon> <CAJZ5v0joJBZg==DWPsNviPfL7Jo=qupRhb6GinqOLoHXGnvevg@mail.gmail.com>
 <ateI-JcExDyfXKrs@red-moon> <athimRqtDvQu1ZzA@ashevche-desk.local>
 <atiAmZSPiRNBAO5O@red-moon> <7f077fd3-9c67-409a-b46f-7f28a55c180b@arm.com>
 <atmwo3Bpi62kB8_n@red-moon> <CAJZ5v0g56LP+EQc6MQ1H_5XnQALEn3CV9Q9HGCoiuMvpkK+N+A@mail.gmail.com>
In-Reply-To: <CAJZ5v0g56LP+EQc6MQ1H_5XnQALEn3CV9Q9HGCoiuMvpkK+N+A@mail.gmail.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:20:37 +0530
X-Gm-Features: AclHuK-1DHAybX8n_MVkQPFIAt-ZTZyBKU1HsuPQ4k0q0v0UpqTvAKQZTHvj7-E
Message-ID: <CAB19ukGr39DrSXdR9Gy=YxVSXfPgYB0oqqjggQNBfedMjVtAwA@mail.gmail.com>
Subject: Re: [PATCH RFC 02/11] ACPI: Introduce irq_get() for static fwnodes
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, driver-core@lists.linux.dev,
        linux-watchdog@vger.kernel.org, Grant Likely <grant.likely@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6adedc32 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8
 a=67Uejn7MJG7rg031VH0A:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: Ne8WaK9ivwRXJm40JOzkbwW8RxCe3Y1A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAxOSBTYWx0ZWRfX0TVZkI/E80G5
 eiIuPpkn9cIQh0TwfB3eAh1JBwJqd46goEh0tRWJlppi4okVfrB7tO06MCqe0ESEKMzMRJ8Tc7B
 lwlZXgcp4J/RA1j5BdYy1WFcUrN2sBo=
X-Proofpoint-GUID: Ne8WaK9ivwRXJm40JOzkbwW8RxCe3Y1A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAxOSBTYWx0ZWRfX+/y7g54cdkwT
 OAL+61ZR6LJlB21L1hIRxqnId2uZsJ9QBtOPpFhxHUD5daq9d/ZJAF57kYeAteWK9lIx6eHTMvi
 tPjzjhDbYkcTKQVNBglrihsqEGmmkMBmNEbH1PNoQtoGuY11dkosxoVxGbl2cXHCZIGMQ80gBME
 aCKSU7+gTMz1fSxgiP/SDw4kmRYgT6gOlrXL0pSAt7ZZzuVfyUUxr/lJ+ngY+1dc0nBldhFzDuP
 dOpcqYz0rvmRB0M8SOVY1Lo9snKmK2TtvIV4qRjkf9LEbmZ9f9h6RT/rnBh/UTBDDRJHTk9r5H9
 nRlcFcm+zUsLYiZK1kkWEvtkJmNxmJ87ku9S48aU4RhDUj2EkXmFgTsFgJq6+maUZ3YpC8EV7Hs
 PwDoKvRbRb3i782Uk06t3nXPnqSw7h1J3wLGRZyNRYcKCnMHFVk0qswpHe9hO9sOnDYw6ZqFCkt
 3EZ4lSIl1K63XXm21mQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260019

On Thu, Oct 22, 2026 at 4:18=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Thu, Oct 22, 2026 at 8:43=E2=80=AFAM Lorenzo Pieralisi <lpieralisi@ker=
nel.org> wrote:
> >
> > On Wed, Oct 21, 2026 at 12:18:39PM +0100, Robin Murphy wrote:
> > > On 2026-10-21 10:06 am, Lorenzo Pieralisi wrote:
> > > > On Wed, Oct 21, 2026 at 09:58:33AM +0300, Andy Shevchenko wrote:
> > > > > On Tue, Oct 20, 2026 at 05:30:00PM +0200, Lorenzo Pieralisi wrote=
:
> > > > > > On Mon, Oct 19, 2026 at 08:05:50PM +0200, Rafael J. Wysocki (In=
tel) wrote:
> > > > > > > On Mon, Oct 19, 2026 at 12:34=E2=80=AFPM Lorenzo Pieralisi
> > > > > > > <lpieralisi@kernel.org> wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > > Basically, yes, the idea is to defer the creation of the plat=
form
> > > > > > > device until the dependency is met.
> > > > > > >
> > > > > > > > till the dependencies are cleared but then, without a _CRS,=
 where will
> > > > > > > > the consumer driver find the platform device resources ?
> > > > > > >
> > > > > > > Well, good question.
> > > > > > >
> > > > > > > > There are multiple facets in this issue and possibly some o=
f them have
> > > > > > > > been already solved but I need to pull them together.
> > > > > > > >
> > > > > > > > > Note that the dependencies can be added to acpi_dep_list =
after
> > > > > > > > > creating a struct acpi_device with acpi_add_single_object=
() and
> > > > > > > > > acpi_scan_add_dep() is not really suitable for that, but =
it should be
> > > > > > > > > doable if the dependencies can be found.
> > > > > > > > >
> > > > > > > > > > I need to have a deeper look into this next week but I =
wanted to ask first
> > > > > > > > > > whether there was something I missed - most likely.
> > > > > > > > >
> > > > > > > > > Well, it is not really straightforward.
> > > > > > > >
> > > > > > > > Yes it is getting messy. This RFC, with all its flaws, does=
 not transparently
> > > > > > > > prevents enumeration but rather relies on -EPROBE_DEFER to =
sort out
> > > > > > > > dependencies - though it does so by adding more stuff into =
ACPI static fwnode
> > > > > > > > that to be honest I'd rather see gone.
> > > > > > >
> > > > > > > I think what you need is a notification mechanism that will t=
rigger
> > > > > > > when a specific device (enumerated via the ACPI Namespace) be=
comes
> > > > > > > operational.  It doesn't look like any of the existing ones (=
platform
> > > > > > > device probe deferral or ACPI device dependencies tracking) i=
s really
> > > > > > > suitable for your use case.
> > > > > >
> > > > > > Yes. It might just be a notification from ACPI core to say "the=
 driver for
> > > > > > this ACPI device probed, go create platform devices that depend=
s on it".
> > > > > >
> > > > > > We can check and track the dependency in code that does create =
those
> > > > > > devices today.
> > > > > >
> > > > > > I will think about this to see how bad this might look like.
> > > > >
> > > > > Don't we do something similar in drivers/acpi/x86/lpss.c?
> > > >
> > > > I suppose I can add a notifier that checks whether the device whose
> > > > companion represents the ACPI device a given platform device IRQ de=
pends
> > > > on was bound to its driver and then map the IRQ and add the platfor=
m device
> > > > _then_ - after all that's what acpi_dev_clear_dependencies() does (=
similar
> > > > at least).
> > > >
> > > > There is still the question - where the GSI number, flags should be
> > > > stashed so that the notifier can grab them in a uniform way. We
> > > > could simply attach platform data storing those values to a pdev, e=
ither on
> > > > a per static table basis or generalize the data so that a single no=
tifier
> > > > would be able to deal with it.
> > > >
> > > > That or I can just piggyback on acpi_dev_clear_dependencies() and a=
dd
> > > > a separate dep mechanism to acpi_dep_data that instead of being acp=
i_handle
> > > > based the consumer is fwnode based (something Rafael mentioned befo=
re).
> > > >
> > > > I will have a stab at this and see what's the least bad solution I =
can
> > > > come up with.
> > > >
> > > > I suppose we are scrapping the -EPROBE_DEFER solution (ie this set)=
,
> > > > what we are talking about above won't need to defer anything other
> > > > than the time when platform devices are added.
> > >
> > > I dunno, that seems pretty drastic for some use-cases - the fact that=
 a GSI
> > > is described in a table doesn't necessarily mean it is critical to de=
vice
> > > operation. If we don't even create the device until all possible reso=
urces
> > > are available, then its driver never has any chance to decide whether=
 it's
> > > happy to ignore the deferral and just use MSIs or polling instead...
> >
> > I agree with you (but that's what we do for ACPI autodep and AFAICS OF
> > devlinks - though there there might be opt-outs).
> >
> > To make -EPROBE_DEFER work I have to pursue the approach undertaken in =
this
> > set and apply requested changes - I don't see any other way.
> >
> > Are we willing to accept the approach taken in this patchset (I can rem=
ove
> > software nodes and make the whole thing ACPI static nodes self-containe=
d) ?
> >
> > One way or another this ought to be sorted, please all let me know your
> > take on this.
>
> Please make it as simple as reasonably possible. :-)
>
For this use case, where platform devices are created from static ACPI
tables, I think adding fw_devlink support to ACPI is a much simpler
approach. I proposed this in [1] as a generic solution, but we later
realized that it doesn't work well for cases where dependencies need
to be established very early (_DEP/autodep worked better for such use
cases). That limitation should not apply to this particular use case,
though. So I wonder if a combination of autodep and fw_devlink will be
a better solution?

[1] - https://lists.infradead.org/pipermail/linux-riscv/2023-December/04614=
6.html

Thanks,
Sunil
