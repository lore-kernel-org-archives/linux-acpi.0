Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739647;
	b=jLQ8kpPNRBeXs8TggIGXaSpZJJ8NFzYQeQAYgmdrZB//LEA4KPU8OSYZTL6JWo73HE/2
	 UeKL86WbPc3JYoNU9NM+mw7BIVkmOEpmisodoZ38t1dY+XitEt3Op7vjWc9I8309b8UpN
	 IA2Zw5GCNisMMQHQuQUQSxCvfUdxu2yli4fKOTVTUAhq4K/nnjH9nroZCflCHTXESzYUF
	 lM+XIbtrcR+qMIgZLry0ANxJdwfzOocLEG6jC3G11tRmBw5EgzR3gONmAyb3ddZUt7wXY
	 hGpPmJsnVkBuk87dz/SPhAM+x48X5QlBrZRRJiIdXEj/RbeaeTsMM9wBgFWcAT6H5sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739647;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8+TGSDQ9SyPrcH/PQA7dWzaDsqGof4ZchVSIqxBGMHE=;
	b=jvXPA9u3RCcturZrE/OJ6g3wmQOn7ONQlP+DdL82yXYAB7wA5kUvw7BDHR3alh22w/KV
	 1m6qOCLdz3TDiAFqxyZ52e0wwAdeQciLS7uvceDctRaVSQmDEEcNsn+cxBuMjlGy9EsJO
	 jOc4IZ0/i1QYDzR+fpRdYnIw85NAjThnJmOm2MN14Y8FLRX8KOBKLgntRoSR9Dg8hTE3D
	 mO5cxV4IN0SbK7WY+93WP9hbqdOOjpBUvWveQ6KSQnNXjM8+Q3ahECFaaW6GplM2xlh/f
	 Hn9oR89DuIid/iVW7R4KGvXgrjDeMmKDjX+4XT4wf0/HeiZdBsDWJPa/4PSEds4TRbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DQDZ6Ikd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g9E+gh9W;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662BF606A324
	for <linux-acpi@vger.kernel.org>; Tue,  3 Nov 2026 21:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 662BF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DQDZ6Ikd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g9E+gh9W
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3IZ1Fi445336
	for <linux-acpi@vger.kernel.org>; Tue, 3 Nov 2026 21:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8+TGSDQ9SyPrcH/PQA7dWzaDsqGof4ZchVSIqxBGMHE=; b=DQDZ6IkdTD4TfR4h
	QABB8e7VWCWMVOZKatz5cG2ZupT8OhMFcFFMfNvjLbnU2huxsEnt9PzMbYcmwcKM
	rcXOmWW9SJO1ALJ4CZePlEKys80gzfsq2L2grwlmh8AUlKdVFXWJir5s4L6f0XDE
	EUukTfuK7BC61i0YYggix5dQibhKnM6eZNfv4Vu/fgiZ+J2DUHawdtOILn+DByLj
	UzT2IVNmZdakkqpm6UABaWZwMTxa+cmy0E4TEJNLcGvFrCN1x/YAsGJSh/3sOklz
	6liZgZJpwvdrivGuzDimPxa0mduchuvgSs0uBLsNzGIkFNKmnm4941/e76DqSYCO
	k87QCg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqm2pgtdt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 03 Nov 2026 21:00:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3692c5b061bso12316473eec.1
        for <linux-acpi@vger.kernel.org>; Tue, 03 Nov 2026 13:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793739646; x=1794344446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8+TGSDQ9SyPrcH/PQA7dWzaDsqGof4ZchVSIqxBGMHE=;
        b=g9E+gh9WOr1y+hZ6ZkhOEwDoltB1mXoy48+bWDVg4Kp+hdmwP7XL3bxvAhNQIyDtkc
         sP0CnnJ9P5krTnb3PWknKl7VpjEn1Ts5jY+iuT0MuMDnqubIeQmeVhReXetxOB/PDXHg
         KN2V+uQq3RWujTy3qfpM2brSEzC9mWGp2nBkHchaXgSlZrwq16RDpACMGdBNo7DjyXtf
         dP9FVy0hi2rahnzDy9VoopWqMvVchUK7N106prWd/tQmusB/Zhugomy98bZMNhKQqp46
         NeXMNiW8zr3hXSAgjTpBbwlKuef4L/DemYPHk454Szw4DJXBlvjEVyfp7Z2wwhlGJePp
         8WCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793739646; x=1794344446;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8+TGSDQ9SyPrcH/PQA7dWzaDsqGof4ZchVSIqxBGMHE=;
        b=SkTTQXhs2WA8I2X/b7rdCbSLII/Vl7XrBtuJx3ETR/VjslTzutDy6z7Rg9oBFREIws
         Sof+0tA2b934Q3Zk/JEiPuIMhZ+aadEGyttmumfPEYC23MHHKdtRzWIHqzeCfTbsURdu
         DXo/eu/uPPIWUt6QASVCirvzRqgQmqYtSKxPNP92BPr8pfALQv4o3l4mCzi5wo8qRr7L
         Q3waJDJJOlKiWe4DsUpgs03PdOfCwzSJaJ8RRICZKn+3iGAuuw12uDPHQL1QLTcNmyd5
         HpBPGIUJNw487608v/zZzDZehGjk9Tgt5yEjxrIZ6ZTtT5Ted3h0SZT/Mj0+1xpc1Uhk
         bocw==
