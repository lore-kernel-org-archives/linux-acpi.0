Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306A24BCAC2
	for <linux-acpi@vger.kernel.org>; Fri,  5 Jun 2026 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650223; cv=pass; b=Vmzb7f3cpSnOWxiWCNnO8peA06yWyDN6BvNuzkKYbP8ScdQnlyWmtlZPu4BzQUcsyCe+Fk21gzgZlNwhe44gReNKianDyq6YzTcfqdzK2sMPesQXLKR0FPv9cilFMobegVkvIsRewM9hmScLkG8Bsh/2f2m/9j3ZUdQY0VDVsPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650223; c=relaxed/simple;
	bh=JNGNA9KfLEu6lKiLq/bw2EyVuHECatldL352HW3O3Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSzn21xOYHeCDUeTHsqCVKI0VU58YLHSN7z3Ja2TW80GEoWdzSstABE2VucplcsJBf0DVaL81LyQenuDMATJjjrtnIcXoelIC8CDNdPUjs4mhAeSz85H0DQGfrBdcdOm+DN+pA6mz16XoDjnS3RwzrbGgh4Pum/dvfOxUIUC1+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=msYyxjAa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RvcFdgRw; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="msYyxjAa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RvcFdgRw"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6555q8GN2427809
	for <linux-acpi@vger.kernel.org>; Fri, 5 Jun 2026 09:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=JNGNA9KfLEu6lKiLq/bw2EyVuHECatldL352HW3O3Jk=; b=ms
	YyxjAa60BJo83GWoLx+DOyn9oy4FanODdWgC5P/uXkr+Py13w0W5PZJp6/7VKqP4
	RTzgJJ0UBiekRROIJcIPKAJLBQc4rMhN5pQxuXpXx3FvCKMjOPC9CmeLJqwKNUYF
	qJ1zIC5MBfEAvZ0ixzx5KA7JSWx0ktay1po+N/G7KV5V3CY0Z1GSY206LLQE0rnD
	JBPN3LL5eURVso7RC+I3B3aSFv9di7sajhccj4cTGNcQOYPrY1grz/aue6Cil3Ab
	mr419w+e/umHWh+LrPw4NbNWh8nrAncrjfgsCUdDfKA9fbXn/379GbqZeGRxO2wF
	E5mAx6F2P/qWrtaQ3nDQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekrphgqse-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 05 Jun 2026 09:03:38 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7ea5c157215so20542787b3.3
        for <linux-acpi@vger.kernel.org>; Fri, 05 Jun 2026 02:03:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780650217; cv=none;
        d=google.com; s=arc-20240605;
        b=PM3/h/bmH0fd/K/POzd8dATMGQO6lVx9UHpdsf5vamd/D/LyrL2j5Ptu0rJkjepTUp
         1mdZO77m0EgzG80gZ/CW0MA52bN6EJunDx37kMxfU/7BbZBFuWYvw94JVsLiGo2lM6YR
         ECzKtSYVU4UdbCeTsev9xgm/oPmK2WSy+xuwIQFbtBCc9GVYinVUwnapwvvzo3CREL04
         MaRtBCesVE2kW+vUWUrjmgX65S0DH8M9ppbDXwn7NPmkHMU87bKqyrxgVydX1mekkNv7
         LotNwuCy/NVyD5NJkftv6rWJoQwtYx0agiFcbD+DsRRzT1dfKpzSoM+igS7whAJ/kN8/
         +lqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=JNGNA9KfLEu6lKiLq/bw2EyVuHECatldL352HW3O3Jk=;
        fh=D26dupRcQS81vX87qRXy+vqMzMlwo0DnYIeSRJtOUT4=;
        b=jzBVfn52rIRW637N5fzLUVc2DpoWztId9/qJ7TiXEX80+koHS6dgo+FmeVR7EQwbTy
         VResWHX9kljYgIa5I9YbQbF7K+Ynt8OhNF4POsJM+hg2aNEZQ1hZ0b5KDXSWV0YY4j7m
         DDiEE1dA5qFkxSSx+FBBOPFF1kU/ZStT9SK/tgGL3FQ8xqSVK9bQtO31Ax7k79D1s0VW
         SZk5lju3Q8e6VmXLZkrNxLqoYSJpPUt0/oaA/xwFz1Q5c/eZcqXEM+6rruTRtcC4w/Bs
         Rw3hGxPZXur0DMHdeOWSoaCdU0XLfgFhyFZ/rfvd4qUctNWVo6q77MFahh+35eBMtEGP
         RXMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780650217; x=1781255017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JNGNA9KfLEu6lKiLq/bw2EyVuHECatldL352HW3O3Jk=;
        b=RvcFdgRwxcUN3t/eGPNfqmnxv+2F4683R/qM8VuuDZEXYYfzyGpPJsdSDHNXPERfPQ
         bOi27MqZgKObMtYX5ccjzvZicGTmFlz6gCvCB664go7LnSXQ5zaSOJuZtkphevO6DOvQ
         Fv1WJ5ic+DneUSYddJgCSGBBU1BxRYEuf0AxpmcopSmaKIXmcE9s8Hy8nWYGdscBgT6N
         2WF5LqFD2NIFGQB+SliBu/GbZRAKe+UNcVhVAA8O3EpBMPGscUr5/uMpaUqG2yEUtaZZ
         pYKaW4vo6lTUO4tbOj+GsIUjTVfOTzm4dg/8Ae8D84ot8y3ZoEnqqmaZjEkbi/elwbCC
         40gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780650217; x=1781255017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNGNA9KfLEu6lKiLq/bw2EyVuHECatldL352HW3O3Jk=;
        b=E2HAb+4/JUhZTwBICkzfpSVyDJt0nhHCYILjX+LqXSiZ4l47rntnE8I+dnBKrppddn
         U0opKfawFF4gCkH9pNWHGgowbbbJLC5RPOVsvTgpsqXOy5k17CBx135B7cpJpo+wTYCZ
         8trnNl65JXLdc/evyNoSef7FU3qfvGYhoIZZvBuBZVtyH7hCqc4/ZONQW/2YshxFNUbY
         IByiR3h3iJlOJb0kD/asevcGjfhxYatlX/pH/dQJ4TZrE9NlU4Hg6LJwN500/Gmzq5Fn
         AkeWm3W2dKvZu7Nezg5Ymg5myy4fcxEvYnjgXosBSEmVRXQpsAMEQ4NIeoxwvALJGST2
         FkGw==
