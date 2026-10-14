Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE71562609
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996472; cv=none; b=aajrXBAA8UWo8AUsdoYu+PdY+4XdMuP/xUtV2t9qax4IW8di7ziHTr+aPVU1NAQF39NGhqUavaM7IjkiBQPLZxtzX6BABbw4p2bTEPhgUUQn/pzrK3JkCcM63vWVe+30rGcGJLqxhq3stgnknJS9W0g9e5DMK7kqDEbexJrf77Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996472; c=relaxed/simple;
	bh=ep11eUjGaRYZD5Y5tVL923e3l8aN0sPspZm3DI41NHU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmD9UcHAXQD3K14EWE3EFmXJLT076IbTgcat2K7Zyk5h66PV7Ai2oLuGg6MTs7nJmG7Q3r0TlREbq3F1lcj7yxLU7Y34Cc03w5TM8f1E2FaWVahekwtTzCrTa0CBwnOE4Pw6FWm+b5agV953o4YmYAqX9YW12mFfe2mgqXniT5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M8V7I8E5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NGTKlkuq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M8V7I8E5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NGTKlkuq"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EF4FHR4167068
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 16:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B6/IglL+b+wtFPZ5EstJiD1NM9orXL5+hMxkr3Qx2XI=; b=M8V7I8E5HgeGS4S8
	a9c5Tr8E9X2SaAREIjIFFWKD+uGumnMXVPRMJjQX6xNxdOG2L2o045+kC3PcP+Pc
	hTB9oPiggtORrRdRrYfijzEF8xXuPlMhf/wI9tAHvVJ2IJGG3dvn8bCnw1RjLbYn
	a19PMwwfJY8UWdJlrlmi8K8Iv2kfvMhFwnEjZWgNN6m+XC3bzHD0PxB/oLC8wjI4
	pwz9a2eN89NO674EKMw8xZcegr9YTDUfiajgesUe6MY7fVp144aI/xTF1FtvrbgU
	q15dhY2slV31YQ9KJssvJwBLhjoKx2rV1TUNmRr8qQvqBvBh9riQDAo8zU6hj8oG
	D7jWmQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hac230dm8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 16:47:50 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so12046275eec.1
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791996470; x=1792601270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B6/IglL+b+wtFPZ5EstJiD1NM9orXL5+hMxkr3Qx2XI=;
        b=NGTKlkuqFd4i0R8+AFOKpZJa4h9QvWUaWkPxpis94KiNQtJ8CJrEhBYHEjfdYNh9ob
         JMiOBc2tlMWk2u4LAPGoLneBD7cYRpG28hS4sdLrVSHBAmgU/ZX7Hq19xgO24kU4dvNu
         crIujZtbWv3jDNYH9xN8k1tXLL8WMapBlRrz69caosnuiEF+QUZHgjp+EbgbShAgNazz
         qAlPZauHXOhllAUct61lvcH6mTdzVxHj4mxCjYdKUZEB+P1dOerZmuFfBagm/tknipcz
         hMAT21hChGDLaEW3pppyW8RvgJVHZWaIiaulag9gGDcG//gmCXDpuuChUnvSnRAewq1N
         ijoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996470; x=1792601270;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B6/IglL+b+wtFPZ5EstJiD1NM9orXL5+hMxkr3Qx2XI=;
        b=ke1miOP/W0PRGDdusrKh4GbXneAMAcMnZNMNWJ6P3yq0kGcmyug8oMpAYAoAuXQggA
         viw0T8U7Tz8ZgPY0ao/PiRrYxNLacnZeP5Gw9QaUHJ1cz0EzpkMS68JfhmmBTeLWVgPo
         U2qh4MBIEdWCO6R1PoC9bS9wNDZm0n37lXBGS2njzOMz5u9tJzvWZNS2IfL0TOstoyGG
         EvWQhG34MmC7k4NuJvo/6J7IUZSuJfw+apwTSTCK40nS5ao5AIH1435aBUNn8DsqTaua
         XH1Evbo6GBD2/+RoKIEU1OwKNPyOo9H3E6DGjODZYsl0xlUr1BEEyxfWss5RAPGNy3j5
         vivQ==
