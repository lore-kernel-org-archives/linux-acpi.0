Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9423724A044
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691521; cv=none; b=RA+nRV1twt8HrlkHmDv1B8Xk6kF2qBwSXzefaBMxNFzNveXE+fTUprbyXRwqW9X7VXqo8uKcN/y20CBbEjU5OKTU68I1eQCLXu7/Qdi+9KeA1wWkaXAwrYqfqI/jcERP5A+Yr6UsB9Y1r7nQifykVqb3WrXE0wls2PC4G8pyHQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691521; c=relaxed/simple;
	bh=wgU5h29ChZnINHlE7+cpZ7/9ziX5loPoQOCDp71wUPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G9ZddRXLAcgnPg7IFqMOTE99XHwMcPjDnRX6sKGTJl2Ei9bvVBod2B0N4ejSnmgZj3eQfGX30FBocpON0pbjickI+byLLlHTCdscfW2zHEks+coBxJhA/LzubyeZpZoAONseCxbzffP6cqkp8QuTGwJNIHxAUNOk4gTXafxVRXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F3ySqATy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Oc026SDf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F3ySqATy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Oc026SDf"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AD5uYq910228
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 13:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	imuof45N7Xdladp2eaUFL5GJzPQRNKl57RWZRExjNv0=; b=F3ySqATyHKbPSeSH
	ugB/fD+6KO2wJzEN6VpmWMmQfMwQjYHaMBRlHIMe6OjQdZDtCS+FAL+APZSICeY3
	FqqdeYqTMDcuNBgslxX9aPeJ256MGDQ47y9mt6weF6/8XT3NvMzcGIpUH7gGaQ6a
	WjMIk6lHeMF8ME6eigPCUM5mqjqwnm4esaToAU0UFkT86xK87kJQdHErUuoKUF6O
	Lvh6PTVNeAlcJipZg9wS1E/dU3eU2oWUSfiphaLYFB9tui1gNMPCWf9MLiGJ9Kgo
	/J2SHb0afwipAkiYwgtCq4v6yFzx8grNMj7+mqF8pZilWZM0sktB6F4SIRQHphTT
	72OTSg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanweas7m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 13:51:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-91ed0e140c5so191794785a.0
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 06:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783691518; x=1784296318; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=imuof45N7Xdladp2eaUFL5GJzPQRNKl57RWZRExjNv0=;
        b=Oc026SDfNQ0qNjbeEriD9Ay7uccTVca+FWj8GHBtaPcELXv4Bq1sb9V2nNV80O9qHC
         70uutP+ZYXtBt/koY8Q1+uKjlEF8FfIw8UhEvuSTKGHPS7G7R7nOzLS0w4g9vIuqRIG2
         dtYCnA1KQY6NJ/i8IIHhd0ESIOhT1c5O+dB+XZ2huZYuc2Z+o32OhrCiaZoLsz8A63pN
         +910qJtqTKExPTcWc2q2p88jid9PvUR65+CLKAIUWvGOoY+tzDd3ubm2xr2+Q/dj8sJY
         JBWD3EHj3aGfDpVHwod103zuD34z6/itMsWOGW5YcpnQrzMaxwpmTWax+yL/RP2ffWb7
         CnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783691518; x=1784296318;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=imuof45N7Xdladp2eaUFL5GJzPQRNKl57RWZRExjNv0=;
        b=Xr3KzEBsDCeWOBZN2sN/Q7rXkXlqXLGRqAcgJf2BmX+FzVUnbGvWO6ZoI6db1zmO05
         8HkFzk9DrqPiVr+nVHki+GU6JeHggEzrkls3Bs9/DCaX+BOb2LRzRtq3PsKyPy/AXd4A
         QezdQ43YNzVKl4Qvw6u6roZhLCCizuZ12Vx3wEnzVH/UPC9eITFGLOGwiGSW7Hxx7TTn
         Ix0aWzE+3tNl4pFhzYgweW/IXiVMGx510Q8Dw7vXO+fZhig68UY5g4sVZ8Ky7Z0j6W+z
         oHACv3BE3Yf9068PQQkC1z26ac6jD1jHrULvV7PPi9diWuJ+WY/pXEqL4evMI51W1QRR
         55tQ==
