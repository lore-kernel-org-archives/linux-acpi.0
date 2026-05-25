Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C123128C6
	for <linux-acpi@vger.kernel.org>; Mon, 25 May 2026 06:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779689149; cv=pass; b=ApPOomJsZcq0SzSSpR9uW2frE95oP0j76uOIuZgNIOxONum4bGsMuKGrGfzw4I3xaqnH6M8o1Jjf/EKD4ba5gk5uzLU/tT5btPdVpMJmle04rDjWY9LA40OYhXxW+YP1O4UpfUDTzGx3Rz3Chmixveb9m4RQYV/sQw6l7Y6xzGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779689149; c=relaxed/simple;
	bh=04/auSWx9iwIl3HVGZ5PO4ccW9WXA1lUbGB747dFmGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5tBGPV8LRuOLCeQw3Bw8m133UIr2tMQb4NOXCPM9BYam80eq72phkaETcOk5/Qg66qu27l8JOxesJ84Y8IiNhQ6z46bz7kegXO3tJYolussVWgm7EQ54RoRusd2vAShndFuO2lMurlpkCgJ3AZpGhsaothr+jFuJZm6CkCijOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=arQyRi8B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hOPlg0qv; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="arQyRi8B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hOPlg0qv"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ONZRQK920635
	for <linux-acpi@vger.kernel.org>; Mon, 25 May 2026 06:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=0m8zTAYDEiVM0XLZgjIUa0BVssyY1lfaYhWeExB/N/A=; b=ar
	QyRi8BfYskQCd4kegmQpAqT8FselhseQuLnniC530aApI5YU0RE0qQajtCe6hUo1
	B5WDrzPKyd7kpk8PqZzlDonqC6cwPcp0jy5xeMT8MC/IdpQS9xor/x0C9yI+mNzv
	VnZMRmuvBIOo88Si/pCS4zctJ+AI89N+CKv9u50pXAmoycl4yVRSDE1FOYEWBQFK
	YU2spcbZhNKKyG7y9cFGbmEysDkE+0DbgZW4jzJUo5jCLZw/J5nTYprfbvt/PG3K
	OeUxsgaeqoJQF92jzr81CSzFQDt2GmMs/AKSLZXoA0KIObx+VvlnBLwcpCpBApkH
	YWbaD96a5nt52wC7spjA==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4f3d4v6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 25 May 2026 06:05:45 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-65c396d3940so17087116d50.3
        for <linux-acpi@vger.kernel.org>; Sun, 24 May 2026 23:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779689145; cv=none;
        d=google.com; s=arc-20240605;
        b=UUW/uNSW13nLTGuO9P6eyb+yYIEMEiX3ZgRfXfe6Ei8JDoRHfFUduKTu6tOPlX+R4N
         UL7aaE0nhwhK1aYnuh3osWlhBTvAAjuDEqoTgpq7nwv/NYqrYdBUNIzU7evECvYOwykk
         J2iSgnMNttnUqd+UcqvOFb+EAyvCWZ1726fq9wsapQ+1VhmbPdDjuynXGwur3t9gWrix
         MsGSVk6Py7ZZ5Gxbqt+/38PYNmbOOgL4kcR5A26imu1qS2NktB1SOec0UryjQszLnL9b
         7jv6eQuZ1ElYMF/iW+IohD49FHkknVy1wiRVBl7RBBXV+/M0l/XbAqh9ySgnnJPtv7Nt
         IzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=0m8zTAYDEiVM0XLZgjIUa0BVssyY1lfaYhWeExB/N/A=;
        fh=0u9SMia4/3kVfk3iIJrj98TFg1caNCkXOn9DrgZMdJs=;
        b=E/00B8w6uCXPA75VqQL/c/CeRHiOFaIgssuAj2R+GrVlujHGJklCfL47Spjr1JFoAO
         yAg76ImBm9qAUH4VY1yw7UjkR1ZIcQyFcden8IRIfQj5G1v1bJTBCnQezQ2/XxeE+GEc
         wVj3h1QRgWY7JeMRN5zkjexXBg60E56JPn+W/M0IUdL+x4Cn477DOQnJ0UtZNZ2vgZdC
         vHe6RluEGVnbt1q6is9lRC7hMefAKgpRvnXi6lTSI4TbLMEBS1VLWs4s44o1zTqpW3h+
         aM4W84Hr3r3hM/mKxkb8Dc8M5rHBqiQcvk0OOzTMGTic3Ju5iFMfxAQEzzrXtpmQ9kd3
         2SUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779689145; x=1780293945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0m8zTAYDEiVM0XLZgjIUa0BVssyY1lfaYhWeExB/N/A=;
        b=hOPlg0qvLKLLIKHxa4Rm2eC8X59u6z5xhQYi7fiCHwxe36rUvklGeJlAPwYy1rELQc
         35+hjpZ2szo1VzcLf9vQWy/ra86gbk0u4Ep8etKEal3fK0llKbXj8hU+YWEm1ALqW7TI
         NBKpSkvua8VlwlM7XzfAPIbVkQxiiv77/+yOS9exzTD01vSxW2p79vxlLUog2LAl1ZG4
         pEWgDaWqAh+dW9EvFlR1lBZ4L8JjFOYmXFUEYBlNm5RcItwkcKw7ceTv2PabSQ2m/Oh/
         WZh241ZdaF/rHQsVohHCoqoI6YTbNtu41RgLVjVXiOTUnF00SvEZ54Dof+ZTSHLyMfpV
         ycoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779689145; x=1780293945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0m8zTAYDEiVM0XLZgjIUa0BVssyY1lfaYhWeExB/N/A=;
        b=HSGcdp9E/aLN6YiDURJJu+uXH8XHUE1mjRuQnHyh6vlvWcJl2OyV9V0VYjZF4Y6nDO
         F4EVtsvMXZEVa8uf5SfcgmmWDrSbnlwhFmT06TXjPtew7BrmCzrulVdOR3kLuFXXRQ9F
         JOt6Nd+1Gq3cIh8ciAmR3cHo0jQSrYVpAYsEXnF09OTI1zwaR9cU4DDrFggSpdHTMkBw
         +lYs8lR8yL8/w6OOJjKNNHKBAjKt8tb8voCHV4b7yvuqXO4i9yLJpbBvVo3wOzlpoC8U
         qJXqyXuNBimj8zDKvIIlK0J0RDxkEdQqAv1lWHQASQMKFFnrFptNCikUmvMkT2cgsQAQ
         yQdA==
