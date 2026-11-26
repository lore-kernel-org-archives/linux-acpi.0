Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685801;
	b=2ZAzHmIeVqwmFwbCCsq+xCm9cQrNWXF07rcJRS+FHqLMKVk87t2aU4m1YJ0Fm4lmWq/k
	 9Ge+4l1HV83iyY7qNnTvlL5fUYUwpHc6sGCoLhuR4SgNpQn9LwF32kau7TQnUMyiNiyzU
	 zwpnwmApWzZpqDmej/Vh/gtFeQ08bH1Jm/y9f4kCXa8P/DX8BvK0mOiW2Vm+7PMDnIJKz
	 pRz77DUQcd6mIK61P2cs6yAMSoLTDoUJNzBJisp8GTLhvXDdOMs1xKWsX3P6Jw2z9Gx/V
	 5q5D+eXYKJyaEDutEtprF/UAycqRq7HxHID43xk5DzYCrh9hTPBgSR6JujewLcgySxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685801;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=itd8Y+uchN2HJrYq4RSPlfZt/iDxc9zWsOFSO8a/jcY=;
	b=P0HQI9WjRx0WXFVk3WUdtKKLNxzti6qbCqXmc0pNaYgr5DumQV0Ra3KV2ZkbBeddMVrG
	 5tO5/FPrM2hQTMqnjBNMMK3hTN2r0UgWB/S81j9bX2YDpLwHn7w7YSi/vEBRmqNqnqW+Q
	 wR/ccwKuqDZwL/Fz0yid7C2J8ISUcHMhALUt0IEoJQSH2q3/EnfEnodLlmswKCiYjniG7
	 bFaotGIPqboAsiapoZc2hrOmumEp4n/5oHckY/dS0gFAlHdS8ay2A1LHbr2uiloFW40Uh
	 7Iklb7qGqhd8Svt3z52bjBlCEij4DEn6J0besjZmRzWgvygsXeGl+4o/YUTrAXWGouA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dMy6Z7LM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I2vaB9hO;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFB6606A33C
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 09:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDFB6606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dMy6Z7LM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I2vaB9hO
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7Av0F2594841
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 09:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	itd8Y+uchN2HJrYq4RSPlfZt/iDxc9zWsOFSO8a/jcY=; b=dMy6Z7LMWwf5pGPS
	2AZDGdNSbEwYP5I+l/u+WYa/K+2b+NATEAdkvID55tbjesDfb/Vh9ivf1fkK60uz
	ZiOfh0NSJuoh9L5qrNZ4sog0LDFeB35YDjoDkzds3ZfscSLV+W8RE+ShKgB0+7x7
	9Cc7yeOJF6neNT+4s6w52qh6oeUnWo9H+JxLUSBIt2EJmygnK3DOOH5aVAkRJxpX
	R01paHjxLpYs38GU17uT2h7UvBz+2rkdiahWwX/U93IRdvKZfMPAyjCdeboUFe9e
	ukIHNw4JQcZ/eM38akhROmuBhLLdTuB5VJY9bmJd09+YpKQMbhUac+XWWgl4mTYA
	cub1ZA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662sag89-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 09:36:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f26dd2165so1632663585a.3
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 01:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795685799; x=1796290599; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=itd8Y+uchN2HJrYq4RSPlfZt/iDxc9zWsOFSO8a/jcY=;
        b=I2vaB9hOGl6rTTYtm0uklawhagfX+z29nW3fyxGmv9oXgBKJKmZkijQfneuybGZOHE
         kqitEM1+3gkABmh5/CMOSZe3lekPujw4NPlQ1RnxNQWGUe6LQgEzVd6XC0UtXAEzGAPB
         /Q6+Q886VYCITKRTBEQuc3j+naMeqrPx3kJCqsKxAzs48CKPipgjK3vUU8X0iDKRJLkk
         6wcVrFWD5yyLTbY5HuOiNk3pjHsfb8di4C+XnwhmGK3t97ww8/i2A9rdWxEH7d5li53H
         DyijSiZ5SqWH+UiHmkvAAYfQaQTLARpVJXiCjvk4Kq1XHRKhPXGP569h9UW84yJnCdQb
         1j7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685799; x=1796290599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=itd8Y+uchN2HJrYq4RSPlfZt/iDxc9zWsOFSO8a/jcY=;
        b=gxGQOzihsMvJWOrS9kJLbpXu4iRNjlx+0Mw+8BWorc13Hr7ciCp+aLYWW8IZRQXNqL
         S2sZYNFKvvE5TQfl5vX0BOjWO5LkAeMELx5KAUXu/N1eN5mxxdzhx76n0tbEesZpYwDM
         Org3HUE+X22p6++im8jIInJz+XIsVnIYb/PR4dJjTgIUrlX/O/ZIUZ4B2bBUiR6tX6YV
         aqvPy7eyihVSpBZiXB+TPQjzv1/rRrXvPdSFZsp2GGCsHBum8CMSIcnQhCN+ELaA7Fkw
         4HPn7hvTVWbRbt+6wj1a1YoRlGMfaSOueTeltyIO0xhJTTnRWAO0mOWpvPKUL1dye3MM
         iskA==