X-Forwarded-Encrypted: i=1; AHgh+RrnPLkPqh3QyMMjcBsqFIlIVFog43G4nwLfMn8fQwZtUH0YugH6yEdLXxryF8KF8e0l1/Tf947NoU14@vger.kernel.org
X-Gm-Message-State: AOJu0YwY93PbHODuSQKNzx2zOKkaZmh5nsOW5W+sl/I8fw+wmgGd7uDq
	BhdCYkPYtlBFHlChW4qp9zweOOzhUvJ+DC4in3McRy6YpNc/uvAE0UTusykwliO8jcVdcIlL8ZS
	HmzTyCZThoKjTiMKi5JAiGLd8kAwrVuSawYkqIHi2JRDtgNXQ0UBW+mA3Lw02Jwny
X-Gm-Gg: AfdE7clmNVvbLzxTMMU7d2AMaEHkZKg+xMt05pcm09CzZJmvcwZjLmvE1HTvzigPyZC
	3kwBak3ZPOwVr9Qj8XmWAJESfIPAoVUHFY1tBUvq4btdK/c9Eh27n9sZgL+GkearzDvKSFyPVLr
	eNG6G5b08HqKpUgOz7NS51yFyZeN8fWAvxiAJWrJ9zkEceAT0JYnykhIR7C3fzcpCE/PaV8PncT
	5FYcMF7E4vk7lgpZQVtmT2HS2iaXbbSG6y9zjtp0luhGbki1i7IKQ/3adqWRV17Aoqep3J3XQZ2
	x1rKaBl0YsjUP8yZug1RoX36l+K70dkZ5sxp6XHExiiqPGATPlDDhgAQXfAYPd3nDMmyM8HaAmQ
	IGx3vtfov1vtIjUmSrxqUBOj/kv2tOUGlnkAnIqZ8
X-Received: by 2002:ac8:5f4c:0:b0:51c:e6a:1b5a with SMTP id d75a77b69052e-51c8b2aec7fmr125426861cf.12.1783691518100;
        Fri, 10 Jul 2026 06:51:58 -0700 (PDT)
X-Received: by 2002:ac8:5f4c:0:b0:51c:e6a:1b5a with SMTP id d75a77b69052e-51c8b2aec7fmr125426501cf.12.1783691517650;
        Fri, 10 Jul 2026 06:51:57 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:adb6:d740:6427:4097])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb670a41sm135669295e9.0.2026.07.10.06.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 06:51:56 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:51:23 +0200
