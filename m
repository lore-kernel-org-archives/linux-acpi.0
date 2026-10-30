Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396290;
	b=O+0a/jrvuYlIGX4DHBWKpwr7rSgzrnwRKo8eXVYUG7DAh8LCWktFUBIyl7o7ke2N5H2I
	 E+5x16szI3OZvR/13AEkMlKs8FUfDlv/KhwOYrpZaCeBIHY05K02QKe1dhI/8t28HZekq
	 FCqUYPcSLwjF61ClFbaCjVPecmHWiYHWt30eH3bPGZvX1PpD3lJTKel4JrhxbpYJF8pzb
	 XYpVn4SnhFnbp1xuxHjrlezDXg59h+TpY/WiGeZNLS6MpSwePhxQJFjSSbb/LEtyvSbuG
	 4gWDSy9YM0/AX46bEg6rrilh6lBFxuGAnzNuUxd5xiMkET1/A+kScTrB3sze2QpUxaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396290;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Y7/U9GX2H8fvJ+9wVzdOYrprJSq4ebt+JkWPhc94XKc=;
	b=HU8IhYZD91b/pV9Oo5qyCaqttp9RskiyMSMFBAReZfdtxK6YQNYX04FmhTaAKODePfGo
	 pJ5Tq+77hFMwxLCD37m3uatgo0WGeDjfGKyijAIhiD7FY4GQzH4wCMsmP7ZbmQlm6eZ6U
	 6P7oZBqrCdWjXznqy9dY1t0yfzUMqE6tgePwxb6qzMXN9arZeNweS+hZQw/cOFGx8+p9l
	 0o+jlfo0exCeTdRLld45vLmcFsvuTfk5En3Q+9sGJRNtFIhJOFEAum7N7OfG0vgGETZlz
	 PmcDcX28fveW5IAeZlqbhA/rb8n1Kxa1jNdtje11ix9ctFyd0iiN7Dxpc3akTt5C02g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=je8Imyj9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AKS3ZNk6;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23C2606A337
	for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 21:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B23C2606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=je8Imyj9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AKS3ZNk6
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ULAVNx3367757
	for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 21:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Y7/U9GX2H8fvJ+9wVzdOYr
	prJSq4ebt+JkWPhc94XKc=; b=je8Imyj9xD4z5u3NgPCyGUoxI3HUWIRNdW7fLv
	7VAbLqWpoCNL4uqiFFRt4Ah1srWoo4kzEcOxFvjxnfNpCzYCd2CeOl1JdnBEx2fC
	rh+CgXinOR/jpUPKotbsckxpiZ01PBhuuDZ3zpi5Hg23/xYdZzqnNf7PK4e0TjUO
	lQX3Nhlbzqsvnq3T9JYjFIB4KpFoWyD6+JKcBoUFxETqq4U4+X39UJwx1EuV7fYT
	shLO+iKZkuERB35wiP4RIH9a5jgMQYS9Y5ll59f5aTHdty1sEsQhxLuFjfpr4ceh
	5bVvHuRkM/mEEWdup5+toy8XdUONzN/gU8I5yCSadCPeQOfQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x082n7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 21:38:08 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1aa0fb7f157so1805921c88.0
        for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793396288; x=1794001088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y7/U9GX2H8fvJ+9wVzdOYrprJSq4ebt+JkWPhc94XKc=;
        b=AKS3ZNk6zsIH6wroPKaSLDQt0PUXpbBoGYp5zurxlONJCP3Qli7qozJs2N/Tg0J89M
         leH1pw/zDMAKs22O0ILoFcl7iKzVzZUiKNurtcmWnaECxSG1CI1AZ7gfTAzVV8E+mjBo
         PrJqsGzCNw3mFIjX8Ls9wJbm6+jLpfq3NmGjAX0i9TKcPKoLjR2uaXxoVHaPl4LTazEs
         PDoQ+DcF32tDzq/oYzoz+oRxZxW558uG56b6S5EZ2YSIrbC7yE4Q+1h5nOgFUNaKKlBj
         e8M5+jCdEA1m4lpc9WMHkYxwr1EkpyA9tv+WKSm26cNhyHuCOKLUnm15Wpp8X3AZ40ex
         WFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793396288; x=1794001088;
        h=content-transfer-encoding:content-type:mime-version:organization
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y7/U9GX2H8fvJ+9wVzdOYrprJSq4ebt+JkWPhc94XKc=;
        b=Y9WR1P4rBQZo6DDKGTWabMEN4iFl3dsknD+l9uD/yslaRWB1hGkTl9jEoda7y6FQJn
         LHo/RI+y6Tp/ntnVbuo8Pbe5zA6Au6HTCxs7zbl9EH5+tXBnbUSP7g04abCPM5KyQeMm
         xuSFIZXF3VR+zmT90wYj0WxNbMjaj66ReUSUIBvTdIHJS/2FrFkkbq6aLjx+DTWeE95D
         9HRvhyWy/2Rxe0SnIwYSMEPkKeBaTcz42fBx2+pdDnul1fEDVliLQ5elAJ3LzoaEy9xy
         UbmC7n5zS9H9h9mAvIY6gz1YBmOC5scdLzxpcqhK4MDT1N3Ta/MRAZxexCmDjv7QBC5W
         lESg==
