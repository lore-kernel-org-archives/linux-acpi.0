Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E997052CCD6
	for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699726; cv=none; b=IDPm3++Q8UldohP/4E1JYRRDYIxGnDBNkotkgQHLjX/uy3KBCYhhaJc4BIj2GAB/cr5UqJm7zwwQYSsWLI5e8S42KEubFk+wHg938SB6LXmsyaGOdlalLvuk2X6IvnGZ3uPui8/SzkPqo2HoVzquWUBZFLdU9TFqldgGHl5xen0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699726; c=relaxed/simple;
	bh=47rwlglKSQxfxEDXXmuEm44Dq/NXlBUlHanQleCqj5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEPdATAFCCpELBlPpHxgWdfX8gh+/jHnvP+Xt5HzVfZx8GSyR/rZrnE2kUqwcuUGnkVhg9EgX5VQCMtD5fVHuq24svLrfOxo83qwJrqrzUKaD6mhN6ctqdvO/mB5USvMn+W7NpOYWqmMfuWSaFv3azhRZC+eTJtyYMjldzQvBNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ThElj4IK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZVOxXvYG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ThElj4IK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZVOxXvYG"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TFUPUG708107
	for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 16:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QFiMMBdl/YpceHjKDolf2xod3hSnCtpF9Xk21w7Nw2A=; b=ThElj4IKoevghTAa
	4XiJQlDhMIyY1XUHykZQSTSS+vlsvajzHyW34tKwk4T9H9WSo+o2LtEABTw84mK9
	i3/s+pnm1hl7EYJzsVlfJHpyDFqlhsgxn8Iq81MzIoMOhD3BQvtzw7ofgQCzv8aj
	N6sVj1wB9vLTCew2UKGNpE7GAVjXCK30YIF4ywcxdOBLiqny2OwUEPx2jtBYS46K
	loqvi279e8mMjRHAZU6kLRlBRtxFEvekfAzbxfRCf/elUqmSUMMyBCmG0/bkW24b
	PB/w7WQJbrbQV4V7i+FWCl8GJ5xPHiQVikoRdv5mCEkV45TUc1wZSQnFjh8k7ws5
	1LVvQQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0g1kraks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 16:35:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1b8088202so3064236a12.3
        for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 09:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790699723; x=1791304523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QFiMMBdl/YpceHjKDolf2xod3hSnCtpF9Xk21w7Nw2A=;
        b=ZVOxXvYGI8R+LkJHOsuZsOq5oihaPepdALpGlygGb/FgALKuAjSlwxmZ9U6E9RVKMc
         v+clKeGCQ7YkyoFSA6sGYyqjthuMnLLD2mWPoFkeCBENBbcMzWV+eLK5ijXM0GJOopUN
         Xlth8kS7WHsgen8WJQQeAl4qREqZ9XQptUhIXSQodd7AvvfFidsSFve4O46/y6Ma1Wln
         BKP+lVBsWHhHwcaXVFIwah3xxdVQ3ZPoSIWVo7MRhH/ORj04pv03r3C4MzVLO3b7Hh1r
         Dqu3dy6oikL0EPJ87VsLx7kdpShmIsUxnNGG5a9wfQF3XRFM/ZCmd+L7KWzS0OPgbecO
         dRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699723; x=1791304523;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QFiMMBdl/YpceHjKDolf2xod3hSnCtpF9Xk21w7Nw2A=;
        b=mzEjgCrmL4xWIOQb03wAMJG8HPOWxxKcXZdNzscdrKxNzzvIqUDsY5cvf49+esYRL/
         IB7TDerdh9AqpO03Iz08Hjz/3FWusPuYSqcaTg3/oSqo8DItpluG4SmLSp6qG8JYo3SW
         T6sVImQigbdWbDMgzrWA3gJHRfd4X1u85ZYXaaJoqnJXaDPh9c5E+TKTT7B/WfdFGv8o
         ySWLRvSCHU2ZPScaR4isq2AjSFekmXSYIG51S1jd5w1/F7hkgIhrxSM7rrTvLHoHqQnv
         v6GCdIKd42mYx2txlCBRkLq5Lx1C8OfLbnnA7CGzwF8M4m6bug9+4tbBI4NlMa6SprRj
         Xl2A==