X-Forwarded-Encrypted: i=1; AKwUvByB2HHh8OvUX7jLmvxTUWjyC2DNlYBXIoeWxBcX8wqj8qcKBcK4Q4g8tIEICBbBTre8XA89AKynkAjp@vger.kernel.org
X-Gm-Message-State: AFq9FYK9c4qlaumy2stPHFzAwxz/B+kroBWYXrI/An8dJ/9wDDE2gRBk
	GL158YfzQMRh5RoliIJxvnEuEhVOYO10FAVnspqQKEjrTPJJpefklsysxoGzdaNe0aqrbfWfoic
	chkZkemmH1hqT8Yz20497eQdRQin5NQyb9pHyoCA857nmnRU+21iTG5wwOaqsT7Eb
X-Gm-Gg: AYBFou1386YRQ2XbUt5sTl8ZxNzmEDuRFOa/qP9yOVSuyetjp0JmpMEoNL0pe3SPpLy
	eVp0wRZWbaahaaYOrGM/9Maz+Ch+eHgXEkDZcM2KiOMyHvAiRl1lqvPO7KJ2Co+FZyJYC+59xEY
	aAcOaXedap2ALubddjb2xusXxEFuYpWgvRJzL+WccjEYqIvQzyTwuJTJY9rWHx5sT396eP+oryl
	RQiy7XK0aHi1T2RUG5YgSlBQyO9GIXE2cEM+rMyhNthNhyVHgoCZT3sN84BEAHwoP0EYCnx8yiD
	ly3FfpuwPrEkDzE/vuxzQ6Qm8ZP2GksgA+e54XM+ziRSJRcG1ehTbJhO4U0HKib5o6dmVpWRSkl
	F3PlAzJITNdjVJ90MCrWGvyUxV1nIbUtk8X7Rs8KIAWqKhyV705i3ym0=
X-Received: by 2002:a05:693c:87c7:20b0:33b:fc17:e786 with SMTP id 5a478bee46e88-3537e020a08mr23634075eec.16.1791996469889;
        Wed, 14 Oct 2026 09:47:49 -0700 (PDT)
X-Received: by 2002:a05:693c:87c7:20b0:33b:fc17:e786 with SMTP id 5a478bee46e88-3537e020a08mr23634013eec.16.1791996469242;
        Wed, 14 Oct 2026 09:47:49 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35977229a6esm39681092eec.8.2026.10.14.09.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 09:47:48 -0700 (PDT)
Date: Wed, 14 Oct 2026 09:47:44 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mark
 Brown <broonie@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin"
 <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Hanjun Guo
 <guohanjun@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shuai
 Xue <xueshuai@linux.alibaba.com>,
        Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>,
        Pawel Chmielewski
 <pawel.chmielewski@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>, Radu
 Rendec <radu@rendec.net>,
        Avadhut Naik <avadhut.naik@amd.com>, Kees Cook
 <kees@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>,
        Breno Leitao
 <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
        Dan Williams
 <djbw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Morduan Zang
 <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [RFC PATCH 0/6] CPER: Add Memory Error Section 2 support
