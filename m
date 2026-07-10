Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E020C00C
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710281; cv=none; b=W+cL900TTVYrpWgFywnI5ZU8u91tDSqNhLFk+dgqBOjjacnvr69RRrqGXPEOJQYe+8VCf9tpFyX/9gbEB9Yy1Ms1nB4vyBE9uYcwzexUpSkg5iMv63SsYi2+iArQYlpT2EmbI0uGx50PVjNYp3xON2P4R8i256tiZ9LLG8mhmPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710281; c=relaxed/simple;
	bh=nkslSWQOFrtE1V2nUEP1nr6yfuoqc9/x9Zolm4YHuSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWrAtkC14lPVx2uir4ZZhxHGO/pj8xXj5UPWDgnMvqm+Tzd4aAdoAul14IRmLG4rTPPUuAsiO1KjwxB10XwfznxtGGMJ7I3eUyr3kqpeCL7mcre/YnP6AuGCCEiFHDAObMLZU+R1L9IxfikRYtQHAAhoV6y7mXud0hqVhAuAPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VSIgiN/O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E4KKRy5J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VSIgiN/O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E4KKRy5J"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH3g801443830
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 19:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xsh2UtAwZF8dVDdfcIpXUpF41HpbSyTO2Zf5uTTvtjA=; b=VSIgiN/OdJOxAwl0
	rGMUILflqtHg7sE5TIOmgkyaT4iunv3HsULs67fyGANv2W4uLvkwDGVehdfaeFUu
	GB/XVqIeBuvS4rjFfiJTXu8XKepgOaPBjOGGHHgXp1rrYdI8RsLhOJXVrxAhB8MC
	P4fF6yen/EYDO+Ui/aSBWyRaNmsnWr3tMRr9Q2PuNdPQWai9MhcGEY17ZTpe2CbJ
	O0opAwJRxaq5hzV0A+6ePYLIOIX7t1swBpyKC02t2xYjKj4ZpxvLy4lnMgLjArp0
	PJicsMkb9bc9q1iR84jq/uoo6iXoLDlTF3R/VCpqk8H2kvjjQ8LjRd8wORA6uWeG
	MWRhSg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwebyqb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 19:04:40 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38869800848so2230833a91.0
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783710279; x=1784315079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xsh2UtAwZF8dVDdfcIpXUpF41HpbSyTO2Zf5uTTvtjA=;
        b=E4KKRy5J4RTicJDS/BhpeRr3/Xk8HbBOCh0GSnAmG5lf5evBIQFVFFlya3saMid2Cq
         Q++Dy5aO6L3+WdEcmfOBTGuPapWWimQ1esztDxzuWHbS1Gue4muPeKJJiJGfmQOOJMP1
         fakOw86/skbCnv1Pcoy2sbovZS3+Q2G1up0sfTUL+VNauBx/CuSoOa8wKVM1mpEgOY98
         GuvKNWiQGQaeU9biit66uzdJPizrxw5kVP7DOu1dEcc1YZsHjYsh65zAwGYDmULQ7t4X
         wB8KvwcHDrcAuoFjxivELBKMgnIbovdOlkBfz/0/9zQkhm9PHTDdGS7PemARx7CeLNyC
         HTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710279; x=1784315079;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xsh2UtAwZF8dVDdfcIpXUpF41HpbSyTO2Zf5uTTvtjA=;
        b=Hlkk0VS286HSQxmld9LO5H0l3Taj36NonbIZHAFNIAJqIvWaNYcxgkajWeYV0CwwIi
         bO2XpYzV2JJ8lAjtvPj0HP1enL7v7jGJ/HKB2VZXqmMGJeS9MfLjmq1bZkeO9+V1RA3n
         2PkJ+K81kNEnXz0HSRYmd578AJkI5zLIhYoJkAExLeumZDOvWuUWbgraSul8GphLtUHt
         jPwngaH2ZUTZk9uGTApQ73ljAcWBjPmhBojunbttkkVWgSfVFKru2SwfnkpNvEO8YpWP
         DUKbu+S1KRYchFlJPO9VnKSW9kJFXVU0WFxPLEwEPTXiDkdxQ6y2K/BokU4FHuQz90Mm
         X5bw==
X-Forwarded-Encrypted: i=1; AHgh+RqWy9IgTO0C6ick0AtVlikRqFGfQ93iIl4zHt01tfMzFwQHzcZR+b+J5CJg2qcrcw5kIMLXUxyXKt+q@vger.kernel.org
X-Gm-Message-State: AOJu0YyKhRclyHz7i2DmYanWxQMiqfkdRPWaMaqJG3b41Gh64ngsQcJq
	L+xKSsOx1/n2MttEXs2Um5Jyp7AOCI3EfY9k0A9yt24EzmHaAKmVTx6y9G5anh+uipb2e5kZ8c7
	g2u+c1fwxWHJ34m9xArK/bt4VgO+UYB5ojFk/uIlieZW17F57ZU6IaOjXi5qBu08P
