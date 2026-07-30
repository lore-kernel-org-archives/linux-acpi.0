Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317E6379EC8
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436664; cv=none; b=lylfqeIWVorPhvMKqSggFjXSd3CKixl2X7NIA8Mw8W0HfSm2oW/+L2b39fyVrUR16mx5iOmOGkDattWNJ7pEdm34PbYZYPsUUKAyVIo+Q1VXCXQlwZ7bgYFE4+N39/bV+8aN6eJaSTBET9WhZm0g5sxL0TN39ObGqS/QB2vH3lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436664; c=relaxed/simple;
	bh=mievStyDcHaa9duk3AogWECujEwXabW0f4zXwtg0fls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txZ/3ITKPe9fou71Z3OwwHhrgzHx5hREbIm13MzF0TzFm/Yl+BMUJN3zikPrQUymWHUPeq4x4+fx9Wqw9uTSxS7lBtBShS7nRrmsLJof3OGWZ8BJMJMhvlczpHfhC7YvT0Nd+S/ifC+/+zZ4fSE+YHccXMHradh2laLHP9faOmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lELf3GV3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i54lw48A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lELf3GV3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i54lw48A"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UGWpY71379744
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 18:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	78jIpweogggj3Aq7tOc4mdHL+B0zSDtMeNzq8YDRKzI=; b=lELf3GV3BxWu/+3N
	Vl4lSK41Q9zAwa3qLphuVLSsTi68bydyyyYqsXybLc7B2S6FjCMWud8BFcgcQ4Rd
	d3zH9fCRxbzRT7Seku25BfrOac3im7us/NK1emau1BLuNNLFE6OCmXLjQ3HOznE1
	HKiMjkDsShIaEiMWmgbmGOnJDCSu+QEKlks/2oL/jOru3slGSBE2CC5/Z5mkRYTI
	qyqcA6GdY6A6YeQM6jdFwzj/ePZ+GpYVsMCO2uPfREVbFiSr+cc9yKDi8+YZgdbP
	p7G4gM/DOmT2+6LHZ+k3uUzYLEou4nWMSTXFbI4Iwqg9hSIdbW/1oYpNeQrNpCKz
	u+mFDA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8kn18n0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 18:37:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so221097a91.0
        for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785436655; x=1786041455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=78jIpweogggj3Aq7tOc4mdHL+B0zSDtMeNzq8YDRKzI=;
        b=i54lw48ACD1JomhhjJNSgzZYC3k5nLNhuqZQL3zldau208rJSC45y7t/FaoknOF0bR
         AFDSo3NA67zUZYZl0qtyWsFAezIg4NPZy+wPzZCln1oewYOVcIXxMniZK15j4LLITReL
         w8GDDu7fGSRtaAqbL29LFRLuE+SAHFbNeQL8qn5znyDYlks0G50fXPQHRqBk6q8jrTEh
         zuVhDTnKlpgM0j/92dopvbayZmYclAPx+JsnuVkt79DfL0kgG1tOJ4j/qc+x2RCqxkmm
         4My4PI8ZgvAwrqmNIccmVjjAf709IOO6du6ha2+oxcF9RkmNojWpimjx4H7eVuo96VbF
         z08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436655; x=1786041455;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=78jIpweogggj3Aq7tOc4mdHL+B0zSDtMeNzq8YDRKzI=;
        b=PbthVOkN4lyxTUVjzhS7+WyvVbXCbk+lvt+NF5oZYhDTm/l2OzRBzasikmdjMmJ1he
         LWyy2DeSv0SWAlt2eCWjatHNHlvnw+oHPztcKhY20NQODnOmjVsIn96qxXfTpF3BpOAM
         1UPwsuQ8AfcuMfTf/9R0PH244nwnBKOz3SVjLknTR7je5+Xe7zv4DBvKI1gz7xU7vzIw
         zg9HzkRYmCjFuxk9WvBuIRl69B2NRi97/nv8o0Ru73E+P83ruYVwKE2R1054EcAxu97r
         mHUzvUJd9nKIdpDoKkDlLYT2H/tDGjQ2ZaZEzyW+ykGnH5K/tIrVvbdsNBOjLxQoMktC
         A7KA==
X-Forwarded-Encrypted: i=1; AHgh+RoeK6IlsX7mwsEpwSCoZuZ8xRMNHaxIXrfuQPsjkE5VKu0EjTcsjBg7LR6wIi1QQg2JjosTCZVbcY8L@vger.kernel.org
X-Gm-Message-State: AOJu0YzKYgG4V30SxarHbA3NyudX74Wg4T+uSM1GK2Guam8dzXIt0gHw
	E98OTYsdEr2FX1vn1pbuj0w4/Dn5XRGRWbBCTiwVLMp+Gp0nieyVYjQP61AzPC/UIxZT+W8GokA
	WiFfMQTPq1gSa5ZMg09fadSUFvELNvP5H65trI536uzGARkqIRjZ2aI3S/nDIrAro