X-Gm-Message-State: AOJu0Yz/4ha+loHkEN1OuQ/BdC3PBSKSGsY2FhlX9c8Au9wSiYu6hQMh
	eVGhg9k7MwXKgavRBBgnOTHrKSK0W6+C2L/6ahK+rwy42peDTdfxGgqNlIVhaOso9qEGOOv5Zqc
	Dr1XjDwWER7+9Z9+0x4iuSe1A6Ngp1HQTQNKfl4Dg/KLa9walfhcjsUYru7R2HbBef65RoIhFUg
	EK22CKpMvXyAkwVEvmAi/0n27hyKbxGu3/mgufAu8=
X-Gm-Gg: Acq92OEN/DZrunLScgny9XH7GoLlXjsOME3Hc7OLkw8zTlYvj4APgms5r7gl5EqKf5m
	O23VI89FXdO0dJ8y/uilcLS33y9fdLZQVt7qsJsh6AHLbERvEPUZ6G9NwA29RWUe3lcj86Dqcv8
	31AsUB8WI53d9ZQIdJqIJThABQ3Eelbi6KAlULz8TnaFr/2QEFesy36DlDbbiZECQt1rjEzPJho
	JLguiHxKvWbKr4uBg==
X-Received: by 2002:a05:690c:6810:b0:7d1:dd7b:b736 with SMTP id 00721157ae682-7ed0d3c5b7emr25872597b3.37.1780650217194;
        Fri, 05 Jun 2026 02:03:37 -0700 (PDT)
X-Received: by 2002:a05:690c:6810:b0:7d1:dd7b:b736 with SMTP id
 00721157ae682-7ed0d3c5b7emr25872277b3.37.1780650216818; Fri, 05 Jun 2026
 02:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604145510898G2kTwM2Pr25QE5H8T4Wh6@zte.com.cn>
In-Reply-To: <20260604145510898G2kTwM2Pr25QE5H8T4Wh6@zte.com.cn>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Fri, 5 Jun 2026 14:33:25 +0530
X-Gm-Features: AVVi8CeQNoqp6ec-yy76ZQa8OFaMF7NkyuFmoREpSs-Er4z8q50OUmANSqwrxik
Message-ID: <CAB19ukEzQZktJcBAXi8X2Pwz+hO_FcR+iiaK9nsCAumP9BrHnw@mail.gmail.com>
Subject: Re: [PATCH] iommu/riscv: Add dependency between iommu and devices
To: wang.yechao255@zte.com.cn
Cc: linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        sunilvl@ventanamicro.com, rafael@kernel.org, lenb@kernel.org,
        pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        alex@ghiti.fr, tomasz.jeznach@linux.dev,
        Anup Patel <anup.patel@oss.qualcomm.com>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: WQUaFcasp39VtBDylXhu37pg6E9wn22X
X-Proofpoint-GUID: WQUaFcasp39VtBDylXhu37pg6E9wn22X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA4NyBTYWx0ZWRfX4xougA/2wujb
 JUd7WPHNI6LXrJxbTBidcWeynWFrG2XCf+cydWL28ZVSONjwxkljazrmrKFXh92c81T2tfUzXys
 APTxUExI4wqvXykA7yXLAaK1saEyAT4o/eIWupZNkDowUHLenzzZCU8q8E9bEyYuOxTq3iaTy6g
 gSYFdR4TXgPjPWJdRTNldkQU4PcM6oRRhYbX7nByhkL+yyBwIPrx4Oo9pgtmNh02aWKGziLV1cF
 7FKPmJsqpW09DZmrBkbgbMMTHOP2wP1RUVftx2H+Df+Sk4ORHozmGlyxrI/1zrN/LKHDmmTPySv
 d1adxtEgniKswQ8oCiit7+Zr2iI+LhXEpzg/QVGChGdtoAq7TqAuytL4ITb5roWX1V6FhTBEq3f
 pNU2iMTVNcm3tp3PKA8HlspuBHE+IhgKsjI50OFLYCoHVhNqZ/VBvOUiNp6/dONjpMLaMhI1hPt
 1bI9/o0mfM5LekuAm8Q==
X-Authority-Analysis: v=2.4 cv=T9a8ifKQ c=1 sm=1 tr=0 ts=6a2290ea cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=1RTuLK3dAAAA:8 a=8XNXOnQHZAaewqnS2oYA:9
 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050087

On Thu, Jun 4, 2026 at 12:28=E2=80=AFPM <wang.yechao255@zte.com.cn> wrote:
>
> From: Wang Yechao <wang.yechao255@zte.com.cn>
>
> Commit 9156585280f1 ("ACPI: RIMT: Add dependency between iommu and
> devices") adds the dependency between iommu and devices on ACPI
> systems. On devicetree systems, the incorrect removal order also
> occurs.
>
Interesting. Why is it not handled by the fw_devlink infrastructure in DT?

Thanks,
Sunil
