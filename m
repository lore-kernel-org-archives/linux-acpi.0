Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638826;
	b=zlKAEx/+AjlOnHAKYo/fL0JuD8MdpDTTk6CZwij86DnPLlVqzHs/cjhjc20Io9e/rYGs
	 /vsq6zae6vlOBexVaqoO7KiLCnA/Wy32yiuUMPrNZj54keJ7/Lc+VhLTPM5iSekKTnqiA
	 xx/hePk4b1zGaGCw8R9/UXDbL7c5ue44d1eevTyVmAvMN62XsWUVXhF7n+TLS2PfL4zsa
	 NZy4dINeuz3Uh5JV0Eworw9d2VDAs2g5fXPXYauwdPCiUUSvPKga+8DMKbpLycApyq2BJ
	 O8LE33dEPFZWRcK4zcsiDbFgQIo//FmJN455k+Npm1dwsztl5ap0su5BbLwvfsyAZIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638826;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=XczOQ/PvC8peHst+FS7ZptxNtxHSEkyj/L5/XKB+zKY=;
	b=THXVjLFxTdJBwDFOD2RgLOfalJmHHAc3+Xr48DTBPr2lpO+zkpu6SWABXPMyXZTpm90K
	 OTmi2GEtjsZsNtJuSwN62O2Y91N6QtV62KiGi6bA5Vb5A7daHh51pk7V4yzr1FCeXCPA4
	 Yb0zzSv5QLQ1hLT4mV0HMtB47knn92DGmaE0vbIQncADawQFwwQxLra7t67OYVu8spGzo
	 SHfk3xFx6WeYxv7Qw60kv4SQJ3EuvVAtgfb7FgdfFSE+BG9HkfSuPkjyeq5PEoiK6ZPGJ
	 bSkIKUj5YAbNes3MMcNmtgczqIi7XVq2JC2/db4cQP/X3Ns0d4x4oF0dGn+JKRdVI8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T5h8GHkY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K0om4fpv;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA43060AC6EA
	for <linux-acpi@vger.kernel.org>; Mon,  2 Nov 2026 17:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA43060AC6EA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T5h8GHkY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K0om4fpv
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2GZFLB3370480
	for <linux-acpi@vger.kernel.org>; Mon, 2 Nov 2026 17:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XczOQ/PvC8peHst+FS7ZptxNtxHSEkyj/L5/XKB+zKY=; b=T5h8GHkYT7vrUwlC
	/DP6m03zEakg9PIZv3mH9WI00gaWoGZTkZK+EAdlnFNkJRDZApwsc5PXlBcAFogE
	KzBnsxTic6IO2K//BVCudRIC+HwZCEGonhE98IiYhdco1VaFYi86aie+5nUa+7FN
	ucTSEtX+8HLwA0nQvifB4gNUCTdATapNpSfx12vjdNuHvKYcjjhSy73cLfIYr1zI
	M5f+tp/KYjuTnoKld4xW0D46atgA3gd6Kts2o4TmVpgy1KvbI6V6Xk85fjYJ/XFv
	1Ue07Cm6d1bXXxZxa200F3qgDcBQ6mAQOFlMhNvZPZusRemMAAwZmGzhXsmUUB8y
	UtS0pA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsavhgg6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 02 Nov 2026 17:00:24 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1ab289bb41eso1899084c88.1
        for <linux-acpi@vger.kernel.org>; Mon, 02 Nov 2026 09:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793638823; x=1794243623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XczOQ/PvC8peHst+FS7ZptxNtxHSEkyj/L5/XKB+zKY=;
        b=K0om4fpv5ds9/A6m4xc/pL7J/qOsz8/o+rA6WfMtRtBAppAB3bZy20Yi5erSTb1+gp
         mSHorxX714RRIqD4MKNaS8pHIsAr1tYPLJpmuyqmkeObmZ47ocNfohLI240U0p+9NXyO
         MBhsWT1HveIjhbpYtviPSQki7BkOTUclAiWXHdaefT0h1mrw+N7R3ebW2U7VfX8FtVzQ
         eEAMddO28FKxd+JhnpqeoEz3A1nZvqVCZsSK3BXyhlGbtZ9cGQqVlKLWzWdg+HSRdJU0
         1GH2/F4rsoebKD9VzlO5MT1TY9viHQpf2XeeYoi44e6nTbOjmrZkhFEZJli9OK0VspXE
         Ecmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638823; x=1794243623;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XczOQ/PvC8peHst+FS7ZptxNtxHSEkyj/L5/XKB+zKY=;
        b=cupXUgFeDm9INTyr0tvgsc1WYDJa943bzwZdhagdti/pkvw/tDhjaxTNKzMag8j8kZ
         o8nzsBJO72L6wGfQVOg3mPkBLXGM6/CdNEOyDPaJOLCHcEU1tbXPeAxRFAyLprc6ec1Z
         s94FiJAzZjodBeg3N+iXUJrN53R3jnd/BPxvZCNCqiYNRF1vupY80DfzlbSOjVLMB8F7
         WFRBZOF+SYMpOosc2chB83LhFJnuViwvIphKsnC9hPxlTkNW3N1NLut4Q65vKUiBI48l
         VpQj4NtPUVZqx/tfnl4dYiS7J0m0SZ33UczzopW3Oti7foO15UWGv5k9S1BgSAaTBrg4
         u8yw==