X-Gm-Message-State: APuU4Z/wZhrhmN/5cOqPqR6ipdlKeY69Ha3iwqQihfy1SYG4r0JPWqng
	3w8tCS3E2JvW49dioMzI+wclLbhIKFFJmifVjIEE70Q+IU/qy/34EJ3OWJ3aflpDKzqGjM3vM7M
	fK4cBiP4kLornxEyw8ZA8mb2M0uUavhKRwRY/HnQ7eaym1or7zQQE+mspXqGZ3H1c
X-Gm-Gg: AZFdTZcW96h4gA4izH/ZvPValpZdy45OCEQQa4NfIxQWWXFeddjIqVl7AeicGJPfD0c
	v3dFDQP8lyIRQwd5uvmU9CDPS/9iodvYTcWQlN6o+eN880yG4IyB/hq8Yw5W/n9WtheMAbXMlb8
	JMK2vvBX6eRZlZHCBFdkq1FL9DFGhqTYNFgzaPN9zzAuUYO/sIcW+zvuTua6yOAAA3LDuDLaxp3
	mrbBPIjCVDqGndHc9mVAT2zxuf42lE5hdrzQzQEWe7LzZxZh9MTO6KMug3VE4nlm2NeRfdp3JMX
	rtTZzpbGko0hf6xWrGUmQlb/ZLxtRHolrMSi9IK0eZDQsX8d5cD2Wa1jZjo7t+jqWlYwxJCRTZq
	vqvswWJL3RdP8SKyKc48kCrhKBieK5br4QX2WGIiYQ2k86sdx8PrOiLeAfDsNstMeOe7BvGby0T
	9gzw==
X-Received: by 2002:a05:620a:45a2:b0:949:721a:184e with SMTP id af79cd13be357-949ba9cd23bmr3593388485a.36.1795685798532;
        Thu, 26 Nov 2026 01:36:38 -0800 (PST)
X-Received: by 2002:a05:620a:45a2:b0:949:721a:184e with SMTP id af79cd13be357-949ba9cd23bmr3593386085a.36.1795685798129;
        Thu, 26 Nov 2026 01:36:38 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8960068fsm227079335e9.4.2026.11.26.01.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:36:37 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 10:36:23 +0100