X-Forwarded-Encrypted: i=1; AFNElJ/MZyp8ZZPuSJeEIV3q0MGD7HCaTiexSTECSdTirxmxzUoemcJznjOWMf1uY8NpiiWQ6ZqkJuNk4hL5@vger.kernel.org
X-Gm-Message-State: AOJu0YwLdGVIEiZfdnLLXNCmQHzXuHvFaIPSqA3R4bo4U5m4T+TjHYxK
	n2QHds+CFwcX8aNl6edQoR3yLoLOWONxgv9AFZqahZC6ehdndMRgWzZoUZ/+AAqhszafoEanPw8
	cGdioHEuZPJP4Y/2+2z59c0YLqwZZK/5mBzk0gllyiMIoXnsRoDh02OeDrOTuOWf6YEfsn/Nkqt
	nTcBh2HyTwvHrju1kL5DgXlPm+ddPmwA3C287jJbs=
X-Gm-Gg: Acq92OEKcO/zT3XWHhAbwaD+eMiToGzd4PBEMN76k9/MhI1tfnCFrAX2+du1MvkbfoE
	KGoQHBZK63zkMb2Lv37j5DIiD6jwZAeN0/gGiOkl8Qx9Qnh3ghlagwbT/7eBloX+4b4TUijBNSv
	bW/0Ncu2zdBhZG/3pZ2hqlz7fPSrp8g3R6EVU0WmJ2LgMe03e8hErVXkOLLAJMnpkGvIMng7e1b
	Oo8zQBZ
X-Received: by 2002:a05:690e:d4a:b0:65c:2738:c6ad with SMTP id 956f58d0204a3-65ec97cb3ddmr14519401d50.17.1779689144678;
        Sun, 24 May 2026 23:05:44 -0700 (PDT)
X-Received: by 2002:a05:690e:d4a:b0:65c:2738:c6ad with SMTP id
 956f58d0204a3-65ec97cb3ddmr14519366d50.17.1779689144283; Sun, 24 May 2026
 23:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519090928.1952787-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260519090928.1952787-1-maoyixie.tju@gmail.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Mon, 25 May 2026 11:35:33 +0530