X-Forwarded-Encrypted: i=1; AKwUvBxCdXOUFe8PBGUSgQ/uaHODLXtGjwJUkzyNNO4Xov4Q1hrDx6QcCoByl9OKHxxrH7J9L5VjI6sm8w1V@vger.kernel.org
X-Gm-Message-State: AFq9FYJXOnHHCdNTdZwz2kjktlnqzAJ1OmXA7VvkTTEEccE5yr7UVBD4
	zJ9J3bNt7AT51yweMwcaA6RAHRrskH/dXUjROqIOHNcsykDprq70HDbqh3Mgi+TKtEF0jWoVxvl
	2oJzVUHhmJiHwetpy3FdELzyZIcXobxWiGwEfW2Njl9wr2UetAg4ZRYxt3XWEKDxI
X-Gm-Gg: AYBFou1c7mvTpza+C1MEz6A8Yk9oU/kG3Gz1cVQtdQ4avsDamP8KAXk0C5aN4ajxdEm
	ZpgsOc5l4nClU9cmcX/ClbWjO6cPk9Ogs6+YZ1ljPhxZ3az+mzq2v2UAZN3++n77bjjPRX2W7Xr
	WX/1bPhNYsfLkGsuXqHl5Og334SXLxb7TBNS5fVlTkxDFij55HV/4nSurnUgFTPIduIgPLmVJXd
	HscVXMYiNxnGTNzMC2Y8WikUsUGMvIUBX46/3l7+vnxH6gWqeiD10e9bAra3SomlmYDBG2kMT91
	mxPHf7kpCZOyYa6FzxtQ4xS9dF00gROPZfahE7qfoz3svyQZ3XL5FfEof0cN4lCnN6luO9IH/SV
	kVlGCNO2LOKi74Z/WYnHerERNw3hrGCPZokjeevZ9C9hqbIRxk0ChQYA=
X-Received: by 2002:a17:903:26c5:b0:2dd:c0ff:e727 with SMTP id d9443c01a7336-2df7dfd63f0mr145703335ad.57.1790699722883;
        Tue, 29 Sep 2026 09:35:22 -0700 (PDT)
X-Received: by 2002:a17:903:26c5:b0:2dd:c0ff:e727 with SMTP id d9443c01a7336-2df7dfd63f0mr145703055ad.57.1790699722348;
        Tue, 29 Sep 2026 09:35:22 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df90fbb201sm60790195ad.9.2026.09.29.09.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 09:35:21 -0700 (PDT)
Date: Tue, 29 Sep 2026 09:35:16 -0700
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
Message-ID: <20260929093516.00003781@oss.qualcomm.com>
In-Reply-To: <20260929074659.2587216-1-pierre.gondois@arm.com>
References: <20260929074659.2587216-1-pierre.gondois@arm.com>
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
X-Proofpoint-GUID: zX-yYkLYJTibqWQ4wiBxxXKu3Wb8HW1X
X-Proofpoint-ORIG-GUID: zX-yYkLYJTibqWQ4wiBxxXKu3Wb8HW1X
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2NiBTYWx0ZWRfXzb8DaBHgBnuC
 VSzpJ7JAg7KpKKR0/kKVeIkrUQZA8V78iDuVIGi5BuTQZDGuEbvJaQ76opvVNUZ+y78hq3wwfCA
 nfDvIWenBXLksmtewCAn12FNl0eCZpk=