X-Forwarded-Encrypted: i=1; AKwUvByGFLiQivSzkiXIOBQh3Ym8zHAVVVRK/lHE5oJKxzdIwNb2F1lJ04VaWjlckMEK3vE2HTkgbBNmpbtJ@vger.kernel.org
X-Gm-Message-State: AFq9FYKlX8dEvvFG0lmZ0vkDKCGtCaP5FFRI9r8iguByo88guycWp/3q
	aUrWMQK6ktoqNN2OP8j5yxBsmyfOc0pdrGbvjEkC2KCuo8Z61yK4GOIgOaEV0FwDUmadMA9Ldg2
	msSH/0MHwlni4dEyDs+Rtc5gHZKnwR3Ov3GIYhSnGlW5TG62WfsMRwfXRX4FDqzxa
X-Gm-Gg: AYBFou3AzZwgP3r96JB/MMeKqFonyVaRpbgpJPyatFR/TvoPdVie+NGjY/6G8eBYsL8
	zSWdGuWdxnPpp6aelWoBLOGD+6ouGggcKkDe/a0zYOWMvQ1G+N50Va26wJ2VNThfwDKsemu59+m
	YKBcEFBsMazJtEZO9Er+L7M29TGhiy0Vyza8xI+ZjXcBBL4q+iueTU3jc3kd1fYu+nc4zOgO0Gk
	afHOmznn1fPmoZQ4a14N6FaNPMGB4/y79QG5kef0aK9p5A3N23ztI/LdTEHn+qo6COYS7s6g13n
	jDkknNNhdilEyUXvQ5hOUtbDaKHk55KnVUtnSjAHgG6oDkMPHSYh+bDefHQ66th7QdUIO3M6vXA
	lNR8igncg1xQta+NOGZ8vZ2Znv6M0eSJnDu2qD0mkp6IYg7hB287uHRs3hrYKP2F45dqWEEQ+de
	gLJJnyGv8I2l/lR60+KVIt27usQbg=
X-Received: by 2002:a05:701b:2511:b0:182:d0a8:d1a9 with SMTP id a92af1059eb24-1a93c6ccfa7mr17653436c88.0.1793638823041;
        Mon, 02 Nov 2026 09:00:23 -0800 (PST)
X-Received: by 2002:a05:701b:2511:b0:182:d0a8:d1a9 with SMTP id a92af1059eb24-1a93c6ccfa7mr17653381c88.0.1793638822341;
        Mon, 02 Nov 2026 09:00:22 -0800 (PST)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac0e738445sm35752421c88.0.2026.11.02.09.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:00:21 -0800 (PST)
Date: Mon, 2 Nov 2026 09:00:16 -0800
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
Message-ID: <20261102090016.00006389@oss.qualcomm.com>
In-Reply-To: <20261031120053.0141d7ab@foz.lan>
References: <20261030143802.0000231d@oss.qualcomm.com>
	<20261031120053.0141d7ab@foz.lan>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2NyBTYWx0ZWRfX3AkixPTC4O0I
 wn4P9Dg8RBkuyypxqKMUgxZ42/Kva1B7F93C6BMveDLZN2nJ6VGU4kuTO2LxVt9MPb9gWjlstcC
 uRH7dyrxevmGbMqTagCYANxeHSHDj4S/PoxU+GSoPuXsnwtEdT5q31lbQey+vokoF0Hm233EH5/
 dxkRLIvyM3FBFUs1R2QIouZg5gIG4YE5qdXeXyNbcnjVAl2WCNCrYiMepKaCaOY/SjeVCzi6eFE
 0B87Gj/G89jZ78g7hv1BySuU5QryDIiUhbH6moN6OW4BpwVJbDkb7SCf8MzHA+0du62Y3oyAP2R
 6YU4ZHirlyWGWHCNc5IrcwHHx1VuUAwYbb9quIVJBpLiZhGCFmLJIoK886gpoHuGs7YgyehFq9o
 erSEV6si6432iQV0mOQt9df/iRKVbHpSbxvYElpG9/CWA/EI4bUIUaKfvF3Sa5TfTkhCvcQYAZZ
 4B9ipmRYS8Yx9e3UOCw==
X-Proofpoint-GUID: LW99fYgfMdHfQa9yCMbVahadm_kdrPVN
X-Authority-Analysis: v=2.4 cv=FZmiV5+6 c=1 sm=1 tr=0 ts=6ae8c1a8 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=36K0DMF89hYB-rcrs2oA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2NyBTYWx0ZWRfXxqTwmVD0p01I
 qv/PeExO521xw/+Ms5lP7/UlHYNvqkJZ39XlrxtZ4sOZLIy7eC1MfeaE83p0uwLxDcQsrxd2fBa
 ikLlA8Eoc9Bh9M+ihEJ4yFxQnbDqLwk=
