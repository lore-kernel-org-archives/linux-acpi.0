Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A8C3D1CB0
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 11:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215692; cv=pass; b=Kr+ScOMJIB2zOMkXxyorwNMY+YSEWkleRxO3nCTeQsmOfCsy0ByPWACgrBAKLJsILF07lJRfnXkLAQAIxJp13ZXCUoFE8j3qCNgaOv8duNY4dw4eqo3yEgnkiStcFO7qOlcfQLLkXWsODRcA4xKEa0DnbFPRGV1GWLCEDfogazU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215692; c=relaxed/simple;
	bh=RRpkkLa0W2etFg/RhsIv5UIlJlesmVn4cGN+MF0OYls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCDZK1D9LkBV0IdiemUg7R6EbhFz5QugndEPjbvbJoBRFGtsiesMMlY3+tBKH4eE9O5Bd+qxLYHhCJF4+7DbjTq47q5zMBh5797zBBCeR9ZAofPS2UOmHyvjukwgy839WllaFKrr3Ui/wD1kkSql5JbtrZ/r/VDvkyXgroJqdvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vvc/uqFU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S0ojvVmf; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vvc/uqFU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S0ojvVmf"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBauHq052556
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 11:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fw2vf7ZQ5Hwg4RRBsz2SP0jNtQYgUgnxAvq6NzRaRj8=; b=Vvc/uqFUHWTIaaHw
	CgykLxh+JHbckuAbxr8LVfoxnnIpUyBQj287laGknSqX7pOZSSLpGsPrSAYWRcS+
	k+H+i40QkYoQxdBykEvh5BrF6HyKN3Td1orFAy1o2bYjnSuwYjOwvcRofmktQE5k
	hMqVRmd0wJAgUGR1+zMxIcflbZlA5seD39z7St0Kbrike7NxXRQOmlwaK0X5nhTm
	yPe5OSX6oy6SXOyRLgdjXnZbsO/scPyawcLxVz2PGhOunTtpvEwhL1Bb0WBJqd73
	yNUIKOr3FoCTo2VwA5NNDjw4wW28XoaBUS9X7FrTqyhPI+MtMGKYDfZEQkulIne0
	+DOtnA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n44kqh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 11:54:49 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9254309dfd4so310243185a.2
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 04:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782215689; cv=none;
        d=google.com; s=arc-20240605;
        b=kMSHisoI6JLYfPxxpJJJByftpPXF9RJnbD4cvdXA1OH4XaG9EHOMRfEZBlBV3Xdph8
         9AQ9N6N4xzeDe0bzDpHhz6+gwrz4vZzvPBHt72dmiXUVHrxVCZr+cCJ1IV3o9OJY3uCP
         tkHoSZyq980uK1Co6KeWtvStKwA1/KTv2lXJtPmjw8/AIHYe1HMbZy+HkctWdibsNUJN
         lAYJkVZ/Z3ufrfuLKesjlujy4TblKsN85VumddJVpv1OehH6L4vy+bFxIyQBmGc5djBH
         qmgQED0tSSgp7+bqjWOOGUtX6qaRn9o3/qfzHx3fA2ujrcPOzWNWvxXumwk5ppiPQq3U
         twqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fw2vf7ZQ5Hwg4RRBsz2SP0jNtQYgUgnxAvq6NzRaRj8=;
        fh=m5TqG6mk/9ljAzMjyASGvkUQaXOAOu/jxhAJTTR5lXk=;
        b=PyEtuhnzrhZhhpwW/mF9M0VfWvYl7IkNZwrKEsFQCxO4PTwc31G3sRsG37k6V8TkEc
         rH468qb8e/OLUqGITaGEmqLvGAAX0dAzPpEFj0m0Ur1TUuQJsAKDBwqCo7ShQk+KylPV
         6yaPWjdtkwF1UIFK1BbUhh1KmMVCoUtTMqNmlTNdf+9m729u0FQPjtSRBOK3IUUYucZ9
         7/n2XO83O1RUAkV0rgtYUDDK126V9MrbFubCaH6caTHmqZK5AsDc+R1VCgiaUesoljRo
         p+YZUHErLn4K+Ps3ucMXVBwr82EDGS5tY0KcHTlqdLiMbXSNKlaRInLQNQrVtCyfqRr4
         +v1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782215689; x=1782820489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw2vf7ZQ5Hwg4RRBsz2SP0jNtQYgUgnxAvq6NzRaRj8=;
        b=S0ojvVmfhtXj72V+zvd802umw2q1YHabvB+M1pAn7p0FkCXFhRfjdhc2M1i1vIoW6y
         4cCLGXQTosTK9XyDGKKkBLv2tb+xRXuOclf3Z67Shao9urJXFGZz6SjrvTVhfwxP1rwm
         W5jJDhHJhLWf0GwBHCQ5zRymUpMBULFtmT6zWBeaVYE2RbKozo3UFb38GS6aiYxZDVO/
         2VAFUzlh5txPMb83N+ddNWYn6eAL2EUhX6Ocpnzv4Qq3YI5xF46yXmNtgkF8FHSKXflI
         YpwBNUTu77VRoo3JbLRD1gZ9Ph6r6kDilhxLHsTUdZ3tolejXDWIbuqhe75nONkithgv
         OKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782215689; x=1782820489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fw2vf7ZQ5Hwg4RRBsz2SP0jNtQYgUgnxAvq6NzRaRj8=;
        b=JH5wRRvAcncZP5Bf0fWVlz583fao3C5Q9oFVAz2GXp+dGLILFzzaLAFePd5FmRj437
         k0I+CyW2XaVNBjpzDmAznHgfpvIuMT7PfdJRPLjyxM6ApgkiotfRjH25HJyz9dTLDEyQ
         df48hmql1zT+OQFXYWQaggke3K5OzWi1UQPQww+sSgzje6AaRaQGUGGJXmXkhfk0GpMo
         EZWBELRu42BGoJMLAAUk7B/8AHExInduCpl0hOwFhet0bpfoKSVshGcw7aFS5EVM0jkw
         2ic05NtpxMaCYGW4IscynC8gMUbAjJKYP3fMsA0UfsOstt6immZD+Op6cgYPoRQ4utFD
         W2nA==
