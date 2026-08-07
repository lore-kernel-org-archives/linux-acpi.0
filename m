Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DEB3D410E
	for <linux-acpi@vger.kernel.org>; Fri,  7 Aug 2026 12:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105610; cv=pass; b=t00tFvFxq/A/g67lYy0L0zobyAo4eMR8uirD/Ih75pgsNT6N3ubxiw0P3lD/8RYOvDfiGnW+PtGKUM6TB/cAC+YHlOQmEEnlMTTS7LPY1LTBGVCwdhcUEwGpUV66bUuE3RLxBjac3gs4nfWJe7kf1p1ezozd7oxPFL62ceo6Y9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105610; c=relaxed/simple;
	bh=6234D8LBfUC42DK7gXm/LmHnQDFcKbOyodSX133frx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnB4xXQXMusMTxDac8Mvl4l4cTGy6yuKOs6zNB8vsVgbpzXmEy93+VZKec0he/PQopIWaN9p9MNyUBToJKbXmSt/O3LF5X8WzSCqiuHw+2pKWVuPzFt7IMjwvV/Hazv2StjWUMBhCnnjEkaybXNUAlXKvghwNZjWS2J9ZpqM/XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8SWpZd7; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8SWpZd7"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-667bae10ba3so3863099d50.2
        for <linux-acpi@vger.kernel.org>; Fri, 07 Aug 2026 05:26:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786105592; cv=none;
        d=google.com; s=arc-20260327;
        b=a9SbelcY9V/P481qjyfYDQhzsxrxZSdurh1sjiT12UFwOwYGfocew2Ld7UMXd4xq9D
         axnBnQ3+RHf1O2WBR2a+f9RXF5EyVpTTpRzUuAObonkk44KkYDjjbYfNl3PWCFcvNpMb
         NeXuNQRXFBAwzao8QWZ6ZuFfCCbldtm2f8pRmFB55OQYzkeJ1Hbji3o1jyMvsM7sD5wr
         Lnq/arN6SbAGtGQuOlObrjaJBDHjQgBhkitUR0bW+hw7hDaCMusa3CAD+qcDhw9pysWY
         sit7veed5R+pACmMmSsiRuMol35CzcxrEu0wB8wMowtGk/UxYgfqW+AxoNCjmmjaIr0d
         L6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6234D8LBfUC42DK7gXm/LmHnQDFcKbOyodSX133frx4=;
        fh=m1Kl3wMElL+2yER6MHGGe5rgnlE26yV+lf0DJIXLubE=;
        b=IkG23J2eaaO/EFFFYBN5nBfL5VqXnOf2LviAARfRe9mAmm8hCgZZxeShcZOoY35Q/z
         oVv5BQjFMLNbLS+2S6MHoMaqyzYiGCTiJJPRlp1vLhxvyex7KsQSc9amR5+fsqkCp+Dw
         ZGTi+D//b2hpXQv9h2aDAJfin69brhSgFaKh9v6y8k4qmqMRgg0zOms4wU6g5B8nEd/d
         gbtuwFOM5OpqE03riHA4Rkhjy1RNtHaWQbkF6Lx5ek9HETK689Y6ABQARxTOjPYCO+1j
         bVlPHaeTasznPHkGeI1ajvb2VCcu69szODc2vmV3CxfwMI3iKo14EMCmxRL5TNfFh/nb
         Xf/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786105592; x=1786710392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6234D8LBfUC42DK7gXm/LmHnQDFcKbOyodSX133frx4=;
        b=m8SWpZd7nhaIISJO3+HGxTjY61jsrv4O/x4AWRcsdOvIjXixCEMCDE2wOY/RX0Fs4w
         SJrAoeIpieFFspyLBBK+mOl/ldTnmqinaQRjoR6f7RS7MAPv8X49ezxb12DsyskJEBB/
         23b3T7nb8DffrMWmOYthFOerCmXKmmTIpLqPRpW+37B+NFvKMBdkpueo8424Q4/+L3Fw
         0ud7b9YJbQoWL6E8Un9UFwsooXH+vDDqORIp9bszbXBH+WBTK/1gvHkuvcnODUsUCj7M
         7SM30KNq3K46rp3VXdntQ02WpjeusDeb9SNzylxflie5a/BD5ZzoC7uOaIkAYqopq79s
         YX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786105592; x=1786710392;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6234D8LBfUC42DK7gXm/LmHnQDFcKbOyodSX133frx4=;
        b=ocYz+B4h6KkPkASz6evZp6UaRYzvAUE182JJC5/I6LDhZ2uHr1HM1bZ7JMWtqnBgru
         YwXp0aI/omXHRQk1RTHQ0N1xDsH/pPUgWkmyuhPClg0IAnMF7GEN+fIsYi77F+dJBtr9
         I5SkenUaDf9TNVhMD8rDJXMLqMmhlBmSRdpGvRSC1I+LuAM+6NsZ1RJUzFtNYZca5RZ/
         Ruk3y2BDvuhVyLQhT4v/hyPCWSVc5MVdCMgPxHp1XBwsqXzm//qyV/jlYcv2n+NYWBt7
         4aasT5KLyTyJ0eESDt5PWhqoAGVK9NoQO9TfcLlttoKeR5SNwsn6w4GmSFLbstWk9hIu
         7Wsg==