Message-ID: <20261014094744.00007c0c@oss.qualcomm.com>
In-Reply-To: <94bf3539-6a94-4efb-a57e-c0e1ecf243fd@arm.com>
References: <20260929074659.2587216-1-pierre.gondois@arm.com>
	<20260929093516.00003781@oss.qualcomm.com>
	<94bf3539-6a94-4efb-a57e-c0e1ecf243fd@arm.com>
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
X-Authority-Analysis: v=2.4 cv=PYJqFShd c=1 sm=1 tr=0 ts=6acfb236 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=7CQSdrXTAAAA:8 a=oD4Dqva4uQW2vlo4LloA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NiBTYWx0ZWRfXxlSJBo/PFdER
 asc//Nq/F4239QWg+truHJiWCb4SzCSqYXetV9BBp51kgHm5E5aIG12bD+XNzivDdPIHkvQIuhC
 mI6P9Slwct4LYT/yl53Zi5lrPNhHZKM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NiBTYWx0ZWRfX4Br3Xjcu8K5t
 z9SItNKWfYZST5tKft2klsyktQV2uEDM8uQ7XP7Zzr2KoVftRvQ+TuSWWxMODcevZdNxT/sFbwh
 aROJCooG6ue1Ukl+OzQZ9KqvOPJsq7ny/nKl3pYwqTnvJIFSWv4SZ4/LB/jPY3iMCUxKa2ZKhHg
 cOspF2XpYW9qKWFoTi2SsrUpaUUCn+DtVN5TVQy6uVRE6E9b3u+kUqq5aQVXurtUTVGHqbZTRU0
 GQjOmhf9dBfC8GHnrkaMoZtdE4auhLjqh8MhsfyWpAhEEZseMQxJ8hGuww6unXskHvBesl1p3kG
 6sRGCuOX1dflTiwvgda7dLxt5e8MNa3QRNT1+TqNVCT/ffj2AagqeRdisFNagu9IuhqUTLIcF6e
 O9iJpsFrzpzfobBgwuVOPL/CJgQr9pbWb47kybq955kHVXoOgg7aiEILS8x7THoJ0VDfClWYOB4
 lqVjG8Uq0cxrD1ESjgQ==
X-Proofpoint-GUID: sGa42sIlCF31ICQVZQIcFWjBy8A4BpiR
X-Proofpoint-ORIG-GUID: sGa42sIlCF31ICQVZQIcFWjBy8A4BpiR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140066

On Wed, 7 Oct 2026 15:35:08 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> On 9/29/26 18:35, Jonathan Cameron wrote:
> > On Tue, 29 Sep 2026 09:45:59 +0200
> > Pierre Gondois <pierre.gondois@arm.com> wrote:
> >  
> >> Add support for Memory Error Section 2 records.
> >>
> >> Extend cper_mem_err_compact to hold both legacy and section-2 records.
> >> Add a common parser and convert the CPER, GHES, EDAC, extlog and x86 APEI
> >> paths to use it.
> >>
> >> The extlog_mem_event payload layout changes with this series.
> >> Compatibility with existing userspace decoders still needs to be
> >> addressed. More specifically, the rasdaemon relies on the current
> >> struct cper_mem_err_compact definition.
> >> Either:
> >> A-
> >> this patchset should not modify struct cper_mem_err_compact and
> >> create a new structure to handle Memory Error Section 2 events,
> >> but this would ignore the similarities of Memory Error Section (1)/2
> >> B-
> >> userspace should not rely on the struct cper_mem_err_compact
> >> layout. extlog_mem_event trace events should instead emit data
> >> that relies on the actual layout of the CPER records, as defined
> >> in the ACPI spec.
> >>
> >> I am looking for guidance on how to handle the above question.
> >> Current implementation lean toward B, but emits data in the trace
> >> event that maps the new/updated struct cper_mem_err_compact.  
> > My initial thought is a no to modifying the usespace ABI.
> >
> > It isn't particularly painful to just have separate handling code
> > for the new record.  Unfortunately the ext_log tracepoints don't
> > split out the fields in a fashion that would let you change
> > the structure.  Other RAS tracepoints do it field by field which
> > would have been possible to augment - even then it would have
> > required care to deal with field size changes.
> >
> > It may be worth considering a much more 'expanded' tracepoint for
> > memory error section 2 to reduce similar future extension problems.
> > That is express ever field and don't use a compact structure at all.
> >
> > Mauro, perhaps you can give input on what works better over the
> > long term?
> >  
> Just to be sure I understand correclty, this means that you would prefer
> to add a 'struct cper_mem_err2_compact'. All the functions currently using
> 'struct cper_mem_err_compact' or 'struct cper_sec_mem_err' as input/output
> parameter would have to be duplicated right ?
> E.g. arch_apei_report_mem_error(), cper_dimm_err_location(), ...

Yes - if that's the cleanest path to not modify existing userspace ABI
(and ras tracepoints definitely count as that).


Jonathan
> 
> Regards,
> 
> Pierre
> 

