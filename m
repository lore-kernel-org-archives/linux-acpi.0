Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9563A32B981
	for <linux-acpi@vger.kernel.org>; Tue,  9 Jun 2026 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015451; cv=pass; b=dqZP9S2ZFq4bN1v9xguou9/AdUyPovUicf50d7/b5ve3YFOhzSeMFA0AUZgxruz+vDcLZZ2+T68Biinlm5yMVMx1sH/npslyd/VsQYknGCvy6KiUm+TtMNLxXeS0FymUszS9Q+swxH9dde4uSwJm9/du0gVX/24j/MUq5Rs/Mr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015451; c=relaxed/simple;
	bh=qUt22HVRDHTLE/STP9WjivjbEVbcJJjbvLyeAgzpexw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srYjRav1np+W1IuABnFh3Em+BRHqsBVUwWvGDk03iTlLybndcGvJ19W5HA8iXoSRI++NerkCGC44DcVwbJGkcJi3G0McW2hoEoPPLNhtl/kdASuAtwT6B8R8WCe2+SAfm8ZUOn0QhHJKmnFHDJYCz2Dvxcvww2qbfyUpHs4/wcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fthfLPGW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e0PDP77l; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fthfLPGW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e0PDP77l"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ClGHE2251540
	for <linux-acpi@vger.kernel.org>; Tue, 9 Jun 2026 14:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=n2ZoTe9MZ9DLe7zQEw5ul/Iirw7q5Hetu2UB3w96zKw=; b=ft
	hfLPGWXHW1tH05MGW+QkewmxBy1Qv1V5JZ1bg1jJl3Rmo0OZAHZS1Ti6DGfbnuQq
	Wke6OSRaNbWX2DrJrThCm5nZmCBPypmaW6HFWWeYTaWJtSQ32r8hjLGBM0e4Ma74
	XvLousMzr7VkLfoUz15z1bjMeTNOieUtev0MsrKZ0qfswdGbnYV05JCa6Bym7IHa
	NF/S3WZR1NMkA64Kf/r172K7fuWMmaqpR4zdP3ZC77W6P1TBhLRm/HqFVa9kQFvl
	s+yrnow19Pd/K8omAHQN+8c/cbkR+0Ry6G2B8Ju1rWrJLqtcJTNXXLykt53TNjjM
	gpPW1Xu7r7+I4xexTORw==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqght8n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 09 Jun 2026 14:30:47 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66043ac620fso4419434d50.3
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jun 2026 07:30:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781015447; cv=none;
        d=google.com; s=arc-20240605;
        b=VQD0x/N5XFsaZqnEQmiOM2jCsFrGGBBMdhZ1SfZVUgzjwPSul0FvRxkkpW4lzlksSS
         biaodvDDORJ0ie27309H/7BAY4KL9wsS+YVpENFgFAKOYxOsud1YRWdoHD1FHXAyNBuv
         yASwddr5KRuf4ryd2iunpRgRZZixPrSA3nj8+iSJb9AkiQf6S4zu/6XiQCwHgxG9HN9m
         YtWmTVZtOSaG/e/qlNHWU5lNbsECvwn/IyA2qYEyMxzgW6nWarcLv3dYt33cjOrKhIXW
         xskXlcOqVcBYVctyA2NUPwKR9ZuU7gJgwa9hFwF+ogE7IYbCI7tdLKTwFzlNVq8GAXRN
         6Tsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=n2ZoTe9MZ9DLe7zQEw5ul/Iirw7q5Hetu2UB3w96zKw=;
        fh=ldTPDATPpv7EN/LTNo38sdXlUgaw7Hn2Z40bynymbhk=;
        b=HjgRN27IGqVEOWWVgqbeQ8tbilSBAM5Eki5YtSxV/u/UxpVmOV+FZtSAL0Y7DInFpW
         R8Nf27wSSlmGZEwyTK2ma3brU1ytibBG8okugfOuKCCh88rRihTo9xtgnIGUvgHLn59u
         Sp4gvUYsm5FyT5480NqUbv6cnbV1ZQIGmkXpNhtveUhmmrU0X2pGY0NyX0sWhOLaGDbw
         YQJdgcln+NlGxcCILFsgS2tK1zCSTgioOigsHaYjXX34+WIu5UnGNwFsd3090WnB2i2S
         9uRILNw698/jJYTUgO1tzsAEwdfMGe1cU42B2a8YgrqTvYHJcEwutH+fG8pq0txx4qSu
         0sdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781015447; x=1781620247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n2ZoTe9MZ9DLe7zQEw5ul/Iirw7q5Hetu2UB3w96zKw=;
        b=e0PDP77lR9tEEee1MYxKClvGm2NSEDByKWoQUXDRo9R50HQ9QBE0wkTjJXxS3mqlv9
         F4QIt6HsFwtcP1mqFDetp+S/TFpJ0pDOb6A+hBv6xWdpJIPy8f/YbrEdBc3zHWMX2a4x
         Xbw3DY6kL2heJNH1yTlxPEBlIYzFW9khBL0PD15RT1vHUd4g9An1WqTl9o5GZPrKxBpi
         YssXUwCY97yTXAYK2eZ/1rYyq0urqHi7drOcu+1yz9nawz/NnER4ugyLZauGK/mJhjax
         kMPDOkC5yh6MFQggpB0eblHeXjDselEUF/hGdlzcZ9UuWuCvY6ABV13v6Lty0fTI7ki5
         VLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015447; x=1781620247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2ZoTe9MZ9DLe7zQEw5ul/Iirw7q5Hetu2UB3w96zKw=;
        b=ssAJlwx2GaoLgs4g2BbUP12sLCVo7X3RoocaxOmtSBJoTt1gA+AG4OhRCxZHuCXgT1
         iUg6vdABcyXdtLt3nwD3L1IDQGJYWOeLsXieGD4AXIs/OFweAwsRhHvOmnzZFGpm8ICe
         GO8C8lNYEPfAMtNXNWUPzEy+e2X7cp5ljElVfY6ZEtcN4Rvcuaq9egdbq9M8HgcFmZWh
         pYoeccffudksn/dJ8UZJW4+ueUocomM1lt+iuLWwOnMoNiTovhwUqUlDNJA8VnJeR1Jg
         QqZcIoIypKmjQhVL1P0Sxx/n+y9VCSsxVpKfVxGg1TuR4wbrBaZDRv25J5qYUASbDGsM
         3SeQ==