X-Proofpoint-ORIG-GUID: LW99fYgfMdHfQa9yCMbVahadm_kdrPVN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020067

On Sat, 31 Oct 2026 12:00:53 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> On Fri, 30 Oct 2026 14:38:02 -0700
> Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:
>=20
> > Hi All,
> >=20
> > In the discussion of Pierre's patch #1 the question of how a firmware
> > could know to send the newer Memory Error Section 2 CPER rather than the
> > older record given it currently has no way of knowing what the OS suppo=
rts.
> >=20
> > Having discussed the problem inside Qualcomm, we can to the same conclu=
sion
> > as in Pierre's thread - an _OSC is probably the easiest way to solve th=
is.
> > Andrei then drew up a code first ECN proposal.  The text is below, twea=
ked
> > for plain text rendering. Link to proposal #2
> >=20
> > Please draw the attention of others to this. Feedback welcome either on
> > this thread, Pierre's thread or directly on the tianocore ticket. =20
>=20
> This sounds to be the best approach on my eyes.
>=20
> >=20
> > thanks,
> >=20
> > Jonathan
> >=20
> >=20
> > # Title: OS support for CPER Memory Error Section 2 records
> > ## Status: Draft
> > ## Document: ACPI Specification Version 6.6
> > ## License: SPDX-License-Identifier: CC-BY-4.0
> > ## Submitters: Qualcomm
> >=20
> > ## Summary of the change
> > Reserves an additional Platform-Wide OSPM Capability bit to negotiate s=
upported CPER
> > record format for Memory Error Section (older MES vs newer and richer M=
ES2).
> > Memory Error Section 2 records are defined in UEFI 2.11, Section N.2.6 =
(Appendix N, page
> > 2171).
> >=20
> > ## Benefits of the change
> > Memory Error Section 2 (MES2) records were added in UEFI Specification =
2.11, yet no
> > mechanism to negotiate OSPM support for the new record type (Linux kern=
el support is still
> > being added upstream at the moment).
> >=20
> > This change proposes using a new Platform-Wide OSPM Capability to negot=
iate between
> > firmware and the OS for enabling the new format. Until the added _OSC b=
it is reported by
> > OSPM, the older Memory Error Section records will be used. Although thi=
s means a platform
> > may in practice have to support generating both record formats, this is=
 seen as a better than
> > always emitting old- and new- style records which would leave the
> > deduplication/reconciliation up to OSPM.
> >=20
> > ## Impact of the change
> > Platform firmware should only generate CPER MES2 records if OSPM declar=
ed support for
> > MES2 records. Otherwise, platform firmware should only generate the old=
er MES records.
> >=20
> > ## Detailed description of the change [normative updates]
> >=20
> >=20
> > 6.2.11.2 Platform-Wide OSPM Capabilities
> > =E2=80=A6
> >=20
> > Table 6.13: Platform-Wide _OSC Capabilities DWORD 2
> > +---------+--------------------------+---------------------------------=
-----------------+
> > | Bits    | Field Name               | Definition                      =
                 |
> > +---------+--------------------------+---------------------------------=
-----------------+
> > | =E2=80=A6       |                          |                         =
                         |
> > +---------+--------------------------+---------------------------------=
-----------------+
> > | 22      | Functional Fixed         | The OS sets this bit to indicate=
 support for     |
> > |         | Hardware                 | the usage of Functional FixedHar=
dware            |
> > |         |                          | (FFixedHW) OperationRegions.    =
                 |
> > +---------+--------------------------+---------------------------------=
-----------------+
> > | 23      | CPER Memory Error        | The OS sets this bit to indicate=
 support for     |
> > |         | Section 2 Support        | MES2 CPER records. If not set, O=
S support for    |
> > |         |                          | older CPER MES records is assume=
d.               |
> > +---------+--------------------------+---------------------------------=
-----------------+
> > | 31:24   |                          | Reserved (must be 0)            =
                 |
> > +---------+--------------------------+---------------------------------=
-----------------+ =20
>=20
> My only concern is that it may run out of bits soon if we use those
> for each new incompatible types on CPER records.

I had the same concern.  Not sure we need to agree it on the code first sid=
e of
this proposal (as doesn't really affect implementation) but perhaps it makes
sense to have a separate OSC for RAS features.  Alternative is that we end
up with a top level _OSC number 2 when we run out of bits.

Jonathan


>=20
> >=20
> > [1] https://lore.kernel.org/all/20261019203915.2019037-1-pierre.gondois=
@arm.com/
> > [2] https://github.com/tianocore/edk2/issues/13430
> >=20
> >  =20
>=20
>=20
>=20
> Thanks,
> Mauro

