Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29438F64E
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783713520; cv=none; b=KkXe6OuTa7R4fp9atk4oYrpV0Yls+4Pi9ghO5gNteFOtkEsEy70C3QQ8YEvo9V9Cv6bi5rvG5RJJNmUFPxn0h855hUithsMwNH/kZJS33YinlXctjTSyWT2hsYKke/+N1nUGreJB3mzmOLDnr3nEkqaScw5gnIX85Oq2DXi77pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783713520; c=relaxed/simple;
	bh=Sgb3V1zLwDAFN3q6+NHM1Zrxge6RiREC9mw7dCK7Aro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyrxJN71xSD4mJwDmgcRO0eVE0VWYbbwySlrdM45D5wPYbPDkv6NEPtuwmnHOf8H/bGV6uRQDzyjU5NQyHt/Jq4PyZXiM6ukklL3RrkqG80Xum1psXEfNv37xOn2SXbW2Qf6c9S8Uxy+Qtrjb98FFzwPTm9bRKdBwyb4HPTcGNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nzQCYrK8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Loi608oE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nzQCYrK8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Loi608oE"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH5FBU1407390
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 19:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5xSK4+lHSvlK826QqeBR8DeMUlV8JNVRsDYih4vnYtI=; b=nzQCYrK8LP9hgzSZ
	XKuUB3ncjjQnXD4N38nJrEftUMXMF0IQ+XdM46Xz2gQpm4dp28u8FLRZURK2DhkA
	ozbqSKlJ8TkZbg2Wbr6iDqHMI+W00NjplfUoeYl8tH/ibRuomGfqMBlLgNBxNxQN
	w3Nrerwis03C6FAXBjwWYhrNRs8tGRW/VXAlNOYZeJ4BIjQO50+NAOMJ16qJcKFO
	+HSsq9LAzKbNfPkSY2zRwBWq68N0M/g98TntGBmrzC/1CEASt+Q9KYuBu4FnZEGo
	AaMhNdhtpePoXGNrhzRre+V+qSMPp2SFNv5N9W4l+GqOhSGlfrC8/HlXPiuTSWXr
	QnctfA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5fa8xu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 19:58:38 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c891ed872ddso1903951a12.2
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 12:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783713517; x=1784318317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5xSK4+lHSvlK826QqeBR8DeMUlV8JNVRsDYih4vnYtI=;
        b=Loi608oEXCkp8RL8jkktpKPhIPb36WKYtFtVQt55oH6rlFOvfQTMRQlGiPmVjArGZ/
         TCpgjHxBlCAOTRoqsY4c+MSfFoJk60NjS+/Dv/oINSTaoO6zEXx9hrIq9zfzLaehDEDm
         /VImKxmY4xgasMX59blLIo/29hAnI9Q2XUbQpOKnQl8f3cCgeSIOpP6XHbVoSgyIRk6x
         e5sYpmXxeoWQ7PN1nwjfo84OBT3XQjcRAmdx8oFsGoEJ7/s20xcryZnYQ2bKIw9ncTYH
         rmgdN7F5kfWrgJrp9lAZ+dOEBZ4A/XCh5AXoBgHlHgZOSq9u/o7lqkiclDxMyx8zd/y3
         xjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783713517; x=1784318317;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5xSK4+lHSvlK826QqeBR8DeMUlV8JNVRsDYih4vnYtI=;
        b=eZ5T8qIgcruDmYAiakwe3zB1V+Sc5RbSmJQe4R8s5T4HxYr4QvrnhEbBtLFgDRpC6R
         U989bZDVWfpLkta4eMxKZdDNP67rRTukqlsLr0G9vJ92TaUokqILDUheRgRbf7EPaQVI
         RAUP2mMWWfH6Qopj63d678z6nTU+ypWSlJFlDu4+0vT724kj2jq5Gy3nLXV/5pbKBe6A
         ixPjL97DfgznbZmJtKeh717hCp9DUYjXP4Bumr8xBBRihFYbYdgIx+CR0bg+Ng3qYDe5
         jngTgMoHA1GeBcGdZ81/l0Riy65lFr0dLJ2qXUC8SVxZhWqa9dronCXYxKyWhLvyeLvi
         8y2w==
X-Forwarded-Encrypted: i=1; AHgh+RqWoibMxiSqfRPydXXMRuZsNmhydDY7wxbj1mFXoXKthaUy10P3W0uMWaAwP13puF+zpWthMdgJO1Tr@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw+AurbDo3NrN7RKv6vrp9JGYCHk75s9kzUM3gNnEhNCwZzUs/
	znk7TcsqQibqqj5E729bywQPbxzxLorMy7JS/5a7uL3W8BSMqtR+HG86vm3LI5iIWld6qxKO6jq
	8COMayDbUtI6eKcPg/s5PY1U1VWHPAfy4KOh6gtU3DBlkYn/Rxy9ZyHQtiC/Dx0ze