X-Forwarded-Encrypted: i=1; AKwUvBxSH3KQnl1l5I+ClsDbYZc8zzot7zHbx90qfwNYG9n7jWvHfZNSN0sxojKDrKfaDZ+ZQkEeubC+y2DM@vger.kernel.org
X-Gm-Message-State: APuU4Z/2G+mclUP4a1wbzi8IBBQNLFVD/FABmC+hOr/JQBmFU1VZZm46
	JPaNA6cKKgHQ1tbvFvApL1v+tDhb8enurxY+zloXTRQIGJH2kpb9w8vcsuZgSmt+Poci8EGIsbt
	tu47HZD7hNAkob42IQb4N1eb2aZLjb9bJtIz/Y1ikXq535jU0nuIk59VaRzBPyBS3
X-Gm-Gg: AYBFou0l8FJ84nhP6z3uiDCaVaoUip58xs9+1CaUbZLmhPlkbPcmIPYb1ePG6wX2h3b
	a5DBN1c7wutVbn0kVN3ndE7htP7ZmHXxsQNhFPmlec5F1gdHKvnCAaVEkZ4S+75uEX0WGrDIn27
	+wB30/eQyN+vDNumYkfcHf8145m7g1kV5ccb8HQGxUg31WNffeLQSmMrAGVO1eOJh+fKzHe4XrH
	7v0gZjTKwYu6jXuCtAj21PyC2HV4CGl65wD1tQalMfGpn+YikvejrZHV7irkg+ulY9H5kOn4Wmm
	LZiRgBdo8BRvrZfUhlLK0ev+Ifyl4N7aPelHC4BM0Po6ClZ92aTmCLNmMrVZvEmyDYCbQLloAqU
	KS54MDvU6WNZKcMmntQy9qydudeJEXafLMQBDnI6iJ/huXgFXHEuKTe9xXvZO5j5ppNnwGCEH7e
	3/ciML+Q/EYEbiz63Ez99++IL0aQ==
X-Received: by 2002:a05:693c:83cf:10b0:36a:1427:3933 with SMTP id 5a478bee46e88-36a4236e7bemr23432964eec.16.1793739645646;
        Tue, 03 Nov 2026 13:00:45 -0800 (PST)
X-Received: by 2002:a05:693c:83cf:10b0:36a:1427:3933 with SMTP id 5a478bee46e88-36a4236e7bemr23432898eec.16.1793739644957;
        Tue, 03 Nov 2026 13:00:44 -0800 (PST)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm706469eec.24.2026.11.03.13.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:00:44 -0800 (PST)
Date: Tue, 3 Nov 2026 13:00:38 -0800
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
        "Rafael
 J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Tony Luck
 <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Hanjun Guo
 <guohanjun@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shuai
 Xue <xueshuai@linux.alibaba.com>,
        Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>,
        Pawel Chmielewski
 <pawel.chmielewski@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>,
        Dan Williams
 <djbw@kernel.org>, Terry Bowman <terry.bowman@amd.com>,
        Ard Biesheuvel
 <ardb@kernel.org>,
        Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 2/6] cper: add Memory Error Section 2 structures
Message-ID: <20261103130038.00000f77@oss.qualcomm.com>
In-Reply-To: <aunhE1aeSfk6YDgj@gmail.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
	<20261019203915.2019037-3-pierre.gondois@arm.com>
	<aunhE1aeSfk6YDgj@gmail.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4MyBTYWx0ZWRfX1aDxWzif04+p
 /W6vo8ds29NE5m4v+ftl195AJsS/vn+mN+wcEM7jJ6K/1KngAfCmrLLlIHlFv0Ql0VZmvHhedUj
 dHdOf1UN3RadloxswluMRBxsvbXYh8xndbmA5AhH670TxBTXV2up3vyiPZd6oC2Z+NWpB9wiaGE
 M0YGndboJIfm1RSGTO5VxkImfxn+tez5DTQNfynawKv7EHf3hA7thWDgNhCxr2EcEoZTKXFAu9w
 TsxzlOqECyuJAu0nBhp6BYD9iKwvsYQQsEcSvchh53NJtG9EVBNkN2VDnqKDvVZLyBAqtJPLIbQ
 sTE/ADQIL+oWkbcsGkJCxwBQJA73TZ9xESf6cbyJ/2GrqFgUWO/yC0qnYbj5WzUr/GlHgP+hArT
 l/IKd32aeLV4Qs8VgTXylbnJR2WbwZQtZisVLMiZvMVX2WU1FJDGQh8EkifRCeaeBzuGr1e0lxu
 1VzGhCZkzM+mFQJBHow==
X-Proofpoint-GUID: 64R_fp6mr03T799gaBTIJuwozIYf4UXR
X-Proofpoint-ORIG-GUID: 64R_fp6mr03T799gaBTIJuwozIYf4UXR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4MyBTYWx0ZWRfX6JS3brge+Etk
 GEuwyS37dRTHWY9EdkpK4B7T6AG7d134CG0Dhzgn+ueUopbUuhpFxUjwHhpOAiF/RcgTj7xAAY5
 9UH53lXm9drhSeVMhoUDUxGpyuBeFOk=
X-Authority-Analysis: v=2.4 cv=c64+0h9l c=1 sm=1 tr=0 ts=6aea4b7e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=xNf9USuDAAAA:8 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=bZ_CbDB1LfDrNmofISYA:9
 a=CjuIK1q_8ugA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030083

On Tue, 3 Nov 2026 05:27:02 -0800
Breno Leitao <leitao@debian.org> wrote:

> On Mon, Oct 19, 2026 at 10:38:41PM +0200, Pierre Gondois wrote:
> > Add CPER Memory Error Section 2 definitions to the CPER headers.
> > 
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>  
> 
> Reviewd-by: Breno Leitao <leitao@debian.org>
Typo.  Just in case Pierre is using b4 or other automation!