X-Forwarded-Encrypted: i=1; AKwUvBwK21+cV6VY64niSy4KGiFTGAac1xzLK+jhzpWdgLs//kMsujfSpyziGSiVbIC1ZqqDj3c4FfANQnTo@vger.kernel.org
X-Gm-Message-State: AFq9FYKeXyCO09eVmZ1Ne2xwYV/vLA68468Ca7acc0jEEOk31WvqaDui
	1EHyzGDUVO7Q+OiYHj/uOem2HJFYnPA+MbQDjlzBgGpEkMV/BfY6qLSjCi8QyyRxp4tAAHfyZh5
	NOuKpnMJNqNC9LuCxSC5fGaofuOcLL4StvToV9OhbPJwObc3+FGmbhJFtRXDKq1IB
X-Gm-Gg: AYBFou2MVVNyBThp/gi/D7wc1lCTsisYZUAM0q1DqWcYX0VDMKd4nWYboeZXsm6FPCN
	8Hkc54euaZ221Hztl+B/HfRtCdhVJ8CI3H4v5y64ayP6QvMgJE38cmGrjgJ8AtCMQhGHgonhKqY
	49BfdjO0zHnwzgph2Yd+JkAbJZM37L7b7di5IeuuY8jTKH7e51nMvv5aDACVlA2BIimw/XBgqDy
	ckFwfoY1otYIDZ+tK9YD5Bbt6I6WJmXJ/uotx619Uol5xE7o9v56hPIV1KoZktQzCsRt175e7ZO
	R8UHOQErWLpn2OwJ5hb+ndkrePO7DZEt+7ldKm/OdemgJjJP72rohnaT28fj7minADVwE8JFbOY
	Pxu/SZn8AYW0qiCtjhNeDRvQeqNzmqSjIzBAtbW7DKImrb2D9g4GxQ7ZA+3eNEmlob+82xgqR3m
	hUJS54hn2XfFmidcmieM+0QxYrdBsD
X-Received: by 2002:a05:7022:b047:20b0:16d:dd5c:4261 with SMTP id a92af1059eb24-1ac5e6f4e87mr5069691c88.46.1793396287297;
        Fri, 30 Oct 2026 14:38:07 -0700 (PDT)
X-Received: by 2002:a05:7022:b047:20b0:16d:dd5c:4261 with SMTP id a92af1059eb24-1ac5e6f4e87mr5069642c88.46.1793396286564;
        Fri, 30 Oct 2026 14:38:06 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac0e738445sm9790093c88.0.2026.10.30.14.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:38:06 -0700 (PDT)
Date: Fri, 30 Oct 2026 14:38:02 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Pierre Gondois <pierre.gondois@arm.com>,
        Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Borislav
 Petkov <bp@alien8.de>,
        linux-acpi@vger.kernel.org, Mark Brown
 <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-edac@vger.kernel.org,
        Vikram Sethi <vsethi@nvidia.com>
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>, James Morse
 <james.morse@arm.com>,
        Len Brown <lenb@kernel.org>, Shuai Xue
 <xueshuai@linux.alibaba.com>,
        Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>,
        Pawel Chmielewski
 <pawel.chmielewski@intel.com>,
        Breno Leitao <leitao@debian.org>, Ard
 Biesheuvel <ardb@kernel.org>,
        wanghuiqiang@huawei.com
Subject: RFC: ACPI code first proposal, _OSC to negotiate use of Memory
 Section 2 CPER.
Message-ID: <20261030143802.0000231d@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 7cktruYu4cAi841iPad5HeWQXAhO1bgA
X-Proofpoint-GUID: 7cktruYu4cAi841iPad5HeWQXAhO1bgA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NiBTYWx0ZWRfXyEnADpyGTYSn
 i8djaLmpi5mRooOjylNnEr24cO7QpB4rmYsSevvwWi7n7FqjdBUn3Bw7O8XwZYOfUOxK5FUc3A3
 +mfC9P/EN3S2X275Vc+u5yi6nsJeh/w=