X-Gm-Gg: AfdE7ckbLv6Kd6tsul/ry6A7ALi3FmqhFCHs64wZS8YBWbQ+h2m/lTiUbzaCHoowl5/
	V4Pinp/Tt0Ay3uzSZuxu93UBHKjZG0wxti+rgFeEQmMAPA5WKush9ttdL8F89Anm5aLIAWq57yF
	i2/UmVU0uYnLsAqowbLLYCY72R5jqR5q0C9wXHc3VSrQi1AkRb4uI/eREz2qj37W82TuXmf8nxf
	1hJpTxru9G9Fj9dF6pjNF4rl4SDQXhcBJtSAvFU4jtqVUZIGUdySAA77RjHhb5T1x/3HwX3fzlS
	BdDHsfCzFmdYK6jElEF26FW9ljClRFAY/hBE+IU606aCfV5dcLnLn4sb5Tfukz61h1WchoXFfJg
	nEW6aWm5AYap7sMJQVz9ZhwLwsbFIBXuQnmET
X-Received: by 2002:a05:6a20:4328:b0:3c1:a0c:ab85 with SMTP id adf61e73a8af0-3c111095f37mr361767637.76.1783713517189;
        Fri, 10 Jul 2026 12:58:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:4328:b0:3c1:a0c:ab85 with SMTP id adf61e73a8af0-3c111095f37mr361729637.76.1783713516726;
        Fri, 10 Jul 2026 12:58:36 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b3206aaasm8187103eec.13.2026.07.10.12.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:58:36 -0700 (PDT)
Date: Fri, 10 Jul 2026 12:58:32 -0700
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
Subject: Re: [PATCH v3 14/16] arm_mpam: add MPAM-Fb MSC firmware access
 support
Message-ID: <20260710125832.00003be9@oss.qualcomm.com>
In-Reply-To: <20260710144520.917375-15-andre.przywara@arm.com>
References: <20260710144520.917375-1-andre.przywara@arm.com>
	<20260710144520.917375-15-andre.przywara@arm.com>
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
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a514eee cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=7CQSdrXTAAAA:8 a=BKSArZ9tf1QpHAMEYIoA:9 a=CjuIK1q_8ugA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: NXUkPbOdo2FOi6f1lqBT7whEsf1XYnnK
X-Proofpoint-GUID: NXUkPbOdo2FOi6f1lqBT7whEsf1XYnnK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIwMCBTYWx0ZWRfX3Y6ZjAhEReeb
 E+UDfZwpdszNVBIiwRK8f+J+7JIUxCk7P3kAhirvxzoZKfOm482A5WA6W3zU9IFRV7dXibqrUuX
 DpncuBevG4dm40HN0CZQ1weccdK1rNY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIwMCBTYWx0ZWRfXwcrffJSyTtYN
 nNn1cjvZ9A5zSe5FrKzYU3fPENVfHJEat4hnqS2/+Q05d23b/tQpv7GX/8CWbye1RkX3mOg3zdX
 bd6EkBcMnScy2wmjSLMgFwDaFBUQH9RHtv9GLfYLOxtXOAhhqTwpBTAvvSF7+ena2K1ReRMWSYz
 P14SwLxomvYsiCsfYNXj7Fp+mfNORRh50kJ93kV3uPK4gxwOLo/5JMcWhTBj9pt9BS5gvz8vay9
 XpDaQxTVncuc7qXKeDCp6CT9AfeTrg75+OgGpUo7DW+hxyObJ8FSiNFx3nUEfJbwVjtliloObBv
 UhaltkA5DFxdkHc2TUZF80o7PdUtrmawp5BEB0dgfyvv2gAbAsq+zj65AU9HApV/GR4yS4KT4n3
 qji8f0UG603jY0eYdNz5Hrhdb7yXcsvmMHijuWCnJ0zi+flW8FRMW3yCVvr2PetJgGULnNuFJqJ
 EMJhWirLYAUpVPsX54w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100200

On Fri, 10 Jul 2026 16:45:18 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> The Arm MPAM Firmware-backed (Fb) Profile document[1] describes an
> alternative way of accessing the "Memory System Components" (MSC) in an
> MPAM enabled system.

Blank line for consistency on paragraph breaks.

> Normally the MSCs are MMIO mapped, but in some implementations this

Hmm. Not sure what normal is in this case ;)  Maybe make it something like

In systems supported before this patch the MSCs are MMIO mapped,

> might not be possible (MSC located outside of the local socket, MSC
> mapped secure-only) or desirable (direct MMIO access too slow or needs
> to be mediated through a control processor). MPAM-fb standardises a
> protocol to abstract MSC accesses, building on the SCMI protocol.
> 
> Add functions that do an MSC read or write access by redirecting the
> request through a firmware interface. For now this done via an ACPI
> PCC shared memory and mailbox combination.
> 
> Since the protocol used is only a small subset of the full SCMI spec,
> and the SCMI protocol has no full ACPI support anyway, open-code the
> SCMI message generation and handshake, for just the fields we need.
> 
> [1] https://developer.arm.com/documentation/den0144/latest
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Hi Andre,

Various things inline.

Thanks,

Jonathan

...

> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index ca73029654b6..4d3e642486d4 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c