X-Gm-Gg: AR+sD10kmGz8D6rEoK/wRK0ZPFQ/DoilaV4DlR9JNFKD60B1QbcF3Hq1dpoPAr2Thr8
	IThCp8PC7x+klCmW5GiKAxR98KsdLx1mrVYU6E7AT8nVwSWPMNthW1c/mJxMAWi+WyosdUD8Xfz
	6FW2TOCAWLaNa9Z39wAZHZN8Tv9P4zJ1ICU9KULJOAwRVV89ew9Uq6VfDVR3IuxD0SmU7W719gs
	xcZ9OSLfayMHenYm+7Wg7oTfpvU7DhEQKi+2Kife5soDpxyi4Ql6vOncxUthR3CY7f18SRhKMzB
	WZlk9XxyKbxA6bet47k0qu1CDBY9DPfpMC5Eav1zfqEquCGbCeudCnPKG1dCiviqOcjR7KyOlTG
	nqcQVOfAi/MBMGKEBawJRgc0+Yg==
X-Received: by 2002:a17:90a:dfcf:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-38f9bda5a9cmr3056976a91.7.1785436655266;
        Thu, 30 Jul 2026 11:37:35 -0700 (PDT)
X-Received: by 2002:a17:90a:dfcf:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-38f9bda5a9cmr3056939a91.7.1785436654806;
        Thu, 30 Jul 2026 11:37:34 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b10cdcsm24287056eec.3.2026.07.30.11.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:37:34 -0700 (PDT)
Date: Thu, 30 Jul 2026 11:37:29 -0700
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
 <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
        Ritwick Sharma
 <ritwick.sharma@arm.com>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/10] arm_mpam: prepare mon_sel locking for MPAM-Fb
Message-ID: <20260730113729.000046c0@oss.qualcomm.com>
In-Reply-To: <20260730152539.2712312-8-andre.przywara@arm.com>
References: <20260730152539.2712312-1-andre.przywara@arm.com>
	<20260730152539.2712312-8-andre.przywara@arm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEzNyBTYWx0ZWRfX8yDJaAqFJAes
 MIoGfsVUm/HC9v2G9CA4dmaUxGh8EJ6fTomFga4KVc8FBKNjCwA+rOgsOW6RHTCxx/SMlqb9aU+
 0jmJjpYesvvskruErGUX8EENVTMFoqE=
X-Proofpoint-GUID: tsGQrO8qpyCjAVp-GZUFJbyrcT-8Irp9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEzNyBTYWx0ZWRfX35fQW2MEF1Z3
 hT8C+qZ1ReveUyEbxcSQtVa8ZcL5oshK7cgL/mrfiFiNIpdx10lzTnTG6WYZrlsqw8eXpAVsgZ9
 xLYjQh9YIhXbXy7DD/6KeMK3wGHW4CXO2bx4TB4xefbxILm3D0mD7dWSME7b8IwcsgkewHKesLb
 CM2hfL/pdn3ZyrgdfKOhLgRCZn9iXkuE1VttZ4AFTP9wGPKd2AwUXtkWGSgwSvnC24ruHgNuyFH
 ruBCNpDa4hynogWZ0JtXQTl40cmR8N5Ivaq1D1LLg26IMc5uZkuImX4jfA7mrXH1iDMrD5pIliA
 385CLKpJeQZzz8G8X56Y0uG7v/f06Lgs+q7pUMPsCA0Wj+dnbDgRVx7MMhYlYm3db/WvG7zi6vl
 1sYEowC0xcitl3bAzWJtTBAohle17vm2FdrePiE0wXzCRf5n+X29N84B+aG1HwCh6l9oYa9CORa
 6ZATPTdatbsaGf892XA==
X-Authority-Analysis: v=2.4 cv=V7NNF+ni c=1 sm=1 tr=0 ts=6a6b99f0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=TWr3UOjz1xACnXJDHjEA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: tsGQrO8qpyCjAVp-GZUFJbyrcT-8Irp9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300137

On Thu, 30 Jul 2026 17:25:36 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> The MSC MON_SEL register needs to be accessed from hardirq for the overflow
> interrupt, and when taking an IPI to access these registers on platforms
> where MSCs are not accesible from every CPU. This makes an irqsave
> spinlock the obvious lock to protect these registers. On systems with
> MPAM-Fb mailbox MSC access it must be able to sleep, meaning a mutex must
> be used. So MPAM-Fb platforms cannot support an overflow interrupt easily.
> Clearly these two methods can't exist for one MSC at the same time.
> 
> Change the mon_sel locking wrapper function to only use a spinlock when
> the MSC is accessed directly via MMIO. In case of MPAM-Fb, we use a
> mutex, but only if we are in a sleepable context. If that's not the
> case, we return an error. This should not happen, as MPAM-Fb by design
> does not require an MSC access to happen from a specific CPU, so there
> is no need for any IPIs or preemption disabling to satisfy CPU
> constraints. And since overflow interrupts are not supported at the moment
> anyway, we also wouldn't meet the other case.
> Bailing out early is already happening in rare occasions today.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Not sure why I didn't tag this one before.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
