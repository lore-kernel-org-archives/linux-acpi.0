Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A103DBD4F
	for <linux-acpi@vger.kernel.org>; Thu,  2 Apr 2026 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134496; cv=none; b=PiwB5N9aKu7J18+pmUURWo6Qm+DrjuWzr6T87xI9lFcR/1b69i/fJnOSejmWNAyAcRfDsmSuNuN4IMXUl36UdTvzw9L2ZAlve4kX2EoW5ajw6dohF1ZeTAOOXCcmG77ndQYN4CCtdCYk0UuW19NuohHE9YNmUy0bPWPH8g9JkZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134496; c=relaxed/simple;
	bh=UyVNL9BnEdBHdX0N3vE7Axbnavw0KwKZ6JYxOrxh0qE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jGxXnCbebly5ztlabpLayfYVtoXRd27NTU8u9hEnwij7KN/VGT4pEXtn+n6A4d2evbqojJw/R0szbTbq5axhboWfRzxADjJ09pZ+B4gg+aOQkUPV4V0WVD9FDbMSDtrF0VuleIjBq9wM8ZUxPRLLln0yrzWGEN/gyoRKKuq/dYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ePkQ+ZLP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KIr3iE/8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ePkQ+ZLP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KIr3iE/8"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632C6wBd4009749
	for <linux-acpi@vger.kernel.org>; Thu, 2 Apr 2026 12:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pkL8PdXGCakocYTcwKJcJZjn9BQ6YHeW55eR2rIFD0M=; b=ePkQ+ZLP/FEEdUqP
	H6rB00iOq4YkhjbsYVp2JtMsefxRY7b0V9eVTf3Ez0WZAV70+m0YTiwYG8nNuvIF
	iFul5qEmOsylzEiBKDDnGMQh8NleDFmgi5hoSil74IlJAkSh9iRWxyF2/ZKf3MaP
	1ideIovgSzLm5CWcYpZDZHs/PrgafdP/j+2+Hg9JzTbO2YOIPDsRb9tE4HOqEWtS
	p/rcKlKUVTCE7n4KvLl2oGdbXISZ4nasTbSwoFdzIxNFnajbUZ/aIW8G45N0EHSp
	2vYMAQ59TxBMh0iDTXI/xkCkJEkZPmwhK3+sQziaZet6rrYP2adYw/OZrzpAr281
	tFthSA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d97e044y4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 02 Apr 2026 12:54:48 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5090cc6a7d2so23823111cf.2
        for <linux-acpi@vger.kernel.org>; Thu, 02 Apr 2026 05:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775134488; x=1775739288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkL8PdXGCakocYTcwKJcJZjn9BQ6YHeW55eR2rIFD0M=;
        b=KIr3iE/8hjg0dPI6EVYwaQuwpJPMFkhloiwH+PAGYW0CqlcTmhO9jeeshVf1khL3ne
         ly4/ALZ2ydq9a2omi3e3Yd0J1MsvmUGu7IXDTQH1blWzk4GUeRm8LjU/ecXpynMbe+SG
         mBT8v4l5L7hDMDvUxD5VsIpBFJJojR/4SsDLL3s9pIMXnPApgdWWfETmrXK0UdqQB9ng
         MmJdAAkdVTRNHlHzP010dSJoZa6nI+0I1f/GjGJ398XDN0v1FerK+VAOqM5isypeT+SX
         P18xovdHj3FpZz+iqZgwWOIY4JZlRDYoSaTRz06NEL0Fhag5+01QUfJOdNg1LbYO0BAt
         REag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775134488; x=1775739288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pkL8PdXGCakocYTcwKJcJZjn9BQ6YHeW55eR2rIFD0M=;
        b=TbI5bHx3YFkJA/ejelkpYlVWPDOwuScL6NvtnFuVq6PU+MDR1Zmi8O0orBsAQ9V2yu
         4di+EuEWBAVh49e9IJdB+B7WON62mzYlXrLta+jcODxd7h+FHlw2tO0Gd51lUSi9tH8b
         BdZVuAD54DjnzqnUbHnk3cmJwRnAPJN7l4EGq3UeaoXhXRN+xVR40621ErrwpVIX8lkn
         6i/2yNy3LJ6QcDCYUCxGDuwGWCOExKxiEkHmjZvpUsiZuCIvSTGsia4QPTbfSgvQ8CbT
         urr3vpD1VbY8heMq2liI4cwf61ovPl4Np2onJ3bm3QPC2sZ6s1fCmelN/peBcP9Js1zj
         ecNQ==