Subject: [PATCH v3 4/5] MAINTAINERS: add myself as reviewer of software
 node support
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-swnode-fw-devlink-v3-4-993f31874e40@oss.qualcomm.com>
References: <20260710-swnode-fw-devlink-v3-0-993f31874e40@oss.qualcomm.com>
In-Reply-To: <20260710-swnode-fw-devlink-v3-0-993f31874e40@oss.qualcomm.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-acpi@vger.kernel.org,
        driver-core@lists.linux.dev, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=897;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=wgU5h29ChZnINHlE7+cpZ7/9ziX5loPoQOCDp71wUPw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqUPju14ZePJwCsYAjiYhx8i5rjT5UTbEC9PAiC
 443aOSLN+WJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalD47gAKCRAFnS7L/zaE
 w3UKD/9BiRulUtSRsu+ohMhsfYeNZYC/zsyq35GANqEkhKyU76r8Fli1KjU3pHnabL9XE5f8owq
 14X4eblkJWpyBej453pKePC/c97tcsKEYKPf3UBUSmHBUu8z8nyDonDQrGW4NeuAKI5BQnqFTmt
 isFpnJNKAe4Pq416vnY56HSdM85KZvviEX7mEHxmyITHf+O6C7dy4iMnYojkX5UIvvpAoICDWAa
 HPr0vY7B7Df8O2/vifavIDtUA/Qw3XBgULH3jELalHz/h9OMWcDPmS3jxRaq58M8ZdVSQ8QW0FK
 R39uMNGn+Bv2MflNRLRAHLp/YuBD7TXSQIqaatRARwqXwHn/rkcmM2tkn1MUoRtZDy7P/+FXc9J
 X1nLKucD6UvV2g9zC0iru/vtBpABVt+Mv4QpwahJ33lB6amKOYmFKwsVS+LiLphdOpeY+rj3bUw
 CIuweJjVAVGflWl0cf0zoeUVyZDyoAfHSgfFSpbfrXnAiTrtu2ob6CnOcEKqgZNxowr68H1kd7D
 U3QDBBMFrdUkm294dPJjEHD3njv1IZbuRYQOBR22e68sLUMY/BO9WG+2KaxOEJkgeMzbFmHas7y
 BwG7YdxUgJH7H5UwM+JQbwwcfryU+Rn+Xrk/q3i3R8ulCm73INqvvi1K3xOTTg4sanfjQzZuNHV
 osiKy0L3HjkFuPA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a50f8ff cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=0-iA9D7a5yEsystHw7UA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzNiBTYWx0ZWRfX7WBK5Js6/Mkk
 IJLfpENjmjiSZ2IMMUn45FwKqOohxHHq1b/Lv1BkpmGkV53BUrZ21NQPgmlT8vZkvquCJE/U2pM
 t3qK/M5pis5xgPlaITGqzlPoq1KfsAW2mH0TN7+FLqbadpdCYUWUSiGff1Q7GPtrTOKP0j1sk00
 BZa2/EExodgQcQh7Y6k0NY2O0bZRKmRRgv4X7QtOZTah1G+S7PnugOqHhf9nl3hAivtw7LcCSPU
 Mi3KMONpxxCSRf8eNkjWW232E5uhSVNwP/JNf6TQVjuAcLssRe20eN8sG+k6+sIZTWsvEXrWzpG
 GRptf5UEDw3Tw+1B02dqHW0DB51lo/0UNwWB2/QR8i5iGCPLU2VmYz6rtbRWadroxMcbyuAQ30v
 wLh3NR1x8LanYvJDZMNdl9gWDdeZkvnoA21vEkbTQtlXV/2p43nF4YydCZnf/uSj7aoWXS211R1
 AMqD0zb6dlAHLYM3sEA==
X-Proofpoint-ORIG-GUID: lyRqGQvFfVy2phC_fEHeMYbd9aYa3_O_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzNiBTYWx0ZWRfXyTEczZI23DOD
 i6sBzo6GyzrgfqY9iZjRSELcF88K/MljFYQFpvJeRNQAjjZjMdhapKAuIxcGKBysygaV0jZekw+
 Az506+0jLmIjDcPGjnyXkaLx4oAcK18=
X-Proofpoint-GUID: lyRqGQvFfVy2phC_fEHeMYbd9aYa3_O_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100136

I've been working extensively on software nodes lately and introduced
some changes. Add myself as reviewer so that I can help review any new
proposed changes.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7741614c941ceed9e46e9caea72bad77cfb7618..da886aa69f362f4cb9dc529a26f8dfc67649d7c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25101,6 +25101,7 @@ R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 R:	Daniel Scally <djrscally@gmail.com>
 R:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
 R:	Sakari Ailus <sakari.ailus@linux.intel.com>
+R:	Bartosz Golaszewski <brgl@kernel.org>
 L:	linux-acpi@vger.kernel.org
 S:	Maintained
 F:	drivers/base/property.c

-- 
2.47.3