X-Gm-Features: AVHnY4IRGuUiYnMe6dXGsX3It310HZfoQGBbPW7POERO3lN-yzhhJmRuZt_XgQ8
Message-ID: <CAB19ukFfwjJEyE0MX+u7zK8TO0g_AKen1AAF-ig4NH3-aHWgQQ@mail.gmail.com>
Subject: Re: acpi/riscv: iterator after loop end in riscv_acpi_register_ext_intc?
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: dgUUWrR78ShltqQY2EXhUs23E9WhM3uv
X-Authority-Analysis: v=2.4 cv=WvYb99fv c=1 sm=1 tr=0 ts=6a13e6b9 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8 a=9prIHcOmAL0soUL90jwA:9
 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA1OCBTYWx0ZWRfX+Rp2xU/xU2Je
 cmcpzDeB/xfWEDT6w1m2LGZgj7fjrjVLReARjFCOpthz/0XfGlMSz8it4pJ7htDdjB7tt8W5m2c
 LGp2nW3OMY+Eg33W0uz8zQeqcMfUS2Y2TTvpU9Z8dO5hDusCDecgw/G9Rwp5BcgAjAL6a+ZXzlJ
 D7cQJfTcDVq3zUlIwbdV0u2IQ/i0orX7zAzvgdVwyLmQTFswN1rVTiferB9yaEDn/Cq+lYsJw0l
 HCsVSBYBWH/EPVQBtZrJ+yS/E7ELgtryl4/7hUr3FNrKI9NYjNFokhI8yK1xMeljN9fMlTvcZ6Y
 qNbWgJl9udLpRvCfT8DWZBs/15DYtGbt+lUHV6RXW5J3ICWSkHv0BS+dJv/jyRqX8YsznHAonpA
 GbAwxC6mlcJ2JT0Qhp0SSUqKLy1R7SsV3VfKg9Yzg5XeFA2dqjqlbcQ7x6U/kRgRceYlbeeDWix
 K8e75roQRnEEb5FmI6w==
X-Proofpoint-GUID: dgUUWrR78ShltqQY2EXhUs23E9WhM3uv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250058

Hi Maoyi Xie,

On Tue, May 19, 2026 at 2:40=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> Hi all,
>
> While reading drivers/acpi/riscv/irq.c I noticed something
> that looks like a past the end iterator pattern, used in two
> places in the same function. I would appreciate it if you
> could take a look and let me know whether this is a real
> issue, and whether it is worth fixing.
>
> The site is riscv_acpi_register_ext_intc() (linux-7.1-rc1,
> around line 155):
>
>     list_for_each_entry(node, &ext_intc_list, list) {
>             if (node->gsi_base < ext_intc_element->gsi_base)
>                     break;
>     }
>
>     /* Adjust the previous node's GSI range if that has
>        pending registration */
>     prev =3D list_prev_entry(node, list);
>     if (!list_entry_is_head(prev, &ext_intc_list, list)) {
>             if (prev->flag & RISCV_ACPI_INTC_FLAG_PENDING)
>                     prev->nr_irqs =3D ext_intc_element->gsi_base
>                                     - prev->gsi_base;
>     }
>
>     list_add_tail(&ext_intc_element->list, &node->list);
>
> When the loop walks all entries without break (no entry has
> gsi_base smaller than the new one), node is past the end.
> The function then uses node in two ways:
>
>   1. list_prev_entry(node, list) relies on &node->list
>      aliasing &ext_intc_list (the head) via container_of
>      offset cancellation, so the result becomes the last
>      real entry of the list (head->prev). The PENDING flag
>      adjustment then runs on that last entry.
>
>   2. list_add_tail(..., &node->list) relies on the same
>      alias so the insert lands at the list tail.
>
> Both behaviours are intended (sorted insertion plus a
> fall-through path that still wants the last entry's PENDING
> flag adjusted), but both dereferences of the past the end
> node are undefined per C11.
>
> Jakob Koschel cleaned up many such sites in 2022, for example
> commits 99d8ae4ec8a (tracing: Remove usage of list iterator
> variable after the loop), 2966a9918df (clockevents: Use
> dedicated list iterator variable) and dc1acd5c946 (dlm:
> replace usage of found with dedicated list iterator
> variable). This site was not covered.
>
> A candidate fix would track an explicit insertion target
> (struct list_head *pos =3D &ext_intc_list) which is overwritten
> to &node->list only when the loop breaks early. The PENDING
> flag adjustment then reads pos->prev directly: if pos->prev
> is &ext_intc_list (empty list, or break on the first entry),
> the adjustment is skipped; otherwise pos->prev points to the
> real entry that becomes the predecessor in list order. In the
> fall-through path pos stays at the list head, and head->prev
> is the last real entry, so that branch keeps adjusting the
> last entry as before. Observable behaviour is unchanged.
>
> If this is intentional or already known, please disregard.
> Otherwise, I am happy to send a [PATCH] or to leave the fix
> to you. Thank you for your time, and sorry for the noise if
> this is not actually worth fixing or has already been spotted.
>
Yes, I think this should be fixed. Thanks for reporting the issue.
Please send the patch.

Thanks,
Sunil