X-Forwarded-Encrypted: i=1; AFNElJ/R0l999nJ9ClHewdQdTChBDTv7OIG18lGTwC7bGNCmdnxsIMMtzzFwkiaHCvnFJxY07uobU08q2nYa@vger.kernel.org
X-Gm-Message-State: AOJu0YxIKlGJyHb297FGpLZo3QSqhP8WDhhGNqHMGLi79hRJKhYPJn5W
	+Xqx4DtCoGNyE/3nMhb+sS1y4XOwVmgQNpdF3vczUzh9qZBbFgt4WlhnUMWyhZ2WufFx8/3dZW7
	gKplKtWaGIVDoHS6NeZJiCNXp/g0pOCvhLI5CzWBzzFwrvwOPfiXy+DUzKk4SE9vwSwkb5H0+XK
	XKyRGTzK/wB2vdLy7zKadhZ+qWTeEAvuG1L5MROkI=
X-Gm-Gg: AfdE7cmpI850oC1gj1ydDLRmbZeBjeMrBxcztoJmw1PTJNEVm4CPohYzH5Ocp4l6mtv
	Xhw9hr9+NAV8NAiE5Qh8PIlGL4ggS/cZhwhRk/vX0eupC4EU+zGHtD9rUeUJ5ENwAUVyUIIdesL
	HEbBSQgYUocjz7kMtXheMqvOv+dgS0zZkA7rcJsEkzgtZ9SJKhqhinvU8Al8IlrwUznA+dfTZ/q
	FTzKUzV0SqjOoUVAhZK1HfkMNBBTmY2w0LtvZVMgq/eh+MyLcuUi7/wM0tfe54qShOQqbVEgM9+
	4E+3ZXSqCxI=
X-Received: by 2002:a05:620a:6cce:b0:916:4a9:f35a with SMTP id af79cd13be357-9264771b2a0mr434706785a.30.1782215689077;
        Tue, 23 Jun 2026 04:54:49 -0700 (PDT)
X-Received: by 2002:a05:620a:6cce:b0:916:4a9:f35a with SMTP id
 af79cd13be357-9264771b2a0mr434702185a.30.1782215688526; Tue, 23 Jun 2026
 04:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-fw_scoped-v1-0-a37d0aac0a68@nxp.com> <20260622-fw_scoped-v1-4-a37d0aac0a68@nxp.com>