X-Forwarded-Encrypted: i=1; AHgh+RrabS3glTdySBnt1QxsbXDbSX6A49OS3wxOYwQ769z0As4m8qxoY1XzI9vT8m6+hkJyFRglNCLc2nh4@vger.kernel.org
X-Gm-Message-State: AOJu0YxeKd09XFj8v7qUr61qZn7I8WAQMNlUyU2cPD8TbVCVQWt+L/rL
	v3fpdAJztkMjEWJ8CAv8E16PI0f1AG4UNtrcO1gx+OYXpYiwNMVnRsYK4ECl4CXjj0nhEvyZujo
	VL8c2kIB3GVbS180FIPh9ZMkHlqoIh3k=
X-Gm-Gg: AR+sD10QeMIzP0Ir2KRHK/njGP4hVqgIToNYKu7iVkReq2lAoZFWRjzkc4Ef6fi5Y81
	mkSwJ7J19Ar2NBqa2s0YyYtTxrY7czRtxUx4TUmpMDEwgFTNICCGjx9cA+sbgwVQhZHA+w8T/ba
	rgsmpeb17bAtHYtAXHRWA5wOgL6hTDA2LoUpCYg6AyvFhghyRuFBDdeuLDPvY4SYKg07rqCsJz2
	ehAujlx9nvs/pzocv53LP8eE+pejqmkFGJQUeYHdnBlWCmY2ikA3cPNxmk25HUQXgKGy+k8MjTP
	gDfYPYdTBXr22H4RZdBZmtPlFr7+Jqlok/1YIz6il4W56mRlGjsLYiKtFVv7AryoYNBeYNTpwLi
	QmYu/Y/jmGsg=
X-Received: by 2002:a05:690e:480d:b0:668:90cd:8aef with SMTP id
 956f58d0204a3-66acd2f1bf7mr1336478d50.25.1786105591669; Fri, 07 Aug 2026
 05:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com>
 <f42cc94c-ff60-4999-b473-c2fc5b1b4199@intel.com> <CAJZ5v0j1Tucb0yzS8=3U_X1E4ziztjgOsiYrc_QfUUKZfScCPA@mail.gmail.com>
 <CAJOGg3zhEFner5pze-eX+6jh5D8nJppyWkNN5bWtg7MZ7cW9_Q@mail.gmail.com>
 <CAJZ5v0ib2YxyX-6j34=w+FEOH+fsGF_ShH9Q0YCEDkZvRP88EA@mail.gmail.com>
 <CAJZ5v0gySOkYRphXHbXcStFGiuMtni_OWXW2rTDoa_V2PRPnJw@mail.gmail.com> <CAJZ5v0i_AS1JzyM10yPfM5QsNVsQmQ3=haHCcTiM72FZm+G+Qg@mail.gmail.com>
In-Reply-To: <CAJZ5v0i_AS1JzyM10yPfM5QsNVsQmQ3=haHCcTiM72FZm+G+Qg@mail.gmail.com>
From: Julien <julien82453@gmail.com>
Date: Fri, 7 Aug 2026 14:26:20 +0200
X-Gm-Features: AUfX_mx9S7wOi18myqNhYzBSITOrslEjXCrKmoDPgcg1jNxB3zXGDhsWm_H5WQo
Message-ID: <CAJOGg3wZvftfk-hZ_wXBYnXca9gf5ziSo0Uh1BouYvzoEyEVrg@mail.gmail.com>
Subject: Re: [REGRESSION] no TPM device after "tpm_crb: Convert ACPI driver to
 a platform one"
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: regressions@lists.linux.dev, jarkko@kernel.org, 
	linux-integrity@vger.kernel.org, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 12:45=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
> And there is a v3 already:
>
> https://lore.kernel.org/linux-acpi/12955541.O9o76ZdvQC@rafael.j.wysocki/
>
> so please test this one if possible.
>
> Thanks!

Yes it still works.

The logs:
MSFT0101:00: [mem 0xfed40000-0xfed4103f] expanded to avoid overlap
tpm_crb_acpi MSFT0101:00: [Firmware Bug]: Bad ACPI memory layout