X-Authority-Analysis: v=2.4 cv=WfKZ+EhX c=1 sm=1 tr=0 ts=6ae50e40 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=NEAV23lmAAAA:8 a=WcteN8S1GE9Y4-n0fM8A:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NiBTYWx0ZWRfX5md+bJ0LRa32
 D8690K6ItaBD5O6LPktvZhkougMwok2NlRA+//YdebtCus9eHGGNMk/Pr54zvLi3RnNgo3yRR/w
 C7+iL6SF83LiRkDl+1YvzxPceiBh8wfckVRV2TyBULR9+jrZAsuu6BytGruWQdmzBtgBrbwtymp
 va8nT9fP4ADbLP2a1Obru/7iQgtEW20gnoYDrnnsK6VaqpmgSAIz+2+9zPG6R4zNwjeuylEH5eE
 r4NIKtv0XFDNRtYzVoRVWSVOHsuIx8V7maTC9EuuF4Dq/rtDaNKj19RBrIo/L54XBLItH2qkXEa
 y5BNYCtr/AmkairPHM13h61p0eK7Riw3CbA2Yvejd4RrgP8sUL7PKsl8eXXL+0TrQUjaf8cxc0q
 E3DfDMEU0N91xFg3R7UEw9CsFmmzpdS1TU1P4WYr3W3a7ZRPtosAnFsC0MQ6CfEAUO22IKihJ6W
 YifztcAjtOe1NPwekVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300086

Hi All,

In the discussion of Pierre's patch #1 the question of how a firmware
could know to send the newer Memory Error Section 2 CPER rather than the
older record given it currently has no way of knowing what the OS supports.

Having discussed the problem inside Qualcomm, we can to the same conclusion
as in Pierre's thread - an _OSC is probably the easiest way to solve this.
Andrei then drew up a code first ECN proposal.  The text is below, tweaked
for plain text rendering. Link to proposal #2

Please draw the attention of others to this. Feedback welcome either on
this thread, Pierre's thread or directly on the tianocore ticket.

thanks,

Jonathan


# Title: OS support for CPER Memory Error Section 2 records
## Status: Draft
## Document: ACPI Specification Version 6.6
## License: SPDX-License-Identifier: CC-BY-4.0
## Submitters: Qualcomm

## Summary of the change
Reserves an additional Platform-Wide OSPM Capability bit to negotiate suppo=
rted CPER
record format for Memory Error Section (older MES vs newer and richer MES2).
Memory Error Section 2 records are defined in UEFI 2.11, Section N.2.6 (App=
endix N, page
2171).

## Benefits of the change
Memory Error Section 2 (MES2) records were added in UEFI Specification 2.11=
, yet no
mechanism to negotiate OSPM support for the new record type (Linux kernel s=
upport is still
being added upstream at the moment).

This change proposes using a new Platform-Wide OSPM Capability to negotiate=
 between
firmware and the OS for enabling the new format. Until the added _OSC bit i=
s reported by
OSPM, the older Memory Error Section records will be used. Although this me=
ans a platform
may in practice have to support generating both record formats, this is see=
n as a better than
always emitting old- and new- style records which would leave the
deduplication/reconciliation up to OSPM.

## Impact of the change
Platform firmware should only generate CPER MES2 records if OSPM declared s=
upport for
MES2 records. Otherwise, platform firmware should only generate the older M=
ES records.

## Detailed description of the change [normative updates]


6.2.11.2 Platform-Wide OSPM Capabilities
=E2=80=A6

Table 6.13: Platform-Wide _OSC Capabilities DWORD 2
+---------+--------------------------+-------------------------------------=
-------------+
| Bits    | Field Name               | Definition                          =
             |
+---------+--------------------------+-------------------------------------=
-------------+
| =E2=80=A6       |                          |                             =
                     |
+---------+--------------------------+-------------------------------------=
-------------+
| 22      | Functional Fixed         | The OS sets this bit to indicate sup=
port for     |
|         | Hardware                 | the usage of Functional FixedHardwar=
e            |
|         |                          | (FFixedHW) OperationRegions.        =
             |
+---------+--------------------------+-------------------------------------=
-------------+
| 23      | CPER Memory Error        | The OS sets this bit to indicate sup=
port for     |
|         | Section 2 Support        | MES2 CPER records. If not set, OS su=
pport for    |
|         |                          | older CPER MES records is assumed.  =
             |
+---------+--------------------------+-------------------------------------=
-------------+
| 31:24   |                          | Reserved (must be 0)                =
             |
+---------+--------------------------+-------------------------------------=
-------------+

[1] https://lore.kernel.org/all/20261019203915.2019037-1-pierre.gondois@arm=
.com/
[2] https://github.com/tianocore/edk2/issues/13430