X-Gm-Gg: AfdE7cmKMQf/zL9Bi/LAmwRqVU4GXAkHdu+cPr/MwBJcsI/4N4TlJQ+F+VnNyM2K6iE
	OFlB80ElY+bXZsk1xoAJy+wTTtIyms4XzGaHk1+IPWyD8+Rasc5SfTs5CYJNZ4thRqx70sR1AYr
	cXviUWE22aZaOWS05GhYSDmuHoiFdLbHCFk/joHhtML8YNrpqmKzc1tE3Eg7O1EG2SW4CXmLoqh
	nJO5VsqW6/+ih/O/FeaWU8G3a7j/lx6qmXJBxcQm9Xrh9O69nfpQuuPPb2Igf9gByHhunc3HktZ
	LWRUKCFQciqPL0WgUL2I9arzQo7S5Tx7zUz/56OVYQSXdlgsHJiROh8HDPVYQrMTfs8V+2Dw60y
	20CQABQxCd0v5+1FRauODOxfEMGCoj4AOuhPV
X-Received: by 2002:a17:90b:510b:b0:387:e0bb:57f5 with SMTP id 98e67ed59e1d1-38dc7798fdcmr201830a91.38.1783710279344;
        Fri, 10 Jul 2026 12:04:39 -0700 (PDT)
X-Received: by 2002:a17:90b:510b:b0:387:e0bb:57f5 with SMTP id 98e67ed59e1d1-38dc7798fdcmr201779a91.38.1783710278860;
        Fri, 10 Jul 2026 12:04:38 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm40533217eec.4.2026.07.10.12.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:04:38 -0700 (PDT)
Date: Fri, 10 Jul 2026 12:04:34 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo
 <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Catalin
 Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse
 <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
        Reinette Chatre
 <reinette.chatre@intel.com>,
        Fenghua Yu <fenghuay@nvidia.com>, Jonathan
 Cameron <jic23@kernel.org>,
        Srivathsa L Rao
 <srivathsa.rao@oss.qualcomm.com>,
        Ganapatrao Kulkarni
 <ganapatrao.kulkarni@oss.qualcomm.com>,
        Trilok Soni <tsoni@quicinc.com>,
        Srinivas Ramana <sramana@qti.qualcomm.com>,
        Niyas Sait
 <niyas.sait@arm.com>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/16] arm_mpam: propagate MSC write errors for
 hardware probe functions
Message-ID: <20260710120434.000011a9@oss.qualcomm.com>
In-Reply-To: <20260710144520.917375-12-andre.przywara@arm.com>
References: <20260710144520.917375-1-andre.przywara@arm.com>
	<20260710144520.917375-12-andre.przywara@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a514248 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=7CQSdrXTAAAA:8 a=00dG4hwU-RTZ5c020ZwA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE5MSBTYWx0ZWRfX7jYt6+Qr4y/Z
 C6/CnUBIUBqIy6gufrB+nyDu3WR5O+DlT0wq6IEik+2czd/zAwPXVngEfT01DiQe3d2BMMuwl9h
 qe9/RhCyrFSiei8D+EEPhAllQd4sgdrWrcBQA01hlRxlzYCP1RvqtnxFQNBZs47lu0DnaTXuyIY
 lUQoFWwnxHiB+eyUO7z1exRhnv/fhxuPFxOwfw5q8UOUiMrTdxEq7ylFLLcjVbYADPLauVr4Sph
 WYhQKkzih/uXQ0j5tNk5GEI1Gqq/dIebMv97lfg1enF2YW5qH/D4FU2evJG+9khcuCVad6yyJ9k
 nTEm7jg3alNkX+1YgEzBSyrhvOg9935V0nTDDRsmFS15B878hE5jQZESzn2vFHuxONTSJffY590
 w2J+bzehC1rjfQak7ZY8kthHcgvPw1FetEzEjNCCq1GIhvf6eVzfNCFv5uWQgCJVL2jVT2OdIVg
 PLeEzledFfrD/+MyBBQ==
X-Proofpoint-ORIG-GUID: 78R9A2Mdvke1PwX3dBeiNWfxhjISYq4J
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE5MSBTYWx0ZWRfX9rihbC8ZsSCk
 lefovUm51jAgOjkASbbmY2cfkCmxJmsnPPSKAYAhyIaJQszCokoBPkzWe1e1hk0jFG5x6MjfiOB
 JoHKNiyhVomN/PkcBZttuWOcy/0pDXw=
X-Proofpoint-GUID: 78R9A2Mdvke1PwX3dBeiNWfxhjISYq4J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100191

On Fri, 10 Jul 2026 16:45:15 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Allow the MSC write accesses in the hardware probe functions to return an
> error, and propagate write errors from the lower level up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> @@ -1080,9 +1087,11 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  		ris->idr = idr;
>  
>  		mutex_lock(&msc->part_sel_lock);
> -		__mpam_part_sel(ris_idx, 0, msc);
> -		ret = mpam_ris_hw_probe(ris);
> +		ret = __mpam_part_sel(ris_idx, 0, msc);
> +		if (!ret)
> +			ret = mpam_ris_hw_probe(ris);
>  		mutex_unlock(&msc->part_sel_lock);
> +
Similar to before, scoped_guard() and burn a few lines to get
simpler code flow.

Various other comments from earlier patches apply in this one
as well, I'm just assuming you'll make similar changes (if
you adopt them based on earlier comments)

Jonathan

>  		if (ret)
>  			return ret;
>  	}