X-Gm-Message-State: AOJu0YzO5leJVkqWXyu0ZZxGjkGScKGUL5CyTsMnc2RytomQp8tiIxJV
	STwKL5yLn94PVMdBnSJf+tmkqeOwZpzih8tkNRsCrdFLtKdpZVRAWVIDev+ZdIprkhaqM7PNPIa
	J2guLf4or3BWR5IUWO9x/IE4g3kljAwpQAwPNicwh2gaAYtT5vDdUuRxXYDMnhETR
X-Gm-Gg: ATEYQzybsuarq5PrhBnRqGxPdU3Z8bVF2x/F/TJCpGL6V9rLA5U98d9UbTw9+vawqRC
	swccsPWZVlTgsfxKLk10zVJipV65i8oEzkSaEnuOuMguVBBTZsDgbfYwN7PS7eovcBA569E28iM
	DlW1qzb+GqfaTItfrLbxkqzQN+8H4o8mmaquF9u0uqgo8BoMktJpmuF5g+kljwq4dOn30vvcr7U
	bbHmHVaoqVT+7Pozeh1CEFPI3xdRWTlCrPXdrgpjbbJsmocZj7qxNmhdCmB5swHPIjXZQYphpxt
	VuJ+yKdvzKwpx0XbJRO4jvGBtH/T95E3LL282PWJbIzuV8ajrvrfdk+nZigz/QgzMdABy14o0rW
	cvMw2z6G4xh94zoDsAIBTEipUcopXuNFnwqbR0SQ87m3/c8KZ42OM
X-Received: by 2002:a05:622a:a6cb:b0:50b:41ec:5e84 with SMTP id d75a77b69052e-50d3bb64de1mr92118051cf.12.1775134487697;
        Thu, 02 Apr 2026 05:54:47 -0700 (PDT)
X-Received: by 2002:a05:622a:a6cb:b0:50b:41ec:5e84 with SMTP id d75a77b69052e-50d3bb64de1mr92117751cf.12.1775134487297;
        Thu, 02 Apr 2026 05:54:47 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4ff1:3e57:22ec:dadc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm235790765e9.0.2026.04.02.05.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 05:54:46 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 14:54:26 +0200