X-Authority-Analysis: v=2.4 cv=Ysia1IYX c=1 sm=1 tr=0 ts=6abbe8cb cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=7CQSdrXTAAAA:8 a=XM342pYOwZ3m7ahhEzQA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2NiBTYWx0ZWRfX+rWJlk/UBStb
 wrvFFjzM5ntXNYbpZ1rMOA0WYHoba/W6ty/a0gEN1lDLbUmSL8+NWrVL/Sfa5SbPiHd6Oicf9Bv
 t4BnhcNMzSlMn6kZQUJ8xoETQIvkYjLXrbVv+9qwDZHvkyq/eBMeRr7L/0lHdVKFG9yMHg8IAUv
 PxTG4oFP9qccdSUw/FUTa3jBhlrDcDxNdhrdshP0mBnPM0DkvxB4xUSwmd9y1anVNTGHOVC+zRQ
 IFNlaleaikIZ9WtrfNHKTyM29JuvlPrXpeRvI7FBK2kMUj4urZr2TVfKVWbO2NslHtzprq+1cKZ
 Si0j8oF31M3mMhPv2i0YCikMVH1N/ehassEnkBaKPnUKrKeyEWT6antUS7ba0S03XyG3ZswQG79
 oaZlhIW7rRh+iDeldpABntwN/Vtg3OvinoIXq2ksZQkmYrVSCVjFomTKe9FWp5L1BwaiHm7xM2s
 LIwvnzgibzoni92EhMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290066

On Tue, 29 Sep 2026 09:45:59 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Add support for Memory Error Section 2 records.
> 
> Extend cper_mem_err_compact to hold both legacy and section-2 records.
> Add a common parser and convert the CPER, GHES, EDAC, extlog and x86 APEI
> paths to use it.
> 
> The extlog_mem_event payload layout changes with this series.
> Compatibility with existing userspace decoders still needs to be
> addressed. More specifically, the rasdaemon relies on the current
> struct cper_mem_err_compact definition.
> Either:
> A-
> this patchset should not modify struct cper_mem_err_compact and
> create a new structure to handle Memory Error Section 2 events,
> but this would ignore the similarities of Memory Error Section (1)/2
> B-
> userspace should not rely on the struct cper_mem_err_compact
> layout. extlog_mem_event trace events should instead emit data
> that relies on the actual layout of the CPER records, as defined
> in the ACPI spec.
> 
> I am looking for guidance on how to handle the above question.
> Current implementation lean toward B, but emits data in the trace
> event that maps the new/updated struct cper_mem_err_compact.

My initial thought is a no to modifying the usespace ABI.

It isn't particularly painful to just have separate handling code
for the new record.  Unfortunately the ext_log tracepoints don't
split out the fields in a fashion that would let you change
the structure.  Other RAS tracepoints do it field by field which
would have been possible to augment - even then it would have
required care to deal with field size changes.

It may be worth considering a much more 'expanded' tracepoint for
memory error section 2 to reduce similar future extension problems.
That is express ever field and don't use a compact structure at all.

Mauro, perhaps you can give input on what works better over the
long term?


Jonathan

> 
> Pierre Gondois (6):
>   ACPI: extlog: fix extlog_mem_event build issue
>   cper: add Memory Error Section 2 structures
>   cper: extend cper_mem_err_compact struct
>   cper: add helpers to handle Memory Error Section 2
>   x86/mce/apei: switch cper_sec_mem_err struct users to compact CPER
>     records
>   cper: make cper_mem_err_pack() static
> 
>  arch/x86/include/asm/mce.h     |   4 +-
>  arch/x86/kernel/acpi/apei.c    |   2 +-
>  arch/x86/kernel/cpu/mce/apei.c |   2 +-
>  drivers/acpi/acpi_extlog.c     |  23 +++-
>  drivers/acpi/apei/apei-base.c  |   2 +-
>  drivers/acpi/apei/ghes.c       |  20 +--
>  drivers/edac/ghes_edac.c       |  26 ++--
>  drivers/firmware/efi/cper.c    | 219 +++++++++++++++++++++++++++------
>  include/acpi/apei.h            |   2 +-
>  include/linux/cper.h           |  58 +++++++--
>  include/ras/ras_event.h        |   4 +-
>  11 files changed, 283 insertions(+), 79 deletions(-)
> 
> --
> 2.43.0