In-Reply-To: <20260622-fw_scoped-v1-4-a37d0aac0a68@nxp.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 13:54:37 +0200
X-Gm-Features: AVVi8Cdel5T7fniqHB4_fyyFIVPTxPRe8hWJeBKySDY3t80yH0us_4QRaPBT6xo
Message-ID: <CAFEp6-1vaeC9oDKuPAdPNtmGSsewbHRFS9RcPMzzzWHjnXQA-w@mail.gmail.com>
Subject: Re: [PATCH 4/4] media: qcom: camss: use fwnode_graph_for_each_endpoint_scoped()
 to simpifly code
To: Frank.Li@oss.nxp.com
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        imx@lists.linux.dev, Guoniu Zhou <guoniu.zhou@nxp.com>,
        Frank Li <Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA5NyBTYWx0ZWRfX4OBZwR4LtED+
 uMkJj2EeqX2TADc/2JCta6PXNh49jV+lBX1LagUyQZyMiyspGl6rWNnYR92aPCBHdYQRJdNFt4P
 cNPTZCsx6n1hXwcCF72VrkZKWhHwLDg=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a3a7409 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8
 a=9UnFPMSZPvWmRCPcKGwA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: k2wUs2t0IIbKf5iOib7B4SPdIXrPgr55
X-Proofpoint-GUID: k2wUs2t0IIbKf5iOib7B4SPdIXrPgr55
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA5NyBTYWx0ZWRfX/bzKjkex/hx8
 xPPQHvtTHTu1NHdnFUX6fv4XPq5JHtIFNYA93wZjp2M7k9lsWaAHkoA4T/D71sRrgBwZOCkm+fx
 aHHbKN+CJ6HYrCkfw/AFo4MQcyOz+rGoVd6xK/Hf4vBKixLU9uZuVnJvInXafAAuTNduROpYnz2
 RXA3lBMUiNavC8yAbRGsbxjCw55Zz16Oxm+ohfIFLyTH8c81N3OT1rUYdyCXv1fw1oEbqMuerEA
 7VKp0xau4NlfG8gDe6tkj6K5JXBxBKSwgw/lsJf//Rr1jWaJpKDhDSptcdad9HFR4vJD83/rJ+d
 vIdYG5cxBWJF34aphcYGER8/bv/YReWlMUpELjEyCBqP4d4PVoTiVzaabBvmFB1N69JYlmLGYxN
 CuQj1De/VyMh4Vhzleqi5q5d2YHX3fOsxjJYBaWlFzdr7sdisg7wpSEyNDJAbGGfIH496l+zOnL
 8+wsQ8dChtF1ugyBWbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230097

On Mon, Jun 22, 2026 at 4:31=E2=80=AFPM <Frank.Li@oss.nxp.com> wrote:
>
> From: Frank Li <Frank.Li@nxp.com>
>
> Use fwnode_graph_for_each_endpoint_scoped() to simpifly code.
>
> No functional changes.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/media/platform/qcom/camss/camss.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/pl=
atform/qcom/camss/camss.c
> index 2123f6388e3d7..23f3cc30a15a5 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -4793,30 +4793,23 @@ static int camss_parse_endpoint_node(struct devic=
e *dev,
>  static int camss_parse_ports(struct camss *camss)
>  {
>         struct device *dev =3D camss->dev;
> -       struct fwnode_handle *fwnode =3D dev_fwnode(dev), *ep;
> +       struct fwnode_handle *fwnode =3D dev_fwnode(dev);
>         int ret;
>
> -       fwnode_graph_for_each_endpoint(fwnode, ep) {
> +       fwnode_graph_for_each_endpoint_scoped(fwnode, ep) {
>                 struct camss_async_subdev *csd;
>
>                 csd =3D v4l2_async_nf_add_fwnode_remote(&camss->notifier,=
 ep,
>                                                       typeof(*csd));
> -               if (IS_ERR(csd)) {
> -                       ret =3D PTR_ERR(csd);
> -                       goto err_cleanup;
> -               }
> +               if (IS_ERR(csd))
> +                       return PTR_ERR(csd);
>
>                 ret =3D camss_parse_endpoint_node(dev, ep, csd);
>                 if (ret < 0)
> -                       goto err_cleanup;
> +                       return ret;
>         }
>
>         return 0;
> -
> -err_cleanup:
> -       fwnode_handle_put(ep);
> -
> -       return ret;
>  }
>
>  /*
>
> --
> 2.43.0
>