Subject: [PATCH v4 06/10] fwnode: define the count_references() fwnode
 operation
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-fwnode-for-each-prop-v4-6-d4b370ecfd52@oss.qualcomm.com>
References: <20261126-fwnode-for-each-prop-v4-0-d4b370ecfd52@oss.qualcomm.com>
In-Reply-To: <20261126-fwnode-for-each-prop-v4-0-d4b370ecfd52@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=uLLErtVyyBCCkNg/MASZUF+mZGiOHH8LUrLC/RKjXs4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrB/2U49UIjunv1TUDqXQxjp7bPV2Mn8id84Kjb
 YrUZdyxJnSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawf9lAAKCRAFnS7L/zaE
 w3CpD/9JCHjjxCL5P+FTpe8F2GGiawr3+FVB3NPlSOloMozb1b7V8YXdCjdR1vtoY5la/byNl5H
 D3m4zYV7rlupbToFkuogWz1vb7oGxeyH5t1/4jjU+X+1YBfeLYnW79JPGe+hEVDrq/HMRuJ5mG/
 XeVugSGOznf5XYmyk1XQQJy6djgaGAUmFv0wzzMk5JQQIJVZg++75XfCNnmQb4Jiu1fT4IZNESC
 vsYOwOqolSWhaauDQR2OLx3TTF8ZgViTLFYQ83kQfUkzHpaWTqP1KB0lPl1HW2EodNCDImALT++
 Ie0rIgLExP+blKqJpbyrPmKV4q2EE9pGTrVvQc6wo2IFFLoegext0vrgevpz8WW032VHCkLLkFd
 8nRXwJ+L1uGpuFuNs7ubaE8fgkAvRs+YIzdS70rxIPj2GhVlMkO3kZsk9uCtx75e1+eVTdPBtzd
 0RNZw9i+WHWdI2YEKUWb40peNv3F7jBxJhNYn32e1TxxbNtIK6BJjLOzDVg4fn6R2gW2BKaVaTb
 J4xlE1FiAfsA4vPH/3qWXETHEJwF4sRZWVGYPQlz27ngasIq/NSgGrISDP/xy8d26Guhxf4Dlbi
 X1n/RvSFXGz+63lB8gxMdUIWBm0lCCTSlshoe+XRIYMaAnwtonNdEwgUOobhN5KpKDVUij8UgWF
 bJAT3U7BA/wMT2Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6b07fda7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=pu8Hlg4PHyDR7New1bsA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: nnQRf-oICqqlnulUWY3JLPck8a9NYFmP
X-Proofpoint-ORIG-GUID: nnQRf-oICqqlnulUWY3JLPck8a9NYFmP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzNyBTYWx0ZWRfX60S82CQqkvUo
 l9MDB1UVi90qumaA6sKhv4c4WgnmjE7Jrw9MGlw7CdPhxU32kDVxdSJSyEHFkuJ0cknvQvXsBPN
 xMXpstwO0FwIxb7YhydBHmr8vYKSTvqcefNxn9BAodbp586i7y8A0NSV1dwoUYrjRouETChhYmw
 Ng3IH+uShmxspEDMQQEVLYsRWIrKpw9AQ1VQWbzn22g+klrLLbslD8GWjSOMJyf7/sn6yhgIzY4
 zg5ybtCJeoFepb1U5Aq6J5vwELxfioss5pc3tq4XFrllCzTzU85VlY8mspfUU1WSkxyzOH1Mqwx
 VVtrSy5/o6XhsCLsDB+LKnz8pg7Ws/uRfmaKAGu9SxqaHaunZKoTi4wBJvPSrPGdPbZpNOa5hlM
 57na0EnkmS0LQyatujv0gG4v0I9VfNUOGuVHs0egp5271w4RCulCTwdjEwJ8jN6dNIMdUMphegZ
 9z0FryOO31gKsgNV2iw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzNyBTYWx0ZWRfX88GqYfCefCG6
 nwg2LNNy/pUlbCzd2saS5NXIEbIg2otTkK/pxm14Y0S3WFcUbFAgUALBeiSvLwrSfZ9HXgzam7u
 50P5pEwETnhLgnGzYGoUz0xWZVnjlt0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260037

Add a new fwnode callback allowing to count all references of given
firmware node.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/fwnode.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 2d7e0b9245d445d473c7317bd27058abe5750b40..15acade60564ddb5f5a48f2235b626466d77dbdf 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -137,6 +137,10 @@ struct fwnode_reference_args {
  * @get_parent: Return the parent of an fwnode.
  * @get_next_child_node: Return the next child node in an iteration.
  * @get_named_child_node: Return a child node with a given name.
+ * @count_references: Return the number of references in a property, including
+ *		      empty ones. @nargs_prop names the property in the
+ *		      referenced node holding the number of arguments, if NULL
+ *		      the references have no arguments.
  * @get_reference_args: Return a reference pointed to by a property, with args
  * @graph_get_next_endpoint: Return an endpoint node in an iteration.
  * @graph_get_remote_endpoint: Return the remote endpoint node of a local
@@ -180,6 +184,8 @@ struct fwnode_operations {
 	struct fwnode_handle *
 	(*get_named_child_node)(const struct fwnode_handle *fwnode,
 				const char *name);
+	int (*count_references)(const struct fwnode_handle *fwnode,
+				const char *prop, const char *nargs_prop);
 	int (*get_reference_args)(const struct fwnode_handle *fwnode,
 				  const char *prop, const char *nargs_prop,
 				  unsigned int nargs, unsigned int index,

-- 
2.47.3