Subject: [PATCH v2 1/4] software node: return -ENXIO when referenced swnode
 is not registered yet
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-baytrail-real-swnode-v2-1-6f5054a4cc07@oss.qualcomm.com>
References: <20260402-baytrail-real-swnode-v2-0-6f5054a4cc07@oss.qualcomm.com>
In-Reply-To: <20260402-baytrail-real-swnode-v2-0-6f5054a4cc07@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=UyVNL9BnEdBHdX0N3vE7Axbnavw0KwKZ6JYxOrxh0qE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpzmcP+BIY8RXS90a3xjPBNtfvQM3pMaCvv1JGW
 DHGPZ60AjmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac5nDwAKCRAFnS7L/zaE
 w3c+D/9KXhdti1SkyEeKtFYP4j7R8J0b/1Kk6OkPjGG7BRkDpTirvmAyIzGLElaHdSVbHQcPO74
 DCSwW+mnvKHj6K4iHOHP0rF2HbRvmpssqmUzxXUtZU66ePHgn7e+KFt8a3KtTwUJ4AirsIvv6wU
 oumWwMV4qVfAHVWQlL2mI2jh8guD45k3hLBhzk0JZBCwY7/6JeWmHJn+F+bws0i6SrSq28+dze5
 hEaf6mlV6rlYCRSWs8IqPSPEF2fRl3eKyEBq6Hj/tlQrw5G2JkYIUbPWcSV4WHi7oGmvXPLaP+7
 SzI7yLSLRk6KHMnSO2IcR3QqWoVz9goR9rQWcrnrCT2QoDVSyCG3dXG9H7WL+JRv+BKhwr4Mgss
 X12f5wJ3DgkvsRFQOyXlr5x7Tm5i/yZVsVDnAwv//syUuKfJ4F/NTuoRA2nC+AZ8oY2KVEkSCa3
 CL+s4GIP5epDDogjQrgsSbpKjyNROsAs6JD64+1zQlOmo0LZrMaRLHXFqZC1+TGIHTdoyrHaPZ0
 YbEsZhIa6Grt2aGPQSVXMGrPHzAlajh/YOvhhpBI0u3ST9CeMfhDq4vm9Zec5wCgOSr4m6cyEDW
 CeXrKv2STM1mS8Dl/A1gPR20qWh35tQfMUs04KGD35WViLkKWqtXRNu8Gk+Wad6BMBh7beGmHXs
 wCaqRuxMx0TeJGw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=fdGgCkQF c=1 sm=1 tr=0 ts=69ce6718 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=WW6vG2jIvFMNhbJRSCoA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: P00X4t5XcevmWndOFxS_A_iue6T9iLKk
X-Proofpoint-GUID: P00X4t5XcevmWndOFxS_A_iue6T9iLKk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDExNSBTYWx0ZWRfXzZg/51CILkxO
 gnjrJ6/U3ikqjf5HkO1AV673gmW/i97PeyoFY1fzppvigHVWQVFMi+sDY9eiK0OsqqyrqP6mlnp
 C5+KvG6kjktaYb07Swr/gcf2GRGJnawI9wZGrbF+PAH4+njXtr+hJkOZEJx737myluNdnYZ2I29
 f3aNn3NHYROiwIIvNkKBJ1l6iE+sj6bI1uF8EonQdctMQhXhAFgq+NX7FVl3wCREL0NeMy7cUS2
 M8E4kpN87QF/MjeEs4D9JNx8311aIT+8G6ox3Bm1VYKaGSpTiCsl9G0qS0zXzLgWLEbT4w5a3NT
 +VZ0JqXXVQl3jdeB3BymweZJh0BpMDplRzlmSEO1I/Sp8Bc99mbZKFCuNesHPzQIlsPsGl3d0t3
 2oVLzJi2Pkn39FimRuz5aTIy8MeWFmdG7/a9ImMVfUGPKXBHHJm2B37jMniP+7wHEegEbMfhII6
 u0Nf5lKLwDk3nmaDQSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020115

It's possible that at the time of resolving a reference to a remote
software node, the node we know exists is not yet registered as a full
firmware node. We currently return -ENOENT in this case but the same
error code is also returned in some other cases, like the reference
property with given name not existing in the property list of the local
software node.

It makes sense to let users know that we're dealing with an unregistered
software node so that they can defer probe - the situation is somewhat
similar to there existing a firmware node to which no device is bound
yet - which is valid grounds for probe deferral. To that end: use -ENXIO
which stands for "No such device or address".

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/swnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 51320837f3a9f1bf4f65aa161d9b941affc74936..29eec7ba500e8c8a02482dfac68f2c313cfadee7 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -554,7 +554,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 		return -EINVAL;
 
 	if (!refnode)
-		return -ENOENT;
+		return -ENXIO;
 
 	if (nargs_prop) {
 		error = fwnode_property_read_u32(refnode, nargs_prop, &nargs_prop_val);

-- 
2.47.3