X-Forwarded-Encrypted: i=1; AFNElJ8kdex7Jot9n6P0vFZWWlLKoM7xb6q0nNynhhJZ8cgTdr5PH0dmx0ZRUyKOZZpvuWc3O6PQ3GM06odO@vger.kernel.org
X-Gm-Message-State: AOJu0YznF0a9onuzTXgAWuLWotzBbn0zrEVbkXFwwzRQe8ZNSBdbcjuG
	RnUwmXfQs1QI8MtXz6RTX4LRD9QoZjfvdXCqy0MO0nH1ZMRrtFwQwtAgDkZ0XfddBa32XEjN3hX
	FCE8fA450HRNuTp0EToCm+l4LHj/SOPEOqaDBVv79ajV1+p3ImTtZ+1pS7Iclx/AjyRPKNWXe5v
	/LzN0YHk0x9anxjQ6wvN/8JZ2anKqiHwzTPy/HkYTJpchNPEkoyQ==
X-Gm-Gg: Acq92OFPCco8FnqQD1+ZCm19G+IkdTn6BuQg4AZDlCuIL7V0MWuMZZJ9l2rFCBVX6Ny
	cpe/teIJY+Tvasn6izZE4ZsOx/AkJr+dHTN95L6RYTFIg5+cvWLH1ITvSnPjfhX/o0OmeY0uWX9
	kvPeiK6rdoPZvhvAIHGqqRHv9uJySS2gCXPTJ7Srk4HZtpJ6S09d0a3VRlyXnW8znmzEeU2yr79
	rgCfpMQZqpvbY7WEw==
X-Received: by 2002:a05:690e:5cd:b0:657:e42c:ef3f with SMTP id 956f58d0204a3-6610707c453mr14362591d50.47.1781015446795;
        Tue, 09 Jun 2026 07:30:46 -0700 (PDT)
X-Received: by 2002:a05:690e:5cd:b0:657:e42c:ef3f with SMTP id
 956f58d0204a3-6610707c453mr14362545d50.47.1781015446306; Tue, 09 Jun 2026
 07:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com> <20260513084325.2176952-10-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260513084325.2176952-10-himanshu.chauhan@oss.qualcomm.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 20:00:34 +0530
X-Gm-Features: AVVi8CeCCuwpN-K9EkxyrVCpMYmKH1wrm2WzWm0aWwYK4PiS3mEB9S1-HswUmmQ
Message-ID: <CAB19ukGeM=v=G10r_tX2SC603Tej5Q6nFOCddcPF8BaKwxFxrg@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] riscv: Select HAVE_ACPI_APEI required for RAS
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com,
        anup.patel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzOCBTYWx0ZWRfX8XTyy5QBThPP
 UoYfAE6dE4mfyFKO6NR3UPzj/FtgSKijOUebiJELRdMh0EIhOEHLh0WLtT0SVv8uivTmnMHXYwH
 TBfSAqrj+48K0CjvWz9u0I+WkhhuqWeI/v/ohdu18hBbBBgDJDQ3cnGKJBZSh3IdWkKbw3zzlKV
 aZJb+GbjdCNptQX/4uzPlvzraQYe50385c19qsR9fTLf/2DO+Dal+zYcymwWJQo0KXTZ2E2p92k
 3IzgZQOcCC9ovXiPq4/Nu/jpuKORnJ12jjq5Pawu2ycOZTlkcuVV8/z4nZ0KfowIZ2sq75GGqNA
 oKzWslbRRGi5HAB9LcHK6+pTkHVaLGnOcer4yWtoabVmrt4JTdJBPaQqoRMDZUc4TGOB3bd+wMk
 nfmMWxAVYcXl+cefkvdcMVK6Q7AIhyCpkRlkZIUH2YIb+ykjaws7kPYpcy9KtmNWwcF32rIOfra
 9e/9/nrkQndWEisLIBw==
X-Proofpoint-ORIG-GUID: mrqV5ocnskQ4n4wjT-2IbW0t7lvSCfZA
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a282397 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=GsIs01FLSDa8B7WPS-oA:9
 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-GUID: mrqV5ocnskQ4n4wjT-2IbW0t7lvSCfZA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090138

On Wed, May 13, 2026 at 2:14=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> Select the HAVE_ACPI_APEI option so that APEI GHES config options
> are visible.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d235396c4514..b94b19fb4249 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -187,6 +187,7 @@ config RISCV
>         select HAVE_MOVE_PUD
>         select HAVE_PAGE_SIZE_4KB
>         select HAVE_PCI
> +       select HAVE_ACPI_APEI if ACPI
>         select HAVE_PERF_EVENTS
>         select HAVE_PERF_REGS
>         select HAVE_PERF_USER_STACK_DUMP
>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