> @@ -1133,7 +1139,8 @@ static int mpam_msc_read_mbwu_l(struct mpam_msc *msc, u64 *res)
>  
>  	mpam_mon_sel_lock_held(msc);
>  
> -	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> +	if (msc->iface == MPAM_IFACE_MMIO)
> +		WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
>  	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>  
>  	ret = __mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
> @@ -1481,9 +1488,15 @@ static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
>  					 srcu_read_lock_held(&mpam_srcu)) {
>  			arg->ris = ris;
>  
> -			err = smp_call_function_any(&msc->accessibility,
> -						    __ris_msmon_read, arg,
> -						    true);
> +			if (msc->iface == MPAM_IFACE_MMIO) {
> +				err = smp_call_function_any(&msc->accessibility,
> +							    __ris_msmon_read,
> +							    arg, true);
> +			} else {
> +				__ris_msmon_read(arg);
> +				err = 0;
> +			}
> +
>  			if (!err && arg->err)
>  				err = arg->err;
FWIW
The arg->err check here seems pointless

			if (!err)
				err = arg->err;

is at most going to set a 0 to 0.

Maybe lift this into the if else as it should end up simpler in the else.

			if (msc->iface == MPAM_IFACE_MMIO) {
				err = smp_call_function_any(&msc->accessibility,
							    __ris_msmon_read,
							    arg, true);
				if (!err)
					err = arg->err;
			} else {
				__ris_msmon_read(arg);
				err = arg->err;
			}

			if (err)
				any_err = err;

 
...

> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
> new file mode 100644
> index 000000000000..7d7409910f28
> --- /dev/null
> +++ b/drivers/resctrl/mpam_fb.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2024 Arm Ltd.

Really?  sat on this for 2 years? ;) 
Given it's changing during this posting I'd at least include this
year in the range.

> +
> +#include <linux/arm_mpam.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/gfp.h>
> +#include <linux/list.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>

Scrub these for things used in this patch.
Maybe others will be needed after later patches.
Not seeing any of_ stuff in here for instance.

> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/processor.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>

> +struct mpam_fb_access_payload {
> +	u32 msc_id;
> +	u32 flags;
> +	u32 reg_offset;
> +	u32 value;
> +} __packed;
There are only a few of these in spec, and whilst they share the same layout
for fields they define (not all same length),

I'd define separate structures for each of the message types.
Added bonus being that...

> +
> +#define PCC_CHAN_FLAGS_IRQ	BIT(0)
> +#define MPAM_VERSION_MSG_SIZE	(PCC_TYPE3_MSG_PAYLOAD_OFS)
> +#define MPAM_READ_MSG_SIZE	(PCC_TYPE3_MSG_PAYLOAD_OFS + 3 * sizeof(u32))

These would then become  PCC_TYPE3_MSG_PAYLOAD_OFF + sizeof(mpam_fb_read_request_payload)
or something self describing along those lines.

> +#define MPAM_WRITE_MSG_SIZE	(PCC_TYPE3_MSG_PAYLOAD_OFS + 4 * sizeof(u32))
> +
> +static atomic_t mpam_fb_token = ATOMIC_INIT(0);
> +
> +static int mpam_fb_build_version_message(unsigned int token,
> +					 void __iomem *msg_buf)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory *pcc_shmem = msg_buf;
> +
> +	writel_relaxed(0, &pcc_shmem->flags);
> +	writel_relaxed(MPAM_VERSION_MSG_SIZE, &pcc_shmem->length);
> +	writel_relaxed(MPAM_PROTOCOL_VERSION |
> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
> +		       &pcc_shmem->command);
> +
> +	return MPAM_VERSION_MSG_SIZE;
> +}
> +
> +static int mpam_fb_build_read_message(int msc_id, int reg, unsigned int token,
> +				      void __iomem *msg_buf)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory *pcc_shmem = msg_buf;
> +	struct mpam_fb_access_payload *payload = msg_buf + sizeof(*pcc_shmem);
> +
> +	writel_relaxed(0, &pcc_shmem->flags);
> +	writel_relaxed(MPAM_READ_MSG_SIZE, &pcc_shmem->length);
> +	writel_relaxed(MPAM_MSC_READ_CMD |
> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
> +		       &pcc_shmem->command);
> +
> +	writel_relaxed(msc_id, &payload->msc_id);
> +	writel_relaxed(0, &payload->flags);
> +	writel_relaxed(reg, &payload->reg_offset);
> +
> +	return MPAM_READ_MSG_SIZE;
> +}

> +
> +static int mpam_fb_send_request(struct mpam_pcc_chan *pcc_chan, u32 msc_id,
> +				u16 reg, u32 *result, int mpam_fb_command)
> +{
> +	unsigned int token = atomic_inc_return(&mpam_fb_token);
> +	struct acpi_pcct_ext_pcc_shared_memory *pcc_shmem;
> +	struct pcc_mbox_chan *chan;
> +	void __iomem *payload_ofs;
> +	u32 status;
> +	int ret;
> +
> +	if (!pcc_chan)

Is this defense needed?  Feels like the sort of thing that is so fatal
if you get to call send_request() that you should really have failed a lot
earlier.  If it's protecting against a tear down race or similar add a comment

> +		return -ENODEV;

